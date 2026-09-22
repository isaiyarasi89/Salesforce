#!/usr/bin/env bash
# ============================================================
# Sync GitHub issues to match TPICAP_Backlog_Source.md
#   - New TITLE in the .md  -> creates issue + adds to project board
#   - Existing TITLE (exact match) -> updates that issue's body + labels
#   - Nothing is ever duplicated
#   - Any label used in the .md that doesn't exist in the repo yet
#     is automatically created before being applied (no manual step)
#
# USAGE:
#   1. Edit REPO below
#   2. Put this script in the same folder as TPICAP_Backlog_Source.md
#   3. Run: bash sync_github_tickets.sh
# ============================================================

set -e
REPO="isaiyarasi89/Salesforce"      # <-- confirm this is your repo
PROJECT_OWNER="isaiyarasi89"
PROJECT_NUMBER="1"
SOURCE_FILE="TPICAP_Backlog_Source.md"

if [ ! -f "$SOURCE_FILE" ]; then
  echo "ERROR: $SOURCE_FILE not found in this folder."
  exit 1
fi

WORKDIR=$(mktemp -d)
trap 'rm -rf "$WORKDIR"' EXIT

# ---- Ensure every label mentioned in this ticket exists before we use it ----
# Takes a comma-separated label string, creates any that are missing.
ensure_labels_exist() {
  local labels_csv="$1"
  local IFS=','
  for label in $labels_csv; do
    # trim leading/trailing whitespace
    label="$(echo "$label" | sed 's/^ *//;s/ *$//')"
    [ -z "$label" ] && continue
    # gh label create fails harmlessly if it already exists - we just ignore that
    gh label create "$label" --repo "$REPO" --color "0E8A16" >/dev/null 2>&1 || true
  done
}

# ---- Parse the source file into one set of files per ticket ----
awk -v dir="$WORKDIR" '
  /^## TICKET$/ { n++; state="title"; title=""; labels=""; body=""; next }
  /^## END TICKET$/ {
    if (n > 0) {
      titlefile = dir "/ticket_" n "_title.txt"
      labelsfile = dir "/ticket_" n "_labels.txt"
      bodyfile = dir "/ticket_" n "_body.txt"
      printf "%s", title > titlefile
      printf "%s", labels > labelsfile
      printf "%s", body > bodyfile
      close(titlefile); close(labelsfile); close(bodyfile)
    }
    state=""
    next
  }
  n>0 && state=="title" && /^TITLE:/ { sub(/^TITLE:[ ]*/,""); title=$0; state="labels"; next }
  n>0 && state=="labels" && /^LABELS:/ { sub(/^LABELS:[ ]*/,""); labels=$0; state="bodywait"; next }
  n>0 && state=="bodywait" && /^BODY:/ { state="body"; next }
  n>0 && state=="body" { body = body $0 "\n" }
  END { print n > (dir "/count.txt") }
' "$SOURCE_FILE"

COUNT=$(cat "$WORKDIR/count.txt")
echo "Found $COUNT ticket(s) in $SOURCE_FILE"
echo

for i in $(seq 1 "$COUNT"); do
  title=$(cat "$WORKDIR/ticket_${i}_title.txt")
  labels=$(cat "$WORKDIR/ticket_${i}_labels.txt")
  body=$(cat "$WORKDIR/ticket_${i}_body.txt")

  if [ -z "$title" ]; then
    continue
  fi

  # Make sure every label this ticket needs actually exists in the repo first
  if [ -n "$labels" ]; then
    ensure_labels_exist "$labels"
  fi

  # Look for an existing issue with this EXACT title (open or closed)
  number=$(gh issue list --repo "$REPO" --state all --search "\"$title\" in:title" --json number,title \
    --jq ".[] | select(.title == \"$title\") | .number" | head -n1)

  if [ -n "$number" ]; then
    echo "Updating existing issue #$number: $title"
    gh issue edit "$number" --repo "$REPO" --body "$body" --add-label "$labels"
  else
    echo "Creating new issue: $title"
    url=$(gh issue create --repo "$REPO" --title "$title" --body "$body" --label "$labels")
    echo "  -> $url"
    gh project item-add "$PROJECT_NUMBER" --owner "$PROJECT_OWNER" --url "$url"
    echo "  -> added to project board"
  fi
  echo
done

echo "Sync complete."
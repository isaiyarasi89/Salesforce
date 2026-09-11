# Day-to-Day Workflow: Org → Repo → GitHub

Follow this cycle every time a change is made in the trial org (a new Product
Rule, a new field, a new Constraint Rule, etc.).

## Step 0 — Create a feature branch

Rather than committing straight to `main`, start each piece of work on its
own branch. This mirrors how real teams isolate changes before review, and
gives you a clean, nameable unit of work to point to in an interview
("here's the branch and PR where I built the APAC validation rule").

```
git checkout main
git pull origin main
git checkout -b feature/block-enterprise-apac
```

Naming convention used in this repo: `feature/<short-description>`
(e.g. `feature/mdf-bundle`, `feature/rlm-attribute-tiers`,
`feature/apac-discount-price-rule`).

## Step 1 — Retrieve metadata from the org

**CPQ changes** go into the default package directory, `cpq-app`, automatically.
Do **not** pass `--output-dir` — it conflicts with the package directory and
will throw a `RetrieveTargetDirOverlapsPackageError`.

```
sf project retrieve start --target-org mytrialorg --metadata CustomObject:SBQQ__ProductRule__c
```

Add more `--metadata` flags to pull several components in one go:

```
sf project retrieve start --target-org mytrialorg ^
  --metadata CustomObject:SBQQ__ProductRule__c ^
  --metadata CustomField:Quote.Region__c
```

**Revenue Cloud changes** go into the non-default `rlm-app` directory — target
it explicitly with `-p`:

```
sf project retrieve start --target-org mytrialorg --metadata CustomObject:YourRLMObject -p rlm-app
```

## Step 2 — Review what came down

```
git status
git diff
```

Confirm the new/changed files landed in the folder you expect (`cpq-app/...`
or `rlm-app/...`) before staging anything.

## Step 3 — Stage and commit

```
git add cpq-app
git commit -m "Add Block Enterprise in APAC product rule"
```

(or `git add rlm-app` for Revenue Cloud work)

Keep commits scoped to one logical change where possible — it makes the
history genuinely useful later (e.g. as interview talking points), rather
than one giant "various changes" commit.

## Step 4 — Push the feature branch to GitHub

```
git push -u origin feature/block-enterprise-apac
```

(`-u` only needed the first time you push this branch — after that, plain
`git push` works.)

## Step 5 — Open a Pull Request

1. Go to the repo on github.com — it usually shows a banner offering to open
   a PR for the branch you just pushed. Click **Compare & pull request**.
2. Base branch: `main`. Compare branch: your feature branch.
3. Give the PR a title matching the change (e.g. "Add Block Enterprise in
   APAC validation rule") and a short description of what it does and how
   it was tested.
4. Click **Create pull request**.

Since this is a solo practice repo there's no one else to review it, so:

5. Review your own diff on the **Files changed** tab — this habit is worth
   keeping even solo, since it's what catches an accidental extra file or a
   half-finished change before it lands in `main`.
6. Click **Merge pull request** → **Confirm merge**.
7. Optionally delete the branch from GitHub's prompt after merging (keeps
   the branch list tidy without losing any history — the commits stay in
   `main`).

## Step 6 — Sync local `main`

```
git checkout main
git pull origin main
```

Now `main` locally matches what's on GitHub, and you're ready to branch off
again for the next piece of work.

## Deploying to another org (e.g. a second sandbox)

Deploy only the CPQ metadata:

```
sf project deploy start --source-dir cpq-app --target-org <destination-org>
```

Deploy only the Revenue Cloud metadata:

```
sf project deploy start --source-dir rlm-app --target-org <destination-org>
```

Because each product area lives in its own package directory, deployments
stay scoped — pushing CPQ changes never accidentally carries Revenue Cloud
metadata along with it, and vice versa.

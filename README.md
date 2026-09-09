## Git Branching Workflow

This repo uses one feature branch per GitHub Issue/ticket, so every change traces back to a specific task on the [project board](https://github.com/users/isaiyarasi89/projects/1/views/1).

### Branch naming convention

```
SF-<issue-number>
```

- `SF` = **S**ales**F**orce practice repo prefix
- `<issue-number>` = the GitHub Issue number the branch resolves (e.g. Issue #1 → `SF-1`)

Check the issue number on the Issues tab or the project board before branching — don't guess it.

### Workflow

**1. Start from an up-to-date `main`**
```bash
git checkout main
git pull origin main
```

**2. Create a feature branch named after the issue**
```bash
git checkout -b SF-1
```

**3. Do the work, then check status**
```bash
git status
```

**4. Stage and commit, referencing the issue number**
```bash
git add -A
git commit -m "SF-1: Build TP ICAP-style product catalogue (bundle + options)"
```
Commit message format: `SF-<issue-number>: <short description matching the issue title>`

**5. Push the branch to GitHub**
```bash
git push origin SF-1
```

**6. Open a Pull Request**
Follow the URL Git prints after the push (e.g. `https://github.com/isaiyarasi89/Salesforce/pull/new/SF-1`), or run:
```bash
gh pr create --title "SF-1: Build TP ICAP-style product catalogue" --body "Closes #1"
```
Using `Closes #1` in the PR description auto-closes Issue #1 and moves it to Done on the project board when the PR merges.

**7. Merge and clean up**
```bash
git checkout main
git pull origin main
git branch -d SF-1          # delete local branch
git push origin --delete SF-1   # delete remote branch
```

### Quick reference

| Step | Command |
|---|---|
| New branch for Issue #N | `git checkout -b SF-N` |
| Stage all changes | `git add -A` |
| Commit with issue ref | `git commit -m "SF-N: <description>"` |
| Push branch | `git push origin SF-N` |
| Open PR (closes issue) | `gh pr create --title "..." --body "Closes #N"` |
| Clean up after merge | `git branch -d SF-N && git push origin --delete SF-N` |

### Note on line endings (Windows)
You may see this warning on `git add` — it's expected and harmless on Windows:
```
warning: in the working copy of '<file>', LF will be replaced by CRLF the next time Git touches it
```
If you want to silence it permanently, run once: `git config --global core.autocrlf true`

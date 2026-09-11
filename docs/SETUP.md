# Setup

One-time setup steps to get this project working locally. You shouldn't need to
repeat these after the initial setup, except re-authenticating if your org
session expires.

## 1. Install Salesforce CLI

Requires Node.js. Check first:

```
node --version
```

Install the CLI:

```
npm install --global @salesforce/cli
sf --version
```

## 2. Authenticate to the org

```
sf org login web
```

This opens a browser window to log in. Confirm the connection:

```
sf org list
```

Note the **Username** shown (e.g. `isai@cpq.com`) — this is what's used as
`--target-org` in all commands in `WORKFLOW.md`. Optionally set a shorter
alias so you don't have to type the full username each time:

```
sf alias set mytrialorg=isai@cpq.com
```

## 3. Project structure

Project was generated with:

```
sf project generate --name my-salesforce-org
cd my-salesforce-org
mkdir rlm-app
```

`cpq-app` is created automatically as the default package directory — see
`sfdx-project.json` below.

## 4. `sfdx-project.json`

```json
{
  "packageDirectories": [
    {
      "path": "cpq-app",
      "default": true
    },
    {
      "path": "rlm-app",
      "default": false
    }
  ],
  "namespace": "",
  "sourceApiVersion": "60.0"
}
```

This is what tells `sf project retrieve` / `sf project deploy` there are two
separate, independently-deployable areas in this one repo.

## 5. GitHub connection

_(Already set up — kept here for reference if re-cloning on a new machine.)_

```
git init
git remote add origin https://github.com/<username>/<repo-name>.git
git branch -M main
git push -u origin main
```

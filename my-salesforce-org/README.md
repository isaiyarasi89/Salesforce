# Salesforce DX Project

Salesforce DX is a development approach that brings source-driven development, team collaboration, and continuous integration to the Salesforce Platform. Instead of working directly in an org through a web browser, you work with metadata as source files in a local DX project, track changes in version control, and deploy through automated processes.

This project template gets you started with the tools and structure you need to build Salesforce applications using source control, scratch orgs, and the Salesforce CLI.

## Prerequisites

Before you start, make sure you have:

- **Salesforce CLI** - Download from [developer.salesforce.com/tools/salesforcecli](https://developer.salesforce.com/tools/salesforcecli). See [Install Salesforce CLI](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm) for details.
- **VS Code with Salesforce Extension Pack** - See [Installation Instructions](https://developer.salesforce.com/docs/platform/sfvscode-extensions/guide/install.html) for details. Includes the Agentforce Vibes extension.
- **A development org** - Sign up for a free Developer Edition org [here](https://developer.salesforce.com/signup).
- **Dev Hub enabled** (optional, required to create scratch orgs) - You can enable Dev Hub in your development org under Setup > Dev Hub.  See [Provide Developers Access to Salesforce DX Tools](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_setup_dx_tools.htm).

## Project Structure

Your DX project follows this structure:

- **`force-app/main/default/`** - Your metadata source files live in this default package directory. You can configure additional package directories in the `sfdx-project.json` file.
- **`config/`** - Scratch org definitions and project settings
- **`scripts/`** - Automation scripts for common tasks
- **`sfdx-project.json`** - Project manifest that defines package directories, namespace, API version, and other project-level settings

See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm).

## Get Started

Ready to start developing? The [Get Started with Salesforce DX](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_get_started_dx.htm) guide walks you through your first project, from creating a scratch org to creating a simple Apex class or LWC to deploying your code to a sandbox.

## Common Salesforce CLI Commands

Here are common CLI commands that you'll use the most:

- `sf org login web`: Authorize an org
- `sf org open`: Open your org in a browser
- `sf org create scratch`: Create a scratch org
- `sf project deploy start`: Deploy metadata to your org
- `sf project retrieve start`: Retrieve metadata from your org
- `sf template generate <artifact>`: Scaffold new components, such as Apex classes and triggers, LWC components, Lightning apps, and more
- `sf apex <command>`: Run Apex tests, run anonymous Apex blocks, and view logs
- `sf data <command>`: Work with test data
- `sf alias <command>`: Manage org aliases
- `sf config <command>`: Configure CLI settings

# Salesforce CPQ Practice — Git + SFDX Workflow

Personal reference for pulling Salesforce CPQ config (metadata AND data) into this
git repo, and pushing it back. Written while practicing on a Developer Edition org
with the CPQ managed package installed.

## Prerequisites (one-time setup)

- **Git** — install from git-scm.com, verify with `git --version`
- **VS Code** — install from code.visualstudio.com, with the Salesforce Extension Pack
- **Salesforce CLI (`sf`)** — install from developer.salesforce.com/tools/salesforcecli,
  verify with `sf --version`

> ⚠️ **Terminal note:** `sf` commands (especially `sf data export tree` /
> `sf data import tree`) can fail in **Git Bash** on Windows with an unrelated-looking
> error (`'C:\Program' is not recognized...`). If that happens, run the exact same
> command in **PowerShell** instead. Git Bash is still fine for plain `git` commands.

## Connecting to your org

```bash
sf org login web --alias mydevorg
sf alias set mydevorg <your-username>       # if the alias didn't get set automatically
sf config set target-org=mydevorg --global  # --global avoids needing a project folder
sf org list                                 # confirms alias + default org
```

## Project structure

Your actual SFDX project (the folder containing `sfdx-project.json` and `force-app`)
may be nested deeper than your repo root — e.g. `Repo/Salesforce/my-salesforce-org/`.
Always `cd` into that exact folder before running `sf project` or `sf data` commands.

Data exports (see below) live in their own top-level `data/` folder, separate from
`force-app/`, to keep a clear line between deployable metadata and data-tree exports:

```
my-salesforce-org/
├── force-app/          <- metadata (fields, flows, objects, etc.)
├── data/                <- CPQ config exported as data (Product Rules, Price Rules...)
│   ├── productRule/
│   └── priceRule/
└── sfdx-project.json
```

## Metadata vs Data — the core distinction

| | Examples | Tool |
|---|---|---|
| **Metadata** | Custom fields, Flows, Apex, Validation Rules, page layouts | `sf project retrieve` |
| **Data** | Product Rule, Price Rule, Price Condition, Price Action, Product2 records | `sf data export/import tree` |

CPQ's actual configuration (rules, conditions, actions) is stored as **records**, not
metadata — `sf project retrieve` will never pull these down.

## Pulling metadata changes (e.g. a new field on Quote or Product Option)

```bash
# Pull ALL fields/list views/etc. on an object (safer when you don't know the exact field name):
sf project retrieve start --metadata CustomObject:SBQQ__Quote__c
sf project retrieve start --metadata CustomObject:SBQQ__ProductOption__c

# Pull a SPECIFIC known field:
sf project retrieve start --metadata CustomField:SBQQ__Quote__c.YourFieldName__c

# Multiple metadata types at once — use SPACES, not commas:
sf project retrieve start --metadata Flow CustomField ValidationRule
```

## Pulling CPQ config changes (Product Rules, Price Rules, etc.)

**Step 1 — confirm the child relationship name** (only needed once per object; these
can vary slightly by package version):
Setup → Object Manager → [the child object, e.g. Price Condition] → find the lookup
field back to the parent → note its **Child Relationship Name**.

If unsure, just guess the standard Salesforce pluralization pattern
(`SBQQ__PriceConditions__r`, `SBQQ__PriceActions__r`, etc.) — a wrong guess returns
a clear error naming the correct relationship.

**Step 2 — export the record + its children as JSON:**

```bash
# Product Rule example:
sf data export tree --query "SELECT Id, Name, SBQQ__Type__c, (SELECT Id, Name FROM SBQQ__ProductActions__r), (SELECT Id, Name FROM SBQQ__ErrorConditions__r) FROM SBQQ__ProductRule__c WHERE Name = 'Your Rule Name'" --plan --output-dir data/productRule --target-org mydevorg

# Price Rule example:
sf data export tree --query "SELECT Id, Name, SBQQ__Active__c, SBQQ__EvaluationOrder__c, (SELECT Id, Name FROM SBQQ__PriceConditions__r), (SELECT Id, Name FROM SBQQ__PriceActions__r) FROM SBQQ__PriceRule__c WHERE Name = 'Tier 1 Pricing'" --plan --output-dir data/priceRule --target-org mydevorg
```

**Step 3 — commit:**

```bash
git add data/productRule data/priceRule
git commit -m "Export updated Product Rule and Price Rule config from org"
git push
```

**Step 4 — round-trip test (re-import to confirm it works):**

```bash
sf data import tree --plan data/priceRule/<generated>-plan.json --target-org mydevorg
```

## Common errors and fixes

| Error | Cause | Fix |
|---|---|---|
| `No default environment found` | No default org set | `sf config set target-org=<alias> --global` |
| `does not contain a valid Salesforce DX project` | Wrong folder / missing `sfdx-project.json` | `cd` into the actual project subfolder |
| `Missing metadata type definition in registry for id 'A,B,C'` | Commas used between metadata types | Use spaces instead: `--metadata A B C` |
| `Entity of type 'CustomField' named 'X' cannot be found` | Used object name where a field name was expected | Use `CustomObject:X` to pull the whole object instead |
| `'C:\Program' is not recognized...` (Git Bash only) | Git Bash path-quoting quirk with `sf data` commands | Run the same command in PowerShell instead |
| `could not add label: 'X' not found` (in `sync_github_tickets.sh`) | GitHub label doesn't exist yet | `gh label create "X"`, or use the auto-create version of the sync script |

## Notes / gotchas

- Data-tree exports commit fine to a **private** repo of practice/dev-org data. Never
  commit real customer names, contracted prices, or production data this way.
- Price Actions/Product Actions can reference other records (e.g. Product2) by lookup —
  importing into a *different* org can fail if that referenced record doesn't exist there.


## Use Agentforce Vibes to Build Lightning Apps

Transform your ideas into custom Lightning apps that extend CRM workflows directly in Lightning Experience. Through natural conversations with Agentforce Vibes, implement custom objects and fields, complex business logic, and dynamic UI components. See [Build a Lightning App Using Agentforce Vibes](https://developer.salesforce.com/docs/platform/einstein-for-devs/guide/lexapp-overview.html).

## Additional Resources

- [Agentforce Vibes Developer Guide](https://developer.salesforce.com/docs/platform/einstein-for-devs/guide/einstein-overview.html)
- [Salesforce CLI Installation Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/)
- [Salesforce CLI Plugin Development Guide](https://developer.salesforce.com/docs/platform/salesforce-cli-plugin/guide/conceptual-overview.html)
- [Salesforce VS Code Extensions Documentation](https://developer.salesforce.com/tools/vscode/)


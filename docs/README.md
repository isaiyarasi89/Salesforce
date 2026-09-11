# my-salesforce-org

Personal practice repo for Salesforce CPQ and Revenue Cloud configuration, used to
rebuild and refresh hands-on Salesforce skills. This repo tracks **metadata only**
(fields, Product Rules, Price Rules, objects, etc.) retrieved from a Developer
Edition trial org via Salesforce CLI.

## Docs

- [`docs/SETUP.md`](docs/SETUP.md) — one-time CLI, org auth, and GitHub setup
- [`docs/WORKFLOW.md`](docs/WORKFLOW.md) — day-to-day retrieve → commit → push → deploy cycle
- [`docs/PROJECT_LOG.md`](docs/PROJECT_LOG.md) — running log of what's been built, for interview reference

## Repo Structure

```
my-salesforce-org/
├── cpq-app/              # Salesforce CPQ metadata (default package directory)
│   └── main/default/
├── rlm-app/              # Revenue Cloud metadata
│   └── main/default/
├── docs/
│   ├── SETUP.md
│   ├── WORKFLOW.md
│   └── PROJECT_LOG.md
├── sfdx-project.json     # Defines the two package directories above
└── README.md
```

### Why two package directories?

CPQ and Revenue Cloud both live in the **same Salesforce org** — there's no
technical separation between them at the org level. Splitting them into two
package directories is a manual organizational choice, done so that:

- Deployments can target just one area at a time
  (`sf project deploy start --source-dir cpq-app` vs `--source-dir rlm-app`)
- It's clear, when browsing the repo or reviewing commit history, which
  metadata belongs to which product line
- It mirrors how a real team might separate concerns if CPQ and Revenue
  Cloud work were owned by different people or rolled out in different phases

**`cpq-app`** — Salesforce CPQ metadata: Product Rules (`SBQQ__ProductRule__c`),
Price Rules (`SBQQ__PriceRule__c`), Product2 configuration fields
(`SBQQ__ConfigurationType__c`), custom Quote/Quote Line fields used by CPQ logic.

**`rlm-app`** — Revenue Cloud metadata: Attribute Definitions, Constraint Rules,
Price Adjustment Schedules, and any Revenue Cloud–specific objects/fields.

> **Note:** Only *metadata* lives here. Actual records — Product2 rows, Price Book
> Entries, Product Option records, Quotes — are *data*, not metadata, and are not
> tracked in this repo. Those are managed directly in the org or via Data Loader.

## Metadata vs. Data — Quick Reference

| Type | Examples | How it moves |
|---|---|---|
| **Metadata** | Product Rules, Price Rules, Constraint Rules, Attribute Definitions, custom fields, Flows, Page Layouts | This repo, via `sf project retrieve` / `sf project deploy` |
| **Data** | Product2 records, Price Book Entries, Product Option records, Quotes, Accounts | Data Loader / `sf data` commands — not tracked in Git |

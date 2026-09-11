# Project Log

A running log of what's been built in this practice org, for interview
reference. Update this each time a meaningful piece is finished — it's
meant to help reconstruct "what did I actually build, and in what order"
without digging back through commit history.

## Scenario

Regional Market Data Feed subscription — a "Market Data Feed" bundle sold in
Standard / Premium / Enterprise tiers, where Enterprise is restricted from
APAC customers, and APAC customers get a 10% regional discount. Built once
in CPQ, then rebuilt in Revenue Cloud to compare implementation approaches.

## CPQ Build

- Created `Market Data Feed` bundle product with `MDF - Standard`,
  `MDF - Premium`, `MDF - Enterprise` as Product Options under a
  "Service Tier" Product Feature
- Added `Region__c` picklist field on Quote (EMEA / NA / APAC)
- Building: "Block Enterprise in APAC" Product Rule (Validation type) using
  two Error Conditions (Region = APAC, Product Code = MDF-ENT) joined with
  AND logic
- Next: Price Rule for 10% APAC discount

## Revenue Cloud Build

- Not started yet — will model tiers as an attribute-based configuration on
  a single product, and use a Constraint Rule in place of the CPQ
  Validation Rule, for direct comparison

## Notes for Interview Framing

- Deliberately built the same scenario twice to be able to speak to the
  practical differences between CPQ's bundle/feature model and Revenue
  Cloud's attribute-based model, not just the definitions
- Metadata (Product Rules, fields, Constraint Rules) is version-controlled
  via Git/Salesforce CLI; data (Product2 records, Price Book Entries) is
  managed directly in-org, consistent with how these are handled
  differently in real deployment pipelines

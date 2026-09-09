# TP ICAP Practice Backlog — Source File
# ============================================================
# HOW TO ADD A NEW TASK:
#   Copy a whole block from "## TICKET" to "## END TICKET" (inclusive),
#   paste it at the bottom, and fill in your own TITLE / LABELS / BODY.
#   Then run: bash sync_github_tickets.sh
#   - New titles -> creates a new issue + adds it to your project board
#   - Existing titles (exact match) -> updates that issue's body/labels
#   - Nothing is ever duplicated
# ============================================================

## TICKET
TITLE: Day 1 (CPQ): Build TP ICAP-style product catalogue (bundle + options)
LABELS: track:cpq,area:product-config,difficulty:beginner,sprint:1
BODY:
## Business Requirement
InterBroke Markets sells three product lines: Market Data Subscriptions, Voice Broking Services, and Post-Trade/Risk Services. A sales rep needs to quote "Market Data – EMEA Tier 2" with an optional Post-Trade add-on, and the option list should change depending on the client's region.

## Skills Being Tested
- Product2 / bundle structure
- Features and Options
- Configuration Attributes

## Task
1. Create Product2 records: Market Data Subscription (bundle parent), Voice Broking Service, Post-Trade Service, Risk Analytics Add-on.
2. Add a Feature "Add-ons" containing Post-Trade Service and Risk Analytics Add-on as Options.
3. Add a Configuration Attribute Region (picklist: UK, US, APAC).
4. Ensure Price Book entries exist for every product.

## Acceptance Criteria
- [ ] Market Data Subscription exists as an active bundle Product2
- [ ] Post-Trade Service and Risk Analytics Add-on are Options under the Feature
- [ ] Region Configuration Attribute is visible on the configuration screen
- [ ] All products have an active Price Book Entry
- [ ] Adding the bundle to a Quote opens configuration showing Options and Region

## Test Scenarios
1. Add the bundle to a Quote, confirm Options and Region attribute are visible.
2. Set Region = UK, select Post-Trade Service, save, confirm child Quote Line is created.
3. Change Region to APAC, reopen configuration, note option visibility.

## Interview Prep
"Walk me through how you modelled a bundled product with regional variants."
## END TICKET

## TICKET
TITLE: Day 1 (Revenue Cloud): Product Catalog Management equivalent
LABELS: track:revenue-cloud,area:product-config,difficulty:beginner,sprint:1
BODY:
## Business Requirement
Same bundle as the CPQ version, rebuilt using Revenue Cloud's attribute-based Product Catalog Management.

## Task
1. Create the same four products in Revenue Cloud.
2. Model "Add-ons" and "Region" as Attribute Definitions under a Product Classification instead of CPQ Feature/Option.
3. Confirm they render on the Transaction Line Editor.

## Acceptance Criteria
- [ ] Products have a Product Classification assigned
- [ ] Region and Add-ons are modelled as Attribute Definitions
- [ ] Transaction Line Editor shows the attributes when the product is added
- [ ] You can map CPQ Feature/Option -> Revenue Cloud Attribute Definition + Product Classification

## Test Scenarios
1. Add the product to a Quote/Transaction, confirm the attribute picker shows Region and Add-ons.
2. Select values and confirm they save to the transaction line.

## Interview Prep
"How does attribute-based configuration in Revenue Cloud replace CPQ Feature/Option bundles?"
## END TICKET

## TICKET
TITLE: Day 2 (CPQ): Region-based Product Rule restricting Post-Trade add-on
LABELS: track:cpq,area:product-config,difficulty:intermediate,sprint:1
BODY:
## Business Requirement
Post-Trade Service can only be sold in UK/EMEA for regulatory reasons; APAC reps must be blocked with a clear message.

## Task
1. Create a Validation Product Rule scoped to the bundle.
2. Error Condition: Region = APAC AND Post-Trade Service selected.
3. (Advanced) Add a Filter Rule to hide the option entirely for APAC instead of erroring.

## Acceptance Criteria
- [ ] Validation Rule exists and is active
- [ ] Error Condition correctly evaluates Region = APAC AND Post-Trade selected
- [ ] Saving in that state is blocked with a clear message
- [ ] UK/US + Post-Trade saves successfully
- [ ] You can explain Validation Rule vs Filter Rule

## Test Scenarios
1. Region = APAC + Post-Trade selected -> expect blocking error.
2. Region = UK + Post-Trade selected -> expect success.
3. Region = APAC, Post-Trade removed -> expect success.

## Interview Prep
This maps to your real TP ICAP project — verify before answering: did you use a Validation Rule, Filter Rule, or both? What was the actual business reason?
## END TICKET

## TICKET
TITLE: Day 2 (Revenue Cloud): Product Qualification/Eligibility rule equivalent
LABELS: track:revenue-cloud,area:product-config,difficulty:intermediate,sprint:1
BODY:
## Business Requirement
Same restriction as the CPQ version, using Revenue Cloud's eligibility/qualification framework.

## Task
1. Create a Qualification/Eligibility Rule excluding Post-Trade Service when Region = APAC.
2. Attach it to the relevant Product Selling Model / Price Book.

## Acceptance Criteria
- [ ] Rule exists and references Region = APAC
- [ ] Post-Trade Service does not appear when Region = APAC
- [ ] Post-Trade Service is sellable when Region = UK/US
- [ ] You can explain how this differs from a CPQ Product Rule in evaluation timing

## Test Scenarios
1. New transaction, Region = APAC -> Post-Trade excluded from product list.
2. Region = UK -> Post-Trade becomes available.

## Interview Prep
"How do Revenue Cloud eligibility rules compare to CPQ Product Rules in terms of when they're evaluated?"
## END TICKET

## TICKET
TITLE: Day 3 (CPQ): Contracted & tiered pricing for Market Data
LABELS: track:cpq,area:pricing,difficulty:intermediate,sprint:1
BODY:
## Business Requirement
Market Data pricing varies by tier (Tier 1 £500/mo, Tier 2 £350/mo, Tier 3 £200/mo); large clients negotiate a Contracted Price.

## Task
1. Create three tiered Price Book Entries.
2. Build a volume Discount Schedule (5+ units = 5%, 20+ = 10%).
3. Create a Contract with a Contracted Price for Tier 2 below list.
4. Quote for that Account and confirm the contracted price applies automatically.

## Acceptance Criteria
- [ ] Three tiered Price Book Entries exist
- [ ] Discount Schedule triggers correctly at 4 vs 5 vs 20 units
- [ ] Contracted Price exists on the test Account/Contract
- [ ] New Quote defaults to contracted price, not list price
- [ ] You can state the full price waterfall: List -> Special -> Discount -> Contracted/Customer -> Net

## Test Scenarios
1. Quote without contract -> list price used.
2. Quote with contract -> contracted price overrides list.
3. Add 5 units without contract -> 5% discount tier applies.

## Interview Prep
"Explain the price waterfall in CPQ using a real example." Flag illustrative numbers vs confirmed TP ICAP figures.
## END TICKET

## TICKET
TITLE: Day 3 (Revenue Cloud): Price Books + Pricing Procedure equivalent
LABELS: track:revenue-cloud,area:pricing,difficulty:intermediate,sprint:1
BODY:
## Business Requirement
Recreate Day 3 CPQ pricing using Revenue Cloud's pricing engine.

## Task
1. Set up the same three tiers in a Revenue Cloud Price Book.
2. Build a Price Adjustment Schedule matching the CPQ discount breakpoints.
3. Build a Pricing Procedure (Conditions + Actions) to replicate the waterfall.

## Acceptance Criteria
- [ ] Price Book has correct tiered pricing
- [ ] Price Adjustment Schedule matches the 4 vs 5 vs 20 unit breakpoints
- [ ] Pricing Procedure produces the same net price as the CPQ scenario for identical inputs
- [ ] You can map each CPQ pricing concept to its Revenue Cloud equivalent

## Test Scenarios
Repeat the three CPQ test cases in Revenue Cloud and confirm matching output prices.

## Interview Prep
"How do Pricing Procedures compare to Price Rules + Conditions + Actions in CPQ?"
## END TICKET

## TICKET
TITLE: Day 4 (CPQ): Annual 5% price increase at renewal, excluding fixed contracts
LABELS: track:cpq,area:pricing,area:contracts-renewals,difficulty:advanced,sprint:1
BODY:
## Business Requirement
All Market Data subscriptions get a 5% annual uplift at renewal, except clients on a 3-year fixed-price contract.

## Task
1. Set up a subscription at £100 with an active Contract.
2. Generate a Renewal Opportunity and Renewal Quote.
3. Apply 5% uplift via a Price Rule.
4. Add a second Account flagged fixed-price and confirm exclusion.
5. Verify compounding: Year 1 £100 -> Year 2 £105 -> Year 3 £110.25.

## Acceptance Criteria
- [ ] Renewal Quote generates correctly from the expiring Subscription
- [ ] Standard renewal shows 5% increase over prior contracted price
- [ ] Fixed-price renewal shows NO change
- [ ] Compounding math correct across 3 years
- [ ] You've identified (or flagged "to verify") whether your real project used a Price Rule, batch Apex, or manual updates

## Test Scenarios
1. Renew standard subscription -> new price = old x 1.05.
2. Renew fixed-price subscription -> unchanged.
3. Run 3 consecutive annual renewals -> confirm compounding, not flat 5% off original base.

## Interview Prep
⚠️ Real project area — verify before presenting as fact. Was uplift automatic or manual? Was there a batch job? Was the % set per-product, per-client, or company-wide?
## END TICKET

## TICKET
TITLE: Day 4 (Revenue Cloud): Renewal/Amendment uplift equivalent
LABELS: track:revenue-cloud,area:pricing,area:contracts-renewals,difficulty:advanced,sprint:1
BODY:
## Business Requirement
Recreate the annual uplift scenario using Revenue Cloud's Asset-based Ordering renewal/amendment model.

## Task
1. Create an Asset representing the £100 subscription.
2. Trigger a Renewal transaction, apply 5% uplift via Pricing Procedure or manual amendment.
3. Exclude a fixed-price Asset from the uplift.
4. Verify the same 3-year compounding numbers.

## Acceptance Criteria
- [ ] Asset correctly represents the subscription pre-renewal
- [ ] Renewal produces a new Asset/Order line at the uplifted price
- [ ] Fixed-price Asset renews unchanged
- [ ] 3-year compounding matches the CPQ version exactly
- [ ] You can describe how Assets track price history differently from CPQ Subscriptions + Contracted Price

## Test Scenarios
Same three scenarios as the CPQ version, run against Assets.

## Interview Prep
"What changes at the data model level moving from CPQ Subscriptions to Revenue Cloud Assets for renewals?"
## END TICKET

## TICKET
TITLE: Day 5 (CPQ+Billing): Subscription to Invoice flow
LABELS: track:cpq,area:billing-invoicing,difficulty:intermediate,sprint:1
BODY:
## Business Requirement
Once a Market Data subscription quote is signed, it must generate recurring monthly invoices.

## Task
1. Take a signed Quote through to Contract and Subscription.
2. If Billing package is available: set up an Invoice Scheduler and generate an invoice.
3. If not: document the design — objects/fields carrying data from Subscription to Invoice, and what triggers generation.

## Acceptance Criteria
- [ ] Contract and Subscription exist, linked to the original Quote
- [ ] EITHER an actual Invoice is generated matching quantity x net price, OR a design doc exists
- [ ] You can name every object in the chain end to end

## Test Scenarios
1. If Billing available: generate invoice, confirm amount matches subscription net price x quantity.
2. Trace one product from Quote Line to Invoice Line (or documented equivalent).

## Interview Prep
"How did quote-to-cash flow from Quote to Invoice in your implementation?" Confirm whether TP ICAP used Salesforce Billing, a third-party system, or manual invoicing before answering.
## END TICKET

## TICKET
TITLE: Day 5 (Revenue Cloud): Native Billing - Invoice + usage-based option
LABELS: track:revenue-cloud,area:billing-invoicing,difficulty:intermediate,sprint:1
BODY:
## Business Requirement
Recreate invoicing using Revenue Cloud native Billing, plus a usage-based variant for Market Data (billed per feed consumed).

## Task
1. Set up a Billing Treatment and Invoice Schedule against the Asset.
2. Generate an invoice preview for the flat-fee subscription.
3. Model a usage-based Billing Treatment and simulate one billing cycle with sample usage data.

## Acceptance Criteria
- [ ] Invoice Schedule and Billing Treatment linked to the correct Asset
- [ ] Flat-fee invoice preview generates with correct amount
- [ ] Usage-based Billing Treatment produces a different, consumption-driven amount
- [ ] You can list 2+ billing models Revenue Cloud supports natively that CPQ+Billing could not handle as cleanly

## Test Scenarios
1. Generate flat-fee invoice, confirm amount.
2. Apply sample usage (e.g. 1,200 feed accesses at £0.05 each), confirm invoice reflects consumption.

## Interview Prep
"What billing models does Revenue Cloud support that CPQ+Billing couldn't handle as natively?"
## END TICKET

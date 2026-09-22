# Meridian Cyber Defense — Alternate Practice Backlog
# ============================================================
# PURPOSE: Same skills/concepts as your TP ICAP backlog, different company,
# products, and numbers — so you practice reasoning through the CPQ/Revenue
# Cloud logic fresh instead of recalling memorized answers.
#
# This is a SEPARATE file from TPICAP_Backlog_Source.md. If you want these
# synced as GitHub issues too, merge the tickets you want into your main
# source file and run: bash sync_github_tickets.sh
# ============================================================

## TICKET
TITLE: Day 1 (CPQ): Build Meridian-style product catalogue (bundle + options)
LABELS: track:cpq,area:product-config,difficulty:beginner,sprint:alt-1
BODY:
## Business Requirement
Meridian Cyber Defense sells three product lines: Threat Intelligence Feeds, Managed SOC Monitoring, and Incident Response Retainers. A sales rep needs to quote "Threat Intelligence Feed – Enterprise Tier" with an optional Incident Response add-on, and the option list should change depending on the client's data-residency region.

## Skills Being Tested
- Product2 / bundle structure
- Features and Options
- Configuration Attributes

## Task
1. Create Product2 records: Threat Intelligence Feed (bundle parent), Managed SOC Monitoring, Incident Response Retainer, Dark Web Monitoring Add-on.
2. Add a Feature "Add-ons" containing Incident Response Retainer and Dark Web Monitoring Add-on as Options.
3. Add a Configuration Attribute "Coverage Region" (picklist: North America, EU, APAC).
4. Ensure Price Book entries exist for every product.

## Acceptance Criteria
- [ ] Threat Intelligence Feed exists as an active bundle Product2
- [ ] Incident Response Retainer and Dark Web Monitoring Add-on are Options under the Feature
- [ ] Coverage Region Configuration Attribute is visible on the configuration screen
- [ ] All products have an active Price Book Entry
- [ ] Adding the bundle to a Quote opens configuration showing Options and Coverage Region

## Test Scenarios
1. Add the bundle to a Quote, confirm Options and Coverage Region attribute are visible.
2. Set Coverage Region = EU, select Incident Response Retainer, save, confirm child Quote Line is created.
3. Change Coverage Region to APAC, reopen configuration, note option visibility.

## Interview Prep
"Walk me through how you modelled a bundled product with regional variants." (Practice answering this using Meridian's structure without referencing your notes from the TP ICAP version.)
## END TICKET

## TICKET
TITLE: Day 1 (Revenue Cloud): Product Catalog Management equivalent — Meridian
LABELS: track:revenue-cloud,area:product-config,difficulty:beginner,sprint:alt-1
BODY:
## Business Requirement
Same bundle as the CPQ version, rebuilt using Revenue Cloud's attribute-based Product Catalog Management.

## Task
1. Create the same four products in Revenue Cloud.
2. Model "Add-ons" and "Coverage Region" as Attribute Definitions under a Product Classification instead of CPQ Feature/Option.
3. Confirm they render on the Transaction Line Editor.

## Acceptance Criteria
- [ ] Products have a Product Classification assigned
- [ ] Coverage Region and Add-ons are modelled as Attribute Definitions
- [ ] Transaction Line Editor shows the attributes when the product is added
- [ ] You can map CPQ Feature/Option -> Revenue Cloud Attribute Definition + Product Classification

## Test Scenarios
1. Add the product to a Quote/Transaction, confirm the attribute picker shows Coverage Region and Add-ons.
2. Select values and confirm they save to the transaction line.

## Interview Prep
"How does attribute-based configuration in Revenue Cloud replace CPQ Feature/Option bundles?"
## END TICKET

## TICKET
TITLE: Day 2 (CPQ): Region-based Product Rule restricting Incident Response add-on
LABELS: track:cpq,area:product-config,difficulty:intermediate,sprint:alt-1
BODY:
## Business Requirement
Incident Response Retainer requires on-site staff presence Meridian only has in North America and the EU; APAC reps must be blocked with a clear message due to lack of coverage.

## Task
1. Create a Validation Product Rule scoped to the bundle.
2. Error Condition: Coverage Region = APAC AND Incident Response Retainer selected.
3. (Advanced) Add a Filter Rule to hide the option entirely for APAC instead of erroring.

## Acceptance Criteria
- [ ] Validation Rule exists and is active
- [ ] Error Condition correctly evaluates Coverage Region = APAC AND Incident Response selected
- [ ] Saving in that state is blocked with a clear message
- [ ] NA/EU + Incident Response saves successfully
- [ ] You can explain Validation Rule vs Filter Rule

## Test Scenarios
1. Coverage Region = APAC + Incident Response selected -> expect blocking error.
2. Coverage Region = EU + Incident Response selected -> expect success.
3. Coverage Region = APAC, Incident Response removed -> expect success.

## Interview Prep
Compare this to your TP ICAP Region Product Rule: same underlying pattern (region-based exclusion), different business driver (staff coverage vs. regulatory restriction). Can you articulate both business reasons clearly and not conflate them?
## END TICKET

## TICKET
TITLE: Day 2 (Revenue Cloud): Product Qualification/Eligibility rule equivalent — Meridian
LABELS: track:revenue-cloud,area:product-config,difficulty:intermediate,sprint:alt-1
BODY:
## Business Requirement
Same restriction as the CPQ version, using Revenue Cloud's eligibility/qualification framework.

## Task
1. Create a Qualification/Eligibility Rule excluding Incident Response Retainer when Coverage Region = APAC.
2. Attach it to the relevant Product Selling Model / Price Book.

## Acceptance Criteria
- [ ] Rule exists and references Coverage Region = APAC
- [ ] Incident Response Retainer does not appear when Coverage Region = APAC
- [ ] Incident Response Retainer is sellable when Coverage Region = NA/EU
- [ ] You can explain how this differs from a CPQ Product Rule in evaluation timing

## Test Scenarios
1. New transaction, Coverage Region = APAC -> Incident Response excluded from product list.
2. Coverage Region = EU -> Incident Response becomes available.

## Interview Prep
"How do Revenue Cloud eligibility rules compare to CPQ Product Rules in terms of when they're evaluated?"
## END TICKET

## TICKET
TITLE: Day 3 (CPQ): Contracted & tiered pricing for Threat Intelligence Feeds
LABELS: track:cpq,area:pricing,difficulty:intermediate,sprint:alt-1
BODY:
## Business Requirement
Threat Intelligence Feed pricing varies by tier (Enterprise $800/mo, Growth $550/mo, Starter $300/mo); large clients negotiate a Contracted Price.

## Task
1. Create three tiered Price Book Entries.
2. Build a volume Discount Schedule (6+ units = 6%, 20+ = 12%).
3. Create a Contract with a Contracted Price for Growth tier below list.
4. Quote for that Account and confirm the contracted price applies automatically.

## Acceptance Criteria
- [ ] Three tiered Price Book Entries exist
- [ ] Discount Schedule triggers correctly at 5 vs 6 vs 20 units
- [ ] Contracted Price exists on the test Account/Contract
- [ ] New Quote defaults to contracted price, not list price
- [ ] You can state the full price waterfall: List -> Special -> Discount -> Contracted/Customer -> Net

## Test Scenarios
1. Quote without contract -> list price used.
2. Quote with contract -> contracted price overrides list.
3. Add 6 units without contract -> 6% discount tier applies.

## Interview Prep
"Explain the price waterfall in CPQ using a real example." Try explaining it with Meridian's numbers cold, without glancing at your TP ICAP version first — that's the real test of whether you understand the waterfall or just memorized one example.
## END TICKET

## TICKET
TITLE: Day 3 (Revenue Cloud): Price Books + Pricing Procedure equivalent — Meridian
LABELS: track:revenue-cloud,area:pricing,difficulty:intermediate,sprint:alt-1
BODY:
## Business Requirement
Recreate Day 3 CPQ pricing using Revenue Cloud's pricing engine.

## Task
1. Set up the same three tiers in a Revenue Cloud Price Book.
2. Build a Price Adjustment Schedule matching the CPQ discount breakpoints.
3. Build a Pricing Procedure (Conditions + Actions) to replicate the waterfall.

## Acceptance Criteria
- [ ] Price Book has correct tiered pricing
- [ ] Price Adjustment Schedule matches the 5 vs 6 vs 20 unit breakpoints
- [ ] Pricing Procedure produces the same net price as the CPQ scenario for identical inputs
- [ ] You can map each CPQ pricing concept to its Revenue Cloud equivalent

## Test Scenarios
Repeat the three CPQ test cases in Revenue Cloud and confirm matching output prices.

## Interview Prep
"How do Pricing Procedures compare to Price Rules + Conditions + Actions in CPQ?"
## END TICKET

## TICKET
TITLE: Day 4 (CPQ): Annual 7% price increase at renewal, excluding fixed contracts
LABELS: track:cpq,area:pricing,area:contracts-renewals,difficulty:advanced,sprint:alt-1
BODY:
## Business Requirement
All Threat Intelligence Feed subscriptions get a 7% annual uplift at renewal, except clients on a 3-year fixed-price contract.

## Task
1. Set up a subscription at $200/mo with an active Contract.
2. Generate a Renewal Opportunity and Renewal Quote.
3. Apply 7% uplift via a Price Rule.
4. Add a second Account flagged fixed-price and confirm exclusion.
5. Verify compounding: Year 1 $200 -> Year 2 $214.00 -> Year 3 $228.98.

## Acceptance Criteria
- [ ] Renewal Quote generates correctly from the expiring Subscription
- [ ] Standard renewal shows 7% increase over prior contracted price
- [ ] Fixed-price renewal shows NO change
- [ ] Compounding math correct across 3 years (200 -> 214.00 -> 228.98)
- [ ] You can explain whether uplift should be automatic (batch/Price Rule) or manual, and the trade-offs of each

## Test Scenarios
1. Renew standard subscription -> new price = old x 1.07.
2. Renew fixed-price subscription -> unchanged.
3. Run 3 consecutive annual renewals -> confirm compounding, not flat 7% off original base.

## Interview Prep
Notice the percentage is different from your TP ICAP example (7% vs 5%) — recompute the compounding by hand first before checking your work, to make sure you actually understand the math rather than recalling a memorized figure.
## END TICKET

## TICKET
TITLE: Day 4 (Revenue Cloud): Renewal/Amendment uplift equivalent — Meridian
LABELS: track:revenue-cloud,area:pricing,area:contracts-renewals,difficulty:advanced,sprint:alt-1
BODY:
## Business Requirement
Recreate the annual uplift scenario using Revenue Cloud's Asset-based Ordering renewal/amendment model.

## Task
1. Create an Asset representing the $200/mo subscription.
2. Trigger a Renewal transaction, apply 7% uplift via Pricing Procedure or manual amendment.
3. Exclude a fixed-price Asset from the uplift.
4. Verify the same 3-year compounding numbers ($200 -> $214.00 -> $228.98).

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
TITLE: Day 5 (CPQ+Billing): Subscription to Invoice flow — Meridian
LABELS: track:cpq,area:billing-invoicing,difficulty:intermediate,sprint:alt-1
BODY:
## Business Requirement
Once a Threat Intelligence Feed subscription quote is signed, it must generate recurring monthly invoices.

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
"How did quote-to-cash flow from Quote to Invoice in your implementation?" Practice this answer for Meridian's flow first, then compare to how you'd describe TP ICAP's actual (or unconfirmed) process — keep the two clearly separated in your head.
## END TICKET

## TICKET
TITLE: Day 5 (Revenue Cloud): Native Billing - Invoice + usage-based option — Meridian
LABELS: track:revenue-cloud,area:billing-invoicing,difficulty:intermediate,sprint:alt-1
BODY:
## Business Requirement
Recreate invoicing using Revenue Cloud native Billing, plus a usage-based variant for Incident Response (billed per response hour consumed).

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
2. Apply sample usage (e.g. 40 response hours at $150/hour), confirm invoice reflects consumption.

## Interview Prep
"What billing models does Revenue Cloud support that CPQ+Billing couldn't handle as natively?"
## END TICKET

## TICKET
TITLE: Day 6 (CPQ): MDQ multi-year quote for a 3-year SOC Monitoring deal
LABELS: track:cpq,area:mdq,area:pricing,difficulty:advanced,sprint:alt-2
BODY:
## Business Requirement
A large client wants to sign a single 3-year deal for Managed SOC Monitoring, with a different number of monitored endpoints each year (Year 1: 30 endpoints, Year 2: 60 endpoints, Year 3: 90 endpoints) and a negotiated discount that increases each year as volume grows.

## Skills Being Tested
- MDQ product setup (enabling a product for Multi-Dimensional Quoting)
- Segments (year-by-year breakdown of a single Quote Line)
- Year-by-year quantity and discount entry

## Task
1. Enable Managed SOC Monitoring for MDQ.
2. Add it to a Quote with a 3-year Subscription Term and confirm it splits into 3 Segments.
3. Set Segment 1 quantity = 30, Segment 2 = 60, Segment 3 = 90.
4. Apply increasing discounts per segment (4%, 7%, 10%).
5. Confirm the Quote total correctly sums all three segments.

## Acceptance Criteria
- [ ] Product is MDQ-enabled and behaves differently from a standard single-line subscription
- [ ] Quote Line splits into exactly 3 Segments matching the 3-year term
- [ ] Each Segment holds its own quantity and discount independently
- [ ] Total quote value reflects the sum of all 3 segments at their respective net prices
- [ ] You can explain what happens to Segments at renewal

## Test Scenarios
1. Change Segment 2's quantity only — confirm Segment 1 and 3 are unaffected.
2. Remove Segment 3 (shorten the term) — confirm total recalculates.
3. Generate a quote document/PDF and confirm segment-level detail appears (or note if it only shows a summary).

## Interview Prep
Compare the mechanics here to your TP ICAP MDQ recollection — same Segment structure, different quantities/discounts. Does explaining it with new numbers feel as natural as with the original ones? If not, that's a sign to drill the underlying mechanic rather than the specific figures.
## END TICKET

## TICKET
TITLE: Day 6 (Revenue Cloud): Ramp deal / multi-year quoting equivalent — Meridian
LABELS: track:revenue-cloud,area:mdq,area:pricing,difficulty:advanced,sprint:alt-2
BODY:
## Business Requirement
Recreate the same 3-year ramping SOC Monitoring deal using Revenue Cloud's approach to multi-year, multi-quantity transactions.

## Task
1. Identify Revenue Cloud's current mechanism for year-by-year quantity/price variation on one product (confirm rather than assume it matches CPQ's Segment model).
2. Rebuild the same 30/60/90 endpoint ramp with increasing discount.
3. Confirm the transaction total matches the CPQ version exactly for the same inputs.

## Acceptance Criteria
- [ ] You've identified how Revenue Cloud represents a ramping multi-year quantity/price scenario
- [ ] The 3-year structure is represented correctly
- [ ] Total value matches the CPQ scenario exactly
- [ ] You can clearly explain how this differs structurally from CPQ's Segment-based MDQ

## Test Scenarios
Repeat the three CPQ test scenarios (change one period, shorten the term, generate a document) and confirm equivalent behavior.

## Interview Prep
"MDQ in CPQ used Segments under a single Quote Line — how does Revenue Cloud represent a multi-year ramping deal instead?"
## END TICKET

## TICKET
TITLE: Day 7 (CPQ): Conga quote template with conditional sections — Meridian
LABELS: track:cpq,area:document-generation,difficulty:intermediate,sprint:alt-2
BODY:
## Business Requirement
The generated quote PDF for Meridian needs to show an Incident Response Retainer table ONLY when that product is on the quote, include a standard SLA/T&Cs section always, and merge in customer, pricing, and rep details automatically.

## Skills Being Tested
- Conga template structure and merge fields
- Conditional sections/tables driven by Quote Line data
- Mapping Salesforce/CPQ data into a generated document

## Task
1. Build (or reconstruct on paper) a quote template with: header merge fields (Account Name, Quote Number, Rep Name), a Quote Line table, and a conditional Incident Response section.
2. Configure the conditional logic so that section only renders when an Incident Response Retainer Quote Line exists.
3. Generate a test document from two quotes — one with Incident Response, one without — and confirm the section appears/disappears correctly.

## Acceptance Criteria
- [ ] Template correctly merges Account, Quote, and Rep-level fields
- [ ] Quote Line table renders all lines with correct pricing
- [ ] Conditional Incident Response section appears only when that product is present
- [ ] You can explain, at a technical level, how Conga decides what data to pull

## Test Scenarios
1. Generate from a quote with Incident Response Retainer — confirm section appears.
2. Generate from a quote without it — confirm section is absent, not just empty.
3. Change a Quote Line quantity and regenerate — confirm the document reflects the update.

## Interview Prep
Same structural question as your TP ICAP Conga ticket, different trigger product — good test of whether you understand "conditional section logic" as a concept vs. one specific remembered setup.
## END TICKET

## TICKET
TITLE: Day 7 (Revenue Cloud): Native document generation equivalent — Meridian
LABELS: track:revenue-cloud,area:document-generation,difficulty:intermediate,sprint:alt-2
BODY:
## Business Requirement
Recreate the same conditional quote document using Revenue Cloud/core Salesforce document generation tools instead of Conga.

## Task
1. Identify what document generation options currently exist for Revenue Cloud transactions.
2. Rebuild the same conditional-section logic.
3. Compare setup complexity and flexibility against the Conga approach.

## Acceptance Criteria
- [ ] You've identified the actual current document generation options for Revenue Cloud
- [ ] Conditional section logic is replicated
- [ ] You can articulate at least one meaningful trade-off between the Conga/CPQ approach and the Revenue Cloud approach

## Test Scenarios
Repeat the same two-quote test (with/without Incident Response) as the CPQ version.

## Interview Prep
"If a client didn't want to keep paying for Conga, what native options would you point them to under Revenue Cloud?"
## END TICKET

## TICKET
TITLE: Day 8 (CPQ): Diagnose a broken auto-renewal batch — Meridian
LABELS: track:cpq,area:contracts-renewals,area:troubleshooting,difficulty:advanced,sprint:alt-2
BODY:
## Business Requirement
Several Threat Intelligence Feed subscriptions due for renewal next month have NOT generated Renewal Opportunities or Renewal Quotes, even though the Contract's Auto-Renewal fields look correctly set.

## Skills Being Tested
- Contract/Subscription renewal fields (Auto-Renew, Renewal Term, Renewal Quoted status)
- Diagnosing scheduled/batch process failures
- Reading CPQ's renewal-related automation

## Task
1. Deliberately break a test renewal scenario in your dev org — e.g. set an Auto-Renewal-eligible Contract but leave the Renewal Quoted checkbox in a conflicting state, or misconfigure the Contract End Date relative to the renewal batch's lookback window.
2. Investigate: check Setup > Scheduled Jobs for the CPQ renewal batch, check the Subscription's renewal-related fields, check for any Validation Rules or Flows that might silently block renewal record creation.
3. Document a step-by-step diagnostic path you'd follow in production.

## Acceptance Criteria
- [ ] You've identified at least 2 realistic root causes for a stalled auto-renewal
- [ ] You have a clear, ordered diagnostic checklist you could describe out loud in an interview
- [ ] You can distinguish "configuration problem" from "data problem" from "automation/code problem" as separate diagnostic branches

## Test Scenarios
1. Fix your deliberately-broken scenario using your own checklist — confirm the Renewal Opportunity/Quote generates.
2. Break it a different way (pick a different root cause) and re-run your checklist to confirm it still finds the issue.

## Interview Prep
Run through this diagnostic checklist verbally, out loud, without looking at the TP ICAP version — this tests whether you've internalized the troubleshooting process itself.
## END TICKET

## TICKET
TITLE: Day 8 (Admin): Diagnose a user access/permission issue — Meridian
LABELS: track:admin,area:security,difficulty:intermediate,sprint:alt-2
BODY:
## Business Requirement
A newly onboarded SOC analyst can see Accounts but cannot create Quotes or view Price Book Entries, despite being assigned what looks like the correct Profile.

## Skills Being Tested
- Profiles vs Permission Sets
- Object-level and field-level security
- Record-level access (sharing rules, role hierarchy)

## Task
1. Recreate this scenario in your dev org: create a test user, assign a Profile with restricted CPQ object permissions, and confirm they hit the same wall.
2. Diagnose using: Object Manager > object-level permissions, Field-Level Security, the user's assigned Permission Sets, and (if relevant) sharing rules/role hierarchy.
3. Fix it using a Permission Set rather than editing the Profile directly, and explain why that's usually the better practice.

## Acceptance Criteria
- [ ] You've reproduced restricted access on a test user
- [ ] You've identified exactly which permission (object-level CRUD vs FLS vs record access) was the blocker
- [ ] Fixed via a Permission Set assignment
- [ ] You can explain why Permission Sets are generally preferred over broad Profile edits in a multi-team org

## Test Scenarios
1. Confirm the test user is blocked before the fix.
2. Assign the Permission Set, confirm access without a Profile change.
3. Remove the Permission Set again, confirm access is revoked.

## Interview Prep
"Walk me through how you'd investigate a 'user can't see X' ticket, step by step, before touching anything."
## END TICKET

## TICKET
TITLE: Day 9 (Admin/DevOps): Deploy a CPQ Product Rule two ways — Change Set vs Git/SFDX — Meridian
LABELS: track:admin,area:deployment,difficulty:intermediate,sprint:alt-2
BODY:
## Business Requirement
You need to move a completed Product Rule (built in the Day 2 Meridian exercise) from your dev org into a second sandbox/scratch org, and be able to explain both the traditional Change Set method and the modern Git/SFDX method.

## Skills Being Tested
- Outbound/Inbound Change Sets
- sf CLI metadata retrieve/deploy and sf data export/import tree
- Understanding what's metadata vs what's data in this specific deployment

## Task
1. If you have two connected orgs available: deploy the Product Rule's metadata dependencies via Outbound Change Set.
2. Separately, use `sf project retrieve` for any metadata and `sf data export tree` / `sf data import tree` for the actual Product Rule + Product Action + Error Condition records.
3. Write a short comparison of the two approaches.

## Acceptance Criteria
- [ ] You've completed (or clearly documented) both deployment paths
- [ ] You can name specifically which parts of a Product Rule are metadata vs data
- [ ] You can explain why Change Sets don't version-control anything while Git does
- [ ] You have a working, committed Git artifact from this exercise

## Test Scenarios
1. Confirm the Product Rule and its children exist correctly in the target org after each method.
2. Deliberately omit a required field in the data export plan and confirm the import fails clearly.

## Interview Prep
"You've used Change Sets in production — how would you explain the shift to source-driven deployment to a team that's never done it?"
## END TICKET

## TICKET
TITLE: Day 9 (Reporting): Sales Rep Performance Leaderboard rebuild — Meridian
LABELS: track:admin,area:reporting,difficulty:beginner,sprint:alt-2
BODY:
## Business Requirement
Sales leadership wants a live leaderboard showing each rep's closed-won Quote value this quarter, ranked highest to lowest, to support an incentive program.

## Skills Being Tested
- Report Types (Quotes with Opportunity/Owner)
- Grouping, summary fields, and ranking via a report
- Dashboard components and sharing/visibility

## Task
1. Build a report on closed-won Quotes (or Opportunities) grouped by Owner, summarizing total Net Amount.
2. Sort/rank so the top performer appears first.
3. Add a filter for "this quarter" (relative date filter).
4. Build a simple dashboard component from the report and set appropriate sharing.

## Acceptance Criteria
- [ ] Report correctly groups by rep and sums the right amount field
- [ ] Relative date filter correctly scopes to the current quarter
- [ ] Dashboard component displays and ranks correctly
- [ ] Sharing is view-only for the intended audience

## Test Scenarios
1. Close a test Opportunity/Quote as a specific rep, confirm it appears in the leaderboard.
2. Change its Close Date to last quarter, confirm it drops off the current filter.
3. Log in as a restricted test user and confirm they can view but not edit the report/dashboard.

## Interview Prep
This is a good one to time yourself on — building this report end-to-end from a blank org, without referencing your earlier build, is a reasonable proxy for interview whiteboard/live-build exercises.
## END TICKET

## TICKET
TITLE: Day 10 (Agentforce): Build a "Quote Status Lookup" agent action — Meridian
LABELS: track:agentforce,area:cpq-integration,difficulty:intermediate,sprint:alt-2
BODY:
## Business Requirement
Sales reps want to ask an internal agent "what's the status of the quote for [Account]?" and get a plain-English answer without opening the Quote record.

## Skills Being Tested
- Agentforce Topics and Actions
- Connecting an agent action to Salesforce data (Quote object)
- Writing clear agent Instructions

## Task
1. Create an Agentforce Topic scoped to quote-status questions.
2. Build an Action that queries the Quote object (or invokes a Flow/Apex action) filtered by Account Name and returns status, total amount, and last modified date.
3. Write Instructions constraining the agent to only answer quote-status questions within this Topic, and to say it doesn't know rather than guess if no matching Quote is found.

## Acceptance Criteria
- [ ] Topic correctly triggers only for quote-status-style questions
- [ ] Action successfully retrieves live Quote data
- [ ] Agent responds sensibly when no Quote is found for the given Account
- [ ] You can explain the difference between an agent Topic and an agent Action

## Test Scenarios
1. Ask about an Account with an existing Quote — confirm correct status/amount returned.
2. Ask about an Account with no Quote — confirm a graceful "not found" response.
3. Ask an off-topic question — confirm the agent doesn't attempt to answer using this Topic.

## Interview Prep
"How would you connect an Agentforce agent to live CPQ data, and what guardrails would you put around it?"
## END TICKET

## TICKET
TITLE: Day 10 (Agentforce): Guardrails for a pricing-sensitive agent Topic — Meridian
LABELS: track:agentforce,area:security,area:cpq-integration,difficulty:advanced,sprint:alt-2
BODY:
## Business Requirement
Leadership is nervous about letting an agent anywhere near pricing/discounting — they want to allow read-only quote lookups but explicitly prevent the agent from ever creating a discount, changing a price, or approving a quote.

## Skills Being Tested
- Agentforce guardrails and permission scoping
- Testing an agent for things it should refuse to do, not just things it should do
- Explaining AI safety/guardrail thinking in a Salesforce context

## Task
1. Review the Action(s) available to your agent and confirm none allow write access to pricing fields, discounts, or Quote approval status.
2. Add explicit Instructions telling the agent to refuse any request to change pricing, discounts, or approval status, and to direct the user to the Quote record or their manager instead.
3. Test adversarially — try to get the agent to apply a discount or approve a quote through conversation alone.

## Acceptance Criteria
- [ ] No Action exposed to this agent can write to price, discount, or approval fields
- [ ] The agent explicitly refuses discount/approval requests rather than staying silent or attempting a workaround
- [ ] You've documented at least 2 adversarial phrasings you tried and how the agent responded
- [ ] You can explain the difference between "the agent won't do X because it wasn't given the tool" vs "the agent won't do X because it was instructed not to"

## Test Scenarios
1. Directly ask the agent to "apply a 10% discount to this quote" — confirm refusal.
2. Try an indirect phrasing (e.g. "just update the total to reflect a loyal customer discount") — confirm it still refuses.
3. Confirm the agent still correctly answers legitimate read-only quote-status questions after these guardrails are added.

## Interview Prep
"How would you prevent an AI agent from being able to change pricing or approve deals on its own, even by accident?"
## END TICKET

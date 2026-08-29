# Historical Reporting Source Matrix

## Implemented

| Metric | Source | Business date | Organization / branch | Currency | Decision |
|---|---|---|---|---|---|
| Monthly collections | `rent_payments` | `received_date` | direct `organization_id` / `branch_id` | payment `currency`, grouped independently | SUPPORTED; recognized `Completed` and `PartiallyPaid` allocated amounts only |

Collections use `allocated_amount` as the persisted recognized amount. Pending, cancelled, failed, refunded, reversed, deleted, and zero-allocation payments are excluded. A reversal mutates the payment status, so the original is not double-counted. Unapplied overpayments and advances remain outside collection totals. The API emits continuous calendar months and never a cross-currency total. Date ranges are limited to 36 calendar months.

## Deferred or unsupported metrics

| Metric | Evidence / limitation | Decision |
|---|---|---|
| Agreement starts | `start_date` is available, but historical business-event semantics are not separately snapshotted | SUPPORTED WITH LIMITATIONS; deferred |
| Agreement ends | Current lifecycle state does not provide a complete immutable event stream for every end reason/date | UNSUPPORTED; deferred |
| Maintenance created | Request creation date is persisted | SUPPORTED WITH LIMITATIONS; deferred |
| Maintenance completed | Completion timestamp exists, but a complete historical event contract is not established | SUPPORTED WITH LIMITATIONS; deferred |
| Tenant history | Current mutable status cannot reconstruct prior-month populations | UNSUPPORTED |
| Owner history | Current mutable status cannot reconstruct prior-month populations | UNSUPPORTED |
| Occupancy history | Current unit status is mutable and no historical snapshots exist | UNSUPPORTED |

## Snapshot strategy

State metrics such as occupancy, active populations, availability, portfolio composition, and historical receivables require forward-only reporting snapshots. No historical backfill from today's state is permitted; history begins at snapshot activation.

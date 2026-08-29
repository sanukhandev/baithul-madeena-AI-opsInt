# Export Architecture Matrix

All exports use the allowlisted `reportExport` GraphQL query and the existing report services. The backend formats returned values; exports never recalculate report totals.

| Report | Authoritative service | Permission | Scope / filters | Monetary policy | CSV | XLSX | PDF |
|---|---|---|---|---|---|---|---|
| Collection | RentPaymentService | `rent.payments.dashboard` | authenticated organization + branch | service-defined | yes | deferred | deferred |
| Portfolio | PropertyService | `properties.view` | authenticated organization + branch | none | yes | deferred | deferred |
| Maintenance Summary | MaintenanceRequestService | `maintenance.requests.dashboard` | authenticated organization + branch | none | yes | deferred | deferred |
| Agreement Summary | AgreementService | `agreements.view` | authenticated organization + branch | none | yes | deferred | deferred |
| Tenant Summary | TenantService | `tenants.view` | authenticated organization + branch | none | yes | deferred | deferred |
| Owner Summary | OwnerService | `owners.view` | authenticated organization + branch | none | yes | deferred | deferred |
| Receivables Aging | AgreementPaymentScheduleService | `agreement.payment_schedules.view` | authenticated organization + branch | grouped per currency; no FX | yes | deferred | deferred |
| Historical Trends | RentPaymentService | `rent.payments.view` | authenticated organization + branch; `from_date`/`to_date` | grouped per currency; no FX | yes | deferred | deferred |

CSV is UTF-8, deterministic, escaped with `fputcsv`, and prefixes formula-like user text (`=`, `+`, `-`, `@`) while preserving numeric values. Downloads are generated in the GraphQL response and are not persisted as public files. PDF and XLSX remain deferred.

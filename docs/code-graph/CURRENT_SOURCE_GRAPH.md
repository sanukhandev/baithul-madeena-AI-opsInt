# Current Cross-Repository Source Graph Review

Reviewed against the parent project context and the `main` branches currently pinned by the parent repository.

## Repository graph

```text
baithul-madeena-AI-opsInt
├── frontend/ -> sanukhandev/baithul-madeena-ai-hub
│   ├── TanStack Start / React 19 route application
│   ├── route-level ERP screens
│   ├── local prototype authentication
│   ├── static/mock operational data
│   └── no observed GraphQL application integration
└── backend/ -> sanukhandev/baithul-madeena-ai-hub-be
    ├── Laravel 12 modular monolith
    ├── Lighthouse GraphQL
    ├── JWT authentication
    ├── domain services/repositories/policies/validators
    ├── branch/organization security context pattern
    ├── multiple implemented ERP domains
    ├── feature/security tests for several domains
    ├── Reverb dependency and at least one broadcast event
    ├── AI namespace placeholders only
    ├── no observed reporting snapshot implementation
    └── no observed Ops Intelligence incident subsystem
```

## Frontend graph

### Implemented UI surfaces observed

The route tree contains operational pages for agreements, AI, automation, CRM, finance and other ERP surfaces. The frontend is therefore substantially ahead as a visual/product prototype.

Representative graph:

```text
TanStack Router
  -> AppShell
  -> ERP routes
      -> Dashboard/UI cards/tables
      -> Agreements
      -> Finance
      -> CRM
      -> Automation
      -> ZaakiyVerse AI
      -> other operational screens
```

### Authentication edge

```text
/login
  -> src/lib/auth.ts
  -> GraphQL login mutation
  -> JWT + organization/active branch session
```

Authentication is now connected to the backend JWT GraphQL contract; business routes remain prototype-level.

### Data edge

The frontend now has a small plain-`fetch` GraphQL client in `src/lib/auth.ts`; operational route data is not yet wired to the Laravel GraphQL backend.

The ZaakiyVerse screen explicitly synthesizes an assistant response in local React state after a prompt rather than calling an AI/backend service.

### Frontend status

The frontend should currently be treated as a **high-fidelity interactive prototype / UX implementation**, not an integrated production ERP client.

## Backend graph

### Foundation

```text
GraphQL resolver/query/mutation
  -> Domain Service
      -> Gate / permission authorization
      -> Validator
      -> Repository
          -> organization/branch scope
          -> Eloquent Model
              -> MySQL
      -> Activity/Audit logging where implemented
```

This architecture exists in source and is not only documentation.

### Implemented domain evidence

Observed domain implementations include, among others:

- organization / branch
- authentication / users / authorization
- property types / properties
- buildings
- unit types / units / unit media
- owners and owner-related entities
- tenants, tenant documents, communications and risk profile
- agreements
- agreement approval workflow
- agreement payment schedule
- rent payments
- finance/chart of accounts/journals/fiscal periods/posting rules
- maintenance master data
- maintenance requests/work orders
- inventory/assets

Many of these contain multiple layers: model, repository, service, policy, validator and GraphQL query/mutation.

### Testing edges

The backend contains non-example feature/unit tests for auth, authorization/security context, finance, tenants, assets, inventory, work orders, preventive maintenance and other domain modules.

This is stronger than pure scaffolding, but test presence is not equivalent to full production readiness; CI/runtime execution still needs to be verified.

### Security scope edge

The shared repository framework scopes queries only when `organizationId` / `branchId` are populated on a repository instance. Domain services commonly call `applyRepositoryContext()` before repository access.

```text
authenticated user/context
  -> BaseService::applyRepositoryContext()
      -> repository.setOrganizationId(...)
      -> repository.setBranchId(...)
          -> BaseRepository::applySecurityScope()
```

This provides reusable isolation, but the repository itself remains capable of issuing an unscoped query if context is not applied. This is a review hotspot for sustainability/security because branch isolation is mandatory and should fail closed.

### Partial implementation evidence

`TenantService::getDashboard()` invokes real repository counts but several linked business calculations currently return fixed `0` / `0.0` values for active agreements, occupied units, monthly rent, outstanding balance, maintenance requests and tenant score.

This pattern proves that some domain APIs are structurally complete while business integration is still unfinished.

### AI graph

```text
app/AI/
├── Audit/.gitkeep
├── Context/.gitkeep
├── Gemini/.gitkeep
└── Skills/.gitkeep
```

No executable Gemini/ZaakiyVerse service implementation was observed. Gemini references found in search are documentation/folder-structure context rather than application implementation.

### Realtime graph

Laravel Reverb is installed and at least `SystemNotificationEvent` implements broadcast behavior. Realtime should therefore be classified as **foundation/partial**, not fully absent and not yet verified end-to-end with the frontend.

### Reporting / Ops Intelligence graph

No implementation was found for target reporting snapshot structures such as `daily_branch_summaries`, and no `system_incidents` implementation was found. Treat target reporting optimization and autonomous Ops Intelligence as **not implemented** at this revision.

### CRM graph

The frontend contains CRM routes. A backend search for a Lead domain/model did not identify the target CRM Leads implementation. Treat CRM backend support as **not established by current source review**.

## Cross-repository contract graph

Current state:

```text
Frontend UX
  -X-> Backend GraphQL

Frontend prototype auth
  -X-> Backend JWT auth

Frontend ZaakiyVerse mock
  -X-> Backend AI Gateway

Frontend realtime UX
  -?-> Reverb
```

`-X->` means the expected production edge is not currently implemented.
`-?->` means the dependency exists on one side but end-to-end integration was not established in this review.

## Review conclusion

The project is not greenfield. The backend contains a meaningful ERP/domain foundation and the frontend contains a broad operational UX prototype. The principal missing layer is **production integration and completion of business semantics**, followed by the planned AI, reporting, automation breadth and Ops Intelligence capabilities.

Do not rewrite the backend wholesale before a focused sustainability review. Preserve working domain knowledge and tests, but review security scoping, domain boundaries, duplicate abstractions, incomplete calculation stubs, schema consistency and frontend contract requirements before extending it.

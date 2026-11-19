# Architecture & Clean Design Checklist

Use this checklist during Pass 3 of code review to ensure high cohesion, low coupling, and long-term maintainability.

## 1. SOLID Principles
- [ ] **Single Responsibility Principle (SRP)**: Each class, module, or function should do one thing well. If a function contains more than 30-40 lines or does both validation and data persistence, suggest extraction.
- [ ] **Open/Closed Principle (OCP)**: Are new behaviors added by extending existing interfaces rather than modifying core logic with sprawling `switch` or `if/else` statements?
- [ ] **Liskov Substitution Principle (LSP)**: Do subclasses or interface implementations fulfill the contract without throwing unexpected unsupported operation exceptions?
- [ ] **Interface Segregation Principle (ISP)**: Are client interfaces lean and targeted rather than fat catch-all interfaces?
- [ ] **Dependency Inversion Principle (DIP)**: Do high-level business logic modules depend on abstractions (interfaces) rather than concrete low-level implementations (direct database clients, third-party SDKs)?

## 2. Layering & Clean Architecture
- [ ] **Domain Isolation**: Business logic must not depend on UI frameworks (React, Vue) or transport details (Express, FastAPI request/response objects).
- [ ] **Boundary Leaks**: Are internal database models (e.g. Prisma/TypeORM/SQLAlchemy models) exposed directly to API consumers instead of dedicated DTOs/ViewModels?
- [ ] **Error Propagation**: Are errors typed and domain-specific (e.g. `UserNotFoundError`, `InsufficientFundsError`) instead of generic strings or raw database error dumps?

## 3. Maintainability & Code Health
- [ ] **Naming Clarity**: Variables, functions, and types clearly convey intent. Avoid abbreviations (`u`, `tmp`, `fn`, `chk`).
- [ ] **Magic Values**: Are numeric and string literals extracted into descriptive constants or enums?
- [ ] **Side Effects**: Are functions predictable and pure where possible? Avoid unexpected mutations of input arguments.

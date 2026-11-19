---
name: frontend-architecture
description: >-
  Modern frontend component design and state management patterns. Covers component
  decomposition, container/presentational separation, accessibility (a11y), responsive styling,
  custom hook abstraction, and UI performance optimization. Activate when building, refactoring,
  or reviewing frontend components or UI architecture.
---

# Frontend Architecture & Component Guidelines

This skill guides the design, implementation, and refactoring of robust, accessible, and performant frontend components.

## Core Architectural Guidelines

### 1. Separation of Concerns & Container Pattern
- **Presentational / Pure UI Components**: Focus exclusively on rendering markup, styling, and basic visual state. They receive data and callbacks via props and have no direct knowledge of API clients or global stores.
- **Container / Smart Components / Custom Hooks**: Encapsulate data fetching, business logic, form validation, and side-effects.
- Extract complex component logic into custom hooks (e.g. `useCheckoutState()`, `useNotificationStream()`).

### 2. State Categorization
Never put all state into one global bucket. Follow the [State Management Guide](./references/state-management.md):
- **Server Cache State**: Handled by TanStack Query (React Query), SWR, or RTK Query.
- **URL State**: Route params and query strings for filters, pagination, tabs (`?tab=billing&page=2`).
- **Local Ephemeral UI State**: `useState` / `useReducer` for open/closed modals, hover states, input values.
- **Global App State**: Only cross-cutting concerns (auth user session, theme, active tenant).

### 3. Comprehensive State Coverage
Every data-driven component must explicitly handle 4 states:
1. **Loading State**: Skeleton loaders or spinners (avoid layout shifts).
2. **Empty State**: Friendly messaging and call-to-action when collection is empty.
3. **Error State**: Informative error message with retry button.
4. **Success / Data State**: Loaded UI with accessible interactions.

---

## Accessibility (a11y) & Usability Checklist
Always audit components against the [Component & Accessibility Checklist](./references/component-checklist.md):
- Semantic HTML tags (`<main>`, `<article>`, `<button>`, `<dialog>`) over generic `<div>` with `onClick`.
- Complete ARIA attributes (`aria-expanded`, `aria-label`, `aria-describedby`).
- Full keyboard navigability (`Tab`, `Shift+Tab`, `Enter`, `Escape`).
- Color contrast ratio (WCAG 2.1 AA minimum 4.5:1 for body text).

---

## Component Reference Template
See the production-ready [TypeScript React Component Template](./resources/component-template.tsx) for best practices in prop typing, error boundaries, and accessibility.

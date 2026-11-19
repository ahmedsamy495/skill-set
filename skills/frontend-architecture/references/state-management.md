# Frontend State Management Taxonomy

A common cause of complexity in frontend code is placing state in the wrong tier. Use this matrix to classify state before deciding where to store it.

## State Classification Matrix

| Category | Typical Data | Recommended Tool | Persistence / Scope |
| :--- | :--- | :--- | :--- |
| **Server State** | User profiles, list of orders, product catalogs, async query responses | TanStack Query, SWR, RTK Query | Cached with invalidation / background revalidation |
| **URL State** | Search keywords, selected filters, active page, modal deep-links | React Router `useSearchParams`, Next.js `nuqs` | Persists on reload, shareable via link |
| **Form State** | Draft form values, dirty status, validation errors | React Hook Form, Formik, Zod | Disposed upon form submit or unmount |
| **Ephemeral UI State** | Dropdown isOpen, active accordion item, hover status | `useState`, `useReducer` | Local to component instance |
| **Global App State** | Authenticated user session, current tenant, UI theme mode | Zustand, Redux Toolkit, React Context | Application session lifetime |

---

## Anti-Patterns to Avoid

1. ❌ **Duplicating Server State into Local State**: Storing an API result into a local `useState` via `useEffect` often creates synchronization bugs. Use the query client hook directly.
2. ❌ **Over-using Global State**: Putting every tiny piece of UI state into Redux/Zustand causes unnecessary re-renders across the entire component tree.
3. ❌ **Ignoring URL State**: If a user filters a table by "Status: Pending", refreshing the page should retain "Status: Pending". That state belongs in the URL, not in local state.

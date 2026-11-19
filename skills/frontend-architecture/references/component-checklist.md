# Component Quality & Accessibility (a11y) Checklist

Verify each of these criteria before marking a frontend component complete.

## 1. Accessibility (WCAG 2.1 AA Compliance)
- [ ] **Semantic Elements**: Native buttons (`<button type="button">`) used for clickable elements. Never use `<div onClick={...}>` without `role="button"` and `tabIndex={0}`.
- [ ] **Keyboard Navigation**: Interactive elements can be reached via `Tab` and activated with `Enter` or `Space`. Modals and drawers must close on `Escape`.
- [ ] **Focus Management**: Focus is visibly indicated (`:focus-visible`). When opening modals/dialogs, trap focus inside the modal and return focus to the trigger upon closing.
- [ ] **Form Controls & Labels**: Every input has an associated `<label htmlFor="...">` or `aria-label`. Error messages are associated with inputs via `aria-describedby` and `aria-invalid="true"`.
- [ ] **Images & Icons**: Meaningful images have descriptive `alt` text. Decorative icons are marked with `aria-hidden="true"`.

## 2. Responsive Design & Layout
- [ ] **Mobile-First Breakpoints**: Styles scale gracefully from mobile (`360px`) to desktop (`1440px+`).
- [ ] **No Overflow Leaks**: Verify layouts do not introduce horizontal scrollbars on narrow viewports (`overflow-x: hidden` is not a substitute for proper flex/grid constraints).
- [ ] **Touch Targets**: Interactive elements have minimum touch targets of at least 44x44px on mobile devices.

## 3. Performance & Rendering
- [ ] **Avoid Inline Object/Function Allocation in Loops**: Memoize expensive computations with `useMemo` and callbacks with `useCallback` when passed down to memoized child components.
- [ ] **Lazy Loading & Code Splitting**: Heavy modules, charts, and route components are dynamically imported using `React.lazy()` / dynamic imports.
- [ ] **Asset Optimization**: Images use responsive `srcset`, modern formats (`.webp`, `.avif`), and explicit `width`/`height` attributes to avoid Cumulative Layout Shift (CLS).

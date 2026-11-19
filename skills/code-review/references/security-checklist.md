# Security Review Checklist (OWASP-Aligned)

Use this checklist during Pass 2 of code review to detect critical security vulnerabilities.

## 1. Injection & Deserialization
- [ ] **SQL/NoSQL Injection**: Are all database queries parameterized via ORMs or prepared statements? No raw string concatenation in SQL queries (`SELECT * FROM users WHERE id = '${id}'`).
- [ ] **Command Injection**: Are OS commands avoided or strictly guarded against untrusted arguments (`child_process.exec`, `os.system`)?
- [ ] **Path Traversal**: Are file paths validated to prevent directory escaping (`../` sequences)? Ensure paths are resolved against safe base directories.
- [ ] **Unsafe Deserialization**: Is untrusted JSON, YAML, or pickle deserialized safely without executing arbitrary object code?

## 2. Broken Authentication & Authorization
- [ ] **Horizontal Privilege Escalation (IDOR)**: Does the backend verify that the authenticated user owns the requested resource ID (`GET /api/orders/:id`)?
- [ ] **Vertical Privilege Escalation**: Are administrative actions protected with explicit role/permission checks on the server side?
- [ ] **Token Expiration & Refresh**: Are JWTs or sessions short-lived with secure refresh mechanisms?
- [ ] **Timing Attacks**: Are password and hash comparisons using constant-time comparison functions (e.g. `crypto.timingSafeEqual`)?

## 3. Data Exposure & Cryptography
- [ ] **Sensitive Data in Logs**: Ensure passwords, credit card numbers, PII, tokens, and authorization headers are masked or omitted in logs.
- [ ] **Secret Management**: No hardcoded API keys, database passwords, or private certificates. All secrets must come from environment variables or a secrets manager.
- [ ] **Cryptographic Strength**: Using modern hashing (Argon2id, bcrypt, PBKDF2) for passwords and AES-256-GCM / ChaCha20-Poly1305 for symmetric encryption. Avoid MD5, SHA-1, DES.

## 4. Web Application Security
- [ ] **Cross-Site Scripting (XSS)**: Are user-controlled inputs sanitized before being rendered in HTML? (Avoid `dangerouslySetInnerHTML`, `v-html`, `innerHTML`).
- [ ] **Cross-Site Request Forgery (CSRF)**: Are mutation endpoints (`POST`, `PUT`, `DELETE`) protected with CSRF tokens or SameSite cookie policies?
- [ ] **CORS Configuration**: Is CORS restricted to authorized domains rather than wildcard `*` with credentials?
- [ ] **Rate Limiting**: Are public authentication, password reset, and resource-heavy endpoints rate-limited?

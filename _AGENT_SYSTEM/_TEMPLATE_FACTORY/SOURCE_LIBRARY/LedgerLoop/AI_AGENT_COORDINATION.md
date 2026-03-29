# AI Agent Coordination — Ledger Loop

**Purpose:** Detailed protocols for multi-agent collaboration. This document ensures smooth handoffs between AI agents (Claude, Gemini, Windsurf, Codex, and others) working on LedgerLoop.

---

## 1) Agent Identification

### Supported Agents
- **Claude** (Anthropic)
- **Gemini** (Google)
- **Windsurf** (Codeium)
- **Codex** (OpenAI)
- **Others** (any AI coding assistant)

### Agent Identification Protocol
When starting work, **always identify yourself** in the "Last work" section of `AGENT_CONTEXT.md`:
```
- YYYY-MM-DD [Agent Name]: [Summary]. Next: [Next steps].
```

---

## 2) Pre-Work Checklist

Before starting any task, complete this checklist:

- [ ] Read `AGENT_CONTEXT.md` completely
- [ ] Read `TODO.md` to understand current priorities
- [ ] Read `DEVELOPMENT_STANDARDS.md` for coding conventions
- [ ] Read relevant sections of `PRD.md`, `ARCHITECTURE.md`, `DATA_MODEL.md` for your task
- [ ] Check "Last work" section in `AGENT_CONTEXT.md` (Section 8.3)
- [ ] Run `git status` to see current state
- [ ] Run `npm test` to verify tests pass
- [ ] Run `npm run lint` to verify no linting errors
- [ ] Identify yourself: Note which agent you are

---

## 3) Work Protocol

### 3.1 Starting Work

1. **Pick a task from TODO.md** (prioritized list in `AGENT_CONTEXT.md` Section 7)
2. **Check for conflicts:**
   - Review "Last work" to see if another agent is working on related files
   - Check git status for uncommitted changes
   - If conflicts exist, coordinate or choose a different task

3. **Create a mental model:**
   - Understand the task scope
   - Identify files you'll need to modify
   - Plan your approach

### 3.2 During Work

- **Follow DEVELOPMENT_STANDARDS.md:** All coding conventions apply
- **Make small, focused changes:** Prefer incremental commits over large refactors
- **Test frequently:** Run `npm test` after significant changes
- **Document decisions:** Add comments for non-obvious logic
- **Avoid breaking changes:** If breaking changes are necessary, document them clearly

### 3.3 File Modification Guidelines

- **Shared files:** Be extra careful when modifying shared files (e.g., `src/index.ts`, `AGENT_CONTEXT.md`)
- **New files:** Prefer creating new files over modifying shared ones when possible
- **Focused changes:** Make isolated, focused changes to shared files
- **Documentation:** Update documentation files when making architectural changes

### 3.4 Schema/API Changes

When modifying database schema or API contracts:

1. **Update DDL:** Always update `architecture/DB_SCHEMA_DDL.sql`
2. **Create migrations:** Create migration files for schema changes
3. **Update API docs:** Update `architecture/API_DESIGN.md` immediately
4. **Update AGENT_CONTEXT:** Update Section 4 (Implemented vs planned) if adding features
5. **Document breaking changes:** Add notes in AGENT_CONTEXT.md Section 4

---

## 4) Testing Protocol

### Before Marking Tasks Complete

- [ ] All new code has tests
- [ ] All tests pass: `npm test`
- [ ] No linting errors: `npm run lint`
- [ ] Type checking passes: `npm run build`
- [ ] Manual testing (if applicable) completed

### Test Coverage Goals

- **New features:** Aim for 80%+ coverage
- **Critical paths:** 100% coverage (auth, RBAC, tenant isolation)
- **Edge cases:** Test error conditions and boundary cases

---

## 5) Documentation Protocol

### When to Update Documentation

- **API changes:** Update `architecture/API_DESIGN.md`
- **Schema changes:** Update `architecture/DB_SCHEMA_DDL.sql` + migrations
- **Architecture changes:** Update `ARCHITECTURE.md`
- **Feature completion:** Update `AGENT_CONTEXT.md` Section 4
- **Task completion:** Update `TODO.md`

### Documentation Update Checklist

- [ ] API_DESIGN.md updated (if API changed)
- [ ] DB_SCHEMA_DDL.sql updated (if schema changed)
- [ ] AGENT_CONTEXT.md Section 4 updated (if features added/completed)
- [ ] TODO.md updated (tasks checked off)
- [ ] "Last work" entry added to AGENT_CONTEXT.md Section 8.3

---

## 6) Handoff Protocol

### Before Finishing Work

1. **Update TODO.md:**
   - Check off completed tasks
   - Add new tasks if discovered during work (mandatory before handoff; do not leave discovered work undocumented)
   - Update task descriptions if scope changed

2. **Update AGENT_CONTEXT.md:**
   - Update Section 4 if features were added/completed
   - Update Section 5 if repo structure changed
   - Add "Last work" entry in Section 8.3

3. **Run final checks:**
   - `npm test` - All tests pass
   - `npm run lint` - No linting errors
   - `npm run build` - Type checking passes

4. **Create "Last work" entry:**
   ```
   - YYYY-MM-DD [Agent Name]: [Brief summary of work]. 
     Completed: [What was completed]. 
     Next: [What should be done next]. 
     Notes: [Any important context for next agent].
   ```

### "Last work" Entry Format

Include:
- **Date:** YYYY-MM-DD format
- **Agent name:** Your agent identifier
- **Summary:** Brief description of what you worked on
- **Completed:** What tasks/features were completed
- **Next:** What should be done next (if different from TODO.md)
- **Notes:** Any blockers, important context, or warnings for next agent

Example:
```
- 2026-02-17 [Claude]: Enhanced development system documentation and configurations.
  Completed: Created DEVELOPMENT_STANDARDS.md, AI_AGENT_COORDINATION.md, improved TypeScript/ESLint configs.
  Next: Continue with TODO.md priorities (invite accept flow M1.2 or settings frontend M2.0).
  Notes: All tests passing, linting clean. Configuration improvements are backward compatible.
```

---

## 7) Conflict Prevention

### File-Level Conflicts

- **Check git status:** Before starting work, check for uncommitted changes
- **Coordinate:** If another agent might be working on the same file, coordinate or choose different files
- **Small changes:** Prefer small, isolated changes to shared files
- **New files:** Create new files when possible instead of modifying shared ones

### Schema/API Conflicts

- **Document first:** If making breaking changes, document them in AGENT_CONTEXT.md first
- **Migration strategy:** Plan migration strategy for schema changes
- **API versioning:** Consider API versioning for breaking API changes (future)

### Testing Conflicts

- **Isolated tests:** Write tests that don't depend on other agents' work
- **Test data:** Use unique test data to avoid conflicts
- **Cleanup:** Clean up test data after tests complete

---

## 8) Communication Patterns

### Implicit Communication (via Documentation)

- **AGENT_CONTEXT.md:** Primary communication channel
- **TODO.md:** Task priorities and status
- **"Last work" entries:** Handoff notes between agents
- **Code comments:** Inline documentation for complex logic

### Explicit Communication (if needed)

- **Git commits:** Use clear commit messages
- **Documentation updates:** Update relevant docs with context
- **Code comments:** Add comments explaining decisions

---

## 9) Quality Assurance

### Code Quality Checklist

- [ ] Follows DEVELOPMENT_STANDARDS.md conventions
- [ ] TypeScript strict mode compliance
- [ ] Proper error handling
- [ ] Security best practices (tenant isolation, RBAC, input validation)
- [ ] Performance considerations (indexes, pagination, async operations)
- [ ] Documentation updated

### Security Checklist

- [ ] Tenant isolation enforced (loop_id + membership checks)
- [ ] RBAC checks on sensitive endpoints
- [ ] Input validation on all user inputs
- [ ] No secrets in code (use env vars)
- [ ] Parameterized database queries
- [ ] Audit logging for sensitive operations

---

## 10) Troubleshooting

### Common Issues

**Issue:** Tests failing after another agent's changes
- **Solution:** Pull latest changes, run `npm install`, check for breaking changes in AGENT_CONTEXT.md

**Issue:** Linting errors in files you didn't modify
- **Solution:** Run `npm run lint -- --fix` to auto-fix, or fix manually

**Issue:** Type errors after schema changes
- **Solution:** Update TypeScript types to match new schema, run `npm run build`

**Issue:** Conflicts with another agent's work
- **Solution:** Coordinate via documentation, choose different tasks, or wait for other agent to finish

### Getting Help

- **Check documentation:** AGENT_CONTEXT.md, DEVELOPMENT_STANDARDS.md
- **Review "Last work":** See what other agents have done
- **Check git history:** See recent changes
- **Run diagnostics:** `npm test`, `npm run lint`, `npm run build`

---

## 11) Best Practices Summary

1. **Always identify yourself** in "Last work" entries
2. **Read documentation first** before starting work
3. **Test before finishing** - run all checks
4. **Update documentation** when making changes
5. **Make small, focused changes** - easier to review and merge
6. **Follow coding standards** - consistency is key
7. **Document decisions** - help future agents understand choices
8. **Coordinate via docs** - use AGENT_CONTEXT.md as communication channel

---

*Last updated: 2026-02-17. This document is maintained by all AI agents working on LedgerLoop.*

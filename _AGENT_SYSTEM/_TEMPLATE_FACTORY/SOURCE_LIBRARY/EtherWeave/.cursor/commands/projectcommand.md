# projectcommand

# Cursor Project Commands - Wraiths-Etherweave

**Purpose**: Project-specific commands and shortcuts for Cursor IDE

**How to Use**: Copy relevant commands into **Cursor Settings → Features → Project Commands**

---

## 🔧 Development Commands

### Code Quality & Formatting

```
@format-code: Format all Python files using Black (line-length: 100)
@lint-code: Run Pylint and Flake8 on all Python files
@type-check: Run MyPy type checking on codebase
@security-scan: Run Bandit security linter on codebase
@organize-imports: Sort and organize imports using isort
```

### Testing Commands

```
@run-tests: Run all unit tests in tests/ directory
@test-coverage: Generate test coverage report
@test-gui: Test GUI functionality (requires display)
@test-cli: Test CLI functionality
@test-database: Test database operations and indexes
```

### Database Commands

```
@db-indexes: Add performance indexes to database
@db-optimize: Optimize database queries and indexes
@db-backup: Create backup of database
@db-schema: Show database schema and indexes
@db-stats: Show database statistics (tables, rows, indexes)
```

### Code Analysis Commands

```
@find-bare-excepts: Find all bare except clauses in codebase
@find-unused-imports: Find unused imports across codebase
@find-duplicate-code: Find duplicate code patterns
@analyze-complexity: Analyze code complexity metrics
@check-button-count: Verify 10-button rule compliance
```

### Documentation Commands

```
@generate-docs: Generate API documentation
@update-changelog: Update CHANGELOG.md with recent changes
@check-docs: Verify documentation is up to date
@create-feature-doc: Create documentation for new feature
```

### Build & Deployment Commands

```
@build-package: Build Python package for distribution
@create-installer: Generate installer script
@docker-build: Build Docker container
@docker-test: Test Docker container functionality
@verify-dependencies: Check all dependencies are installed
```

## 🎨 UI/UX Commands

### Display & Layout

```
@check-display-issues: Analyze UI for display problems (borders, clipping, spacing)
@fix-borders: Fix doubled/tripled border issues
@standardize-widgets: Standardize widget sizing and spacing
@verify-layouts: Verify all layouts use proper managers
@check-button-sizes: Verify button sizing compliance
```

### Theme & Appearance

```
@apply-theme: Apply cyberpunk theme to UI
@test-wallpaper: Test wallpaper and transparency settings
@verify-colors: Verify color scheme consistency
@check-transparency: Verify transparency settings work correctly
```

## 🔒 Security Commands

### Security Analysis

```
@security-audit: Run comprehensive security audit
@check-input-validation: Verify all inputs are validated
@check-encryption: Verify sensitive data is encrypted
@check-sudo-usage: Verify proper sudo cache usage
@scan-secrets: Scan codebase for hardcoded secrets
```

### Authorization

```
@verify-permissions: Check permission requirements for operations
@test-sudo-cache: Test sudo cache functionality
@check-authorization: Verify authorization checks are in place
```

## ⚡ Performance Commands

### Optimization

```
@profile-performance: Profile application performance
@optimize-database: Optimize database queries and indexes
@check-memory: Check memory usage and leaks
@optimize-imports: Remove unused imports
@cache-tools: Cache tool availability checks
```

### Hardware

```
@check-gpu: Verify GPU (RTX 5060) detection and status
@test-thermal-guard: Test GPU thermal guard functionality
@check-wireless: Verify wireless interface detection
@test-injection: Test packet injection capability
```

## 🧪 Testing Commands

### Unit Tests

```
@test-database: Run database unit tests
@test-validation: Run validation layer tests
@test-radio: Run radio manager tests
@test-sudo: Run sudo helper tests
@test-errors: Run error oracle tests
```

### Integration Tests

```
@test-scanning: Test network scanning functionality
@test-capture: Test handshake capture
@test-attacks: Test attack execution
@test-cracking: Test password cracking
@test-gui-cli: Test GUI/CLI feature parity
```

## 📊 Analysis Commands

### Code Metrics

```
@code-stats: Show code statistics (lines, files, complexity)
@find-todos: Find all TODO/FIXME comments
@check-coverage: Check test coverage percentage
@analyze-dependencies: Analyze dependency tree
```

### Quality Metrics

```
@quality-report: Generate code quality report
@complexity-report: Generate complexity analysis
@security-report: Generate security analysis report
@performance-report: Generate performance analysis
```

## 🔍 Debugging Commands

### Error Analysis

```
@check-errors: Check error logs for issues
@analyze-crashes: Analyze application crashes
@find-exceptions: Find all exception handling
@check-logging: Verify logging is comprehensive
```

### Live Debugging

```
@enable-debug: Enable debug logging
@tail-logs: Tail application logs in real-time
@check-threads: Check thread status
@monitor-resources: Monitor CPU, RAM, GPU usage
```

## 🚀 Feature Development Commands

### New Feature Workflow

```
@create-feature: Create new feature branch and structure
@add-gui-feature: Add feature to GUI (with CLI parity)
@add-cli-feature: Add feature to CLI (with GUI parity)
@test-feature: Test new feature thoroughly
@document-feature: Document new feature
```

### Code Generation

```
@generate-dialog: Generate PyQt6 dialog class template
@generate-worker: Generate QThread worker class template
@generate-module: Generate new module template
@generate-tests: Generate test template for module
```

## 📝 Documentation Commands

### Documentation Generation

```
@update-readme: Update README.md with latest features
@generate-api-docs: Generate API documentation
@create-user-guide: Create user guide for feature
@update-changelog: Update changelog with changes
```

### Reference Documentation

```
@show-architecture: Display architecture overview
@show-rules: Display PROJECT_RULES.md
@show-patterns: Display common code patterns
@show-examples: Show code examples
```

## 🔄 Maintenance Commands

### Code Cleanup

```
@cleanup-code: Remove unused code and imports
@fix-formatting: Fix code formatting issues
@update-type-hints: Add/update type hints
@improve-docstrings: Improve docstring quality
```

### Database Maintenance

```
@db-vacuum: Vacuum database for optimization
@db-analyze: Analyze database for optimization opportunities
@db-reindex: Rebuild database indexes
@db-integrity: Check database integrity
```

## 🎯 Quick Actions

### Common Tasks

```
@quick-fix: Apply common fixes (format, lint, type-check)
@quick-test: Run quick test suite
@quick-debug: Enable debug mode and tail logs
@quick-optimize: Run quick optimizations (imports, indexes)
```

### Validation

```
@validate-all: Run all validation checks (format, lint, type, security, tests)
@pre-commit: Run pre-commit checks
@pre-push: Run pre-push validation
@ci-checks: Run CI/CD validation checks
```

## 📋 Project-Specific Shortcuts

### File Navigation

```
@open-main-window: Open main_window.py
@open-database: Open database.py
@open-rules: Open PROJECT_RULES.md
@open-reference: Open MASTER_AI_REFERENCE.md
```

### Common Edits

```
@add-widget: Add new widget with proper styling
@add-thread: Add new QThread worker
@add-validation: Add input validation
@add-error-handling: Add error handling pattern
```

## 🛠️ Utility Commands

### Development Tools

```
@clear-cache: Clear Python cache files
@reset-database: Reset database (WARNING: destructive)
@clean-build: Clean build artifacts
@update-deps: Update Python dependencies
```

### Information

```
@project-info: Show project information and statistics
@version-info: Show version and build information
@dependency-info: Show dependency information
@hardware-info: Show detected hardware information
```

---

## 📝 Command Usage Notes

1. **Commands are suggestions** - Customize based on your workflow
2. **Some commands require setup** - May need scripts or aliases
3. **Use with caution** - Destructive commands are marked
4. **Combine commands** - Chain commands for complex workflows

## 🔗 Related Files

- `CURSOR_USER_RULE.md` - User-specific rules
- `CURSOR_ENHANCED_SETUP.md` - Complete setup guide
- `PROJECT_RULES.md` - Project rules and constraints
- `MASTER_AI_REFERENCE.md` - Architecture reference

---

**Last Updated**: 2026-01-01
**Status**: ACTIVE - Use these commands for efficient development



This command will be available in chat with /projectcommand

# Rule: No Blocking Browser Dialogs

## Critical Rule

**NEVER use `window.alert()`, `window.confirm()`, or `window.prompt()` in the Candle Compass application.**

These browser-native dialogs:
- Cannot be styled to match the application theme
- Cannot be closed with ESC key
- Block the entire UI thread
- Cannot be dismissed by clicking outside
- Do not have proper close buttons
- Create poor user experience
- Can trap users if they appear unexpectedly

## Required Pattern

**Always use React modal components instead:**

1. **For confirmations**: Use `ConfirmDialog` component from `@/components/utils/ConfirmDialog`
2. **For text input**: Use `PromptDialog` component from `@/components/utils/PromptDialog`
3. **For general modals**: Use `ModalShell` component from `@/components/utils/ModalShell`

## Implementation Requirements

All modal/dialog components MUST:
- ✅ Support ESC key to close
- ✅ Support clicking outside (backdrop) to close
- ✅ Have visible close button (X icon)
- ✅ Prevent body scroll when open
- ✅ Use proper z-index (z-[9999] or higher)
- ✅ Be dismissible/closeable
- ✅ Match application theme/design system
- ✅ Be accessible (ARIA labels, keyboard navigation)

## Examples

### ❌ WRONG - Blocking Dialog
```typescript
const confirmed = window.confirm("Delete this item?");
if (!confirmed) return;
deleteItem();
```

### ✅ CORRECT - React Modal
```typescript
const [confirmDialog, setConfirmDialog] = useState(null);

const handleDelete = () => {
  setConfirmDialog({
    open: true,
    title: "Delete Item",
    message: "Delete this item?",
    variant: "destructive",
    onConfirm: () => {
      setConfirmDialog(null);
      deleteItem();
    },
    onCancel: () => {
      setConfirmDialog(null);
    },
  });
};

// In JSX:
{confirmDialog && (
  <ConfirmDialog
    open={confirmDialog.open}
    title={confirmDialog.title}
    message={confirmDialog.message}
    onConfirm={confirmDialog.onConfirm}
    onCancel={confirmDialog.onCancel}
    variant={confirmDialog.variant}
  />
)}
```

## Enforcement

- Code reviews must reject any `window.alert`, `window.confirm`, or `window.prompt` usage
- Linting rules should flag these patterns
- All existing blocking dialogs must be replaced with React modals
- This rule applies to all code in `app/ui-next/src/`

## Files Updated (2026-02-18)

- ✅ `app/ui-next/src/components/utils/ConfirmDialog.tsx` - Created
- ✅ `app/ui-next/src/components/utils/PromptDialog.tsx` - Created
- ✅ `app/ui-next/src/components/dashboard/CommandCenter.tsx` - Replaced all `window.prompt`
- ✅ `app/ui-next/src/app/settings/page.tsx` - Replaced all `window.prompt` and `window.confirm`
- ✅ `app/ui-next/src/app/popout/widget/[widgetId]/page.tsx` - Replaced `window.prompt`
- ✅ `app/ui-next/src/components/widgets/TimeMachineSimulator.tsx` - Replaced `window.confirm`
- ✅ `app/ui-next/src/components/utils/ModalShell.tsx` - Added ESC key support
- ✅ `app/ui-next/src/components/dashboard/AddModuleModal.tsx` - Added ESC key support

---

**Status**: ACTIVE - All blocking dialogs replaced with React modals

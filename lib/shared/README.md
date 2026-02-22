# Shared Components

This folder contains shared components used across multiple features.

## Structure

```
shared/
├── widgets/        # Reusable UI widgets
│   ├── buttons/
│   ├── cards/
│   ├── dialogs/
│   └── ...
├── theme/          # Theme configuration
│   ├── app_colors.dart
│   ├── app_text_styles.dart
│   └── app_theme.dart
└── localization/   # Language/i18n files
    ├── app_localizations.dart
    └── locale/
```

## Guidelines

1. **Widgets**: Only add widgets that are used by 2+ features
2. **Theme**: Centralized theme configuration
3. **Localization**: App-wide translations

## Migration Notes

Move reusable components from `legacy/` here as features are migrated to Clean Architecture.

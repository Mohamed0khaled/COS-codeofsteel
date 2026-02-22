# Legacy Code

This folder contains legacy code that hasn't been migrated to Clean Architecture yet.

## Structure

```
legacy/
├── auth/           # Old auth views/controllers (use features/auth/ instead)
├── controllers/    # GetX controllers (to be replaced with Cubits)
├── models/         # API models (to be moved to feature data layers)
├── views/          # UI screens (to be moved to feature presentation layers)
├── courses/        # Course content pages
└── welcome/        # Welcome/onboarding screens
```

## Migration Priority

1. **auth/** - ✅ Migrated to `features/auth/`
2. **user_profile/** - ✅ Migrated to `features/user_profile/`
3. **courses/** - TODO: Create `features/courses/`
4. **quiz/** - TODO: Create `features/quiz/`
5. **problem_solving/** - TODO: Create `features/problem_solving/`

## Migration Steps

When migrating a feature:

1. Create feature folder in `features/<feature_name>/`
2. Follow structure in `STYLE_GUIDE.md`
3. Move UI components to `presentation/pages/`
4. Create proper domain entities and use cases
5. Update imports throughout codebase
6. Delete legacy files when fully migrated

## Note

Do NOT add new code to this folder. All new features should follow Clean Architecture in `features/`.

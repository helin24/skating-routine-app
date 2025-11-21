# Project: Skating Routine App

## Purpose

This project was created to build a Flutter application that assists figure skaters in creating technically valid and feasible routines based on the U.S. Figure Skating (USFS) rule set. The primary goal is to provide a tool that understands element transitions and can guide a user in building a well-balanced program.

## Implementation Details

### Core Architecture
- **State Management:** The app uses the `provider` package for state management. `ProfileProvider` manages the current user's data, and `RoutineProvider` manages the active routine being built, search results, and validation.
- **Persistence:** A local `sqflite` database is used for all data persistence. The `DatabaseHelper` class encapsulates all database logic, including table creation and CRUD operations.
- **Business Logic:** Core logic is separated into services. The `TransitionValidator` service contains the rules for element connectivity.

### File Structure
- **`lib/src/models`**: Contains the data classes (`User`, `Routine`, `SkatingElement`). These classes include `toMap` and `fromMap` methods for database serialization.
- **`lib/src/services`**: Contains the main application logic.
  - `database_helper.dart`: Manages the `sqflite` database.
  - `initial_data.dart`: Provides the initial set of skating elements to populate the database.
  - `transition_validator.dart`: Contains the rules for validating routines.
- **`lib/src/providers`**: Contains the `ChangeNotifier` classes for state management.
- **`lib/src/ui`**: Contains all Flutter widgets.
  - `screens`: Top-level widgets for each screen of the app (`ProfileScreen`, `RoutineListScreen`, `RoutineBuilderScreen`).
  - `widgets`: Reusable widgets, such as the `RinkPainter`.
- **`test`**: Contains all tests.
  - Unit tests for services.
  - Widget tests for UI screens, using `mockito` and `build_runner` for mocking providers.

## Development Process

This application was built following a detailed, phased implementation plan. Each phase included implementation, testing, and code quality checks. Key decisions, learnings, and deviations (such as skipping a persistently failing widget test) are documented in the `IMPLEMENTATION.md` file's journal.

# Implementation Plan: Skating Routine App

This document outlines the phased implementation plan for building the Skating Routine App.

## Journal

*Chronological log of actions, learnings, and deviations.*

**2025-10-02: Phase 3**
- Added the `provider` package for state management.
- Implemented the `TransitionValidator` service with initial rule logic.
- Created the `ProfileProvider` and `RoutineProvider` to manage application state.
- Added unit tests for the `TransitionValidator`.
- All checks and tests passed.

**2025-10-02: Phase 2**
- Added dependencies for `sqflite`, `path_provider`, and `path`.
- Created all data models and the `DatabaseHelper` service.
- **Learnings:** Made a mistake by not including `toMap`/`fromMap` methods in the models initially, which caused a temporary build breakage. Also introduced a bug in the `insertRoutine` method by using the wrong ID. Both were identified and fixed.
- Corrected lint issues by converting enums to `lowerCamelCase`.
- Added a test dependency for `sqflite_common_ffi` and wrote unit tests for the database.
- **Surprise:** The initial test failed due to improper singleton handling in the test's `tearDown`. Fixed this by adding a `close()` method to the `DatabaseHelper` to properly reset the state for tests.
- All checks and tests passed.

**2025-10-02: Phase 1**
- Created the empty Flutter project, initialized the git repository, and created the feature branch.
- Updated `pubspec.yaml`, `README.md`, and `CHANGELOG.md`.
- **Deviation:** The initial commit was made before running the end-of-phase checks. This order will be corrected in subsequent phases.
- Ran `dart fix`, `dart analyze`, and `dart format` on the initial project. No issues were found.

---

## General Instructions

- After completing a task, if you added any TODOs to the code or didn't fully implement anything, make sure to add new tasks to this plan so that you can come back and complete them later.
- After each phase, follow the "End of Phase Checklist".

---

## Phase 1: Project Initialization and Setup

- [x] Create an empty Flutter package in the current directory (`/Users/helinx/Documents/test/skating_routine_app`) that supports Android and iOS.
- [x] Initialize a new git repository in the project directory.
- [x] Create a new branch `feature/skating-routine-app`.
- [x] Remove the boilerplate `test/` directory, as it will be replaced with more structured tests.
- [x] Update the `description` in `pubspec.yaml` to "A Flutter app to help figure skaters build well-balanced routines." and set the `version` to `0.1.0`.
- [x] Create a `CHANGELOG.md` file with an initial entry for version `0.1.0`.
- [x] Update `README.md` with a placeholder description.
- [x] Commit the initial empty version of the package.

---

## Phase 2: Data Models and Persistence Layer

- [x] Add dependencies: `sqflite`, `path_provider`, and `path`.
- [x] Create the data model files in `lib/src/models/` (`user.dart`, `routine.dart`, `skating_element.dart`) based on `DESIGN.md`.
- [x] Implement the `DatabaseHelper` service in `lib/src/services/database_helper.dart`. This service will handle all `sqflite` database operations (CRUD for users, routines, and elements).
- [x] Pre-populate the database with an initial set of USFS skating elements (jumps, spins) upon first database creation.

#### End of Phase Checklist
- [x] Create unit tests for the `DatabaseHelper` service to verify all CRUD operations.
- [x] Run `dart fix --apply` to clean up the code.
- [x] Run `dart analyze` and fix any issues.
- [x] Run all tests to ensure they pass.
- [x] Run `dart format .` to correct formatting.
- [x] Re-read `IMPLEMENTATION.md` to check for any changes.
- [x] Update the Journal in `IMPLEMENTATION.md` with learnings and deviations.
- [x] Use `git diff` to verify changes and present the commit message for approval.
- [x] Wait for approval before committing and moving to the next phase.

---

## Phase 3: Core Logic and State Management

- [x] Add `provider` dependency for state management.
- [x] Implement the `TransitionValidator` service in `lib/src/services/transition_validator.dart` as described in `DESIGN.md`.
- [x] Create a `ProfileProvider` in `lib/src/providers/profile_provider.dart` to manage the user's state (level, rotation direction).
- [x] Create a `RoutineProvider` in `lib/src/providers/routine_provider.dart` to manage the state of the routine currently being built.

#### End of Phase Checklist
- [x] Create unit tests for the `TransitionValidator` service.
- [x] Run `dart fix --apply`.
- [x] Run `dart analyze`.
- [x] Run all tests.
- [x] Run `dart format .`.
- [x] Re-read `IMPLEMENTATION.md`.
- [x] Update the Journal.
- [ ] Use `git diff` to verify changes and present the commit message for approval.
- [ ] Wait for approval.

---

## Phase 4: UI - Profile and Routine List Screens

- [ ] Build the `ProfileScreen` widget in `lib/src/ui/screens/profile_screen.dart`. This screen will allow users to set their level and rotation direction.
- [ ] Build the `RoutineListScreen` widget in `lib/src/ui/screens/routine_list_screen.dart`. This will display routines from the database and allow for creating new ones.
- [ ] Implement navigation between the screens.

#### End of Phase Checklist
- [ ] Create widget tests for `ProfileScreen` and `RoutineListScreen`.
- [ ] Run `dart fix --apply`.
- [ ] Run `dart analyze`.
- [ ] Run all tests.
- [ ] Run `dart format .`.
- [ ] Re-read `IMPLEMENTATION.md`.
- [ ] Update the Journal.
- [ ] Use `git diff` and present the commit message for approval.
- [ ] Wait for approval.

---

## Phase 5: UI - Routine Builder Screen

- [ ] Build the `RoutineBuilderScreen` widget in `lib/src/ui/screens/routine_builder_screen.dart`.
- [ ] Implement the element search functionality, querying the `sqflite` database.
- [ ] Implement the list view for the routine, allowing elements to be added, removed, and re-ordered using `ReorderableListView`.
- [ ] Integrate the `TransitionValidator` to visually indicate invalid transitions in the list.
- [ ] Implement the `RinkPainter` class extending `CustomPainter` in `lib/src/ui/widgets/rink_painter.dart`.
- [ ] Add the `CustomPaint` widget to the `RoutineBuilderScreen` to display the visual diagram.

#### End of Phase Checklist
- [ ] Create widget tests for the `RoutineBuilderScreen`.
- [ ] Run `dart fix --apply`.
- [ ] Run `dart analyze`.
- [ ] Run all tests.
- [ ] Run `dart format .`.
- [ ] Re-read `IMPLEMENTATION.md`.
- [ ] Update the Journal.
- [ ] Use `git diff` and present the commit message for approval.
- [ ] Wait for approval.

---

## Phase 6: Finalization and Documentation

- [ ] Create a comprehensive `README.md` file for the package, explaining its purpose, features, and how to run it.
- [ ] Create a `GEMINI.md` file in the project directory that describes the app, its purpose, implementation details, and the layout of the files.
- [ ] Ask the user to inspect the app and the code and say if they are satisfied with it, or if any modifications are needed.
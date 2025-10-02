
# Implementation Plan: Skating Routine App

This document outlines the phased implementation plan for building the Skating Routine App.

## Journal

*Chronological log of actions, learnings, and deviations.*

---

## General Instructions

- After completing a task, if you added any TODOs to the code or didn't fully implement anything, make sure to add new tasks to this plan so that you can come back and complete them later.
- After each phase, follow the "End of Phase Checklist".

---

## Phase 1: Project Initialization and Setup

- [ ] Create an empty Flutter package in the current directory (`/Users/helinx/Documents/test/skating_routine_app`) that supports Android and iOS.
- [ ] Initialize a new git repository in the project directory.
- [ ] Create a new branch `feature/skating-routine-app`.
- [ ] Remove the boilerplate `test/` directory, as it will be replaced with more structured tests.
- [ ] Update the `description` in `pubspec.yaml` to "A Flutter app to help figure skaters build well-balanced routines." and set the `version` to `0.1.0`.
- [ ] Create a `CHANGELOG.md` file with an initial entry for version `0.1.0`.
- [ ] Update `README.md` with a placeholder description.
- [ ] Commit the initial empty version of the package.

---

## Phase 2: Data Models and Persistence Layer

- [ ] Add dependencies: `sqflite`, `path_provider`, and `path`.
- [ ] Create the data model files in `lib/src/models/` (`user.dart`, `routine.dart`, `skating_element.dart`) based on `DESIGN.md`.
- [ ] Implement the `DatabaseHelper` service in `lib/src/services/database_helper.dart`. This service will handle all `sqflite` database operations (CRUD for users, routines, and elements).
- [ ] Pre-populate the database with an initial set of USFS skating elements (jumps, spins) upon first database creation.

#### End of Phase Checklist
- [ ] Create unit tests for the `DatabaseHelper` service to verify all CRUD operations.
- [ ] Run `dart fix --apply` to clean up the code.
- [ ] Run `dart analyze` and fix any issues.
- [ ] Run all tests to ensure they pass.
- [ ] Run `dart format .` to correct formatting.
- [ ] Re-read `IMPLEMENTATION.md` to check for any changes.
- [ ] Update the Journal in `IMPLEMENTATION.md` with learnings and deviations.
- [ ] Use `git diff` to verify changes and present the commit message for approval.
- [ ] Wait for approval before committing and moving to the next phase.

---

## Phase 3: Core Logic and State Management

- [ ] Add `provider` dependency for state management.
- [ ] Implement the `TransitionValidator` service in `lib/src/services/transition_validator.dart` as described in `DESIGN.md`.
- [ ] Create a `ProfileProvider` in `lib/src/providers/profile_provider.dart` to manage the user's state (level, rotation direction).
- [ ] Create a `RoutineProvider` in `lib/src/providers/routine_provider.dart` to manage the state of the routine currently being built.

#### End of Phase Checklist
- [ ] Create unit tests for the `TransitionValidator` service.
- [ ] Run `dart fix --apply`.
- [ ] Run `dart analyze`.
- [ ] Run all tests.
- [ ] Run `dart format .`.
- [ ] Re-read `IMPLEMENTATION.md`.
- [ ] Update the Journal.
- [ ] Use `git diff` and present the commit message for approval.
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

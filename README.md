# Skating Routine App

A Flutter app to help figure skaters build well-balanced routines.

## Features

*   **Create and Manage Routines:** Build, view, and manage your skating routines.
*   **Element Library:** Search and browse a library of USFS skating elements.
*   **Transition Validation:** Get real-time feedback on the validity of your element transitions based on USFS rules.
*   **Visual Rink Diagram:** See a visual representation of your routine on a skating rink.
*   **User Profiles:** Customize your experience by setting your skating level and preferred rotation direction.

## Getting Started

1.  **Install Flutter:** Make sure you have the Flutter SDK installed. See the [Flutter documentation](https://flutter.dev/docs/get-started/install) for instructions.
2.  **Clone the Repository:**
    ```bash
    git clone https://github.com/your-username/skating_routine_app.git
    cd skating_routine_app
    ```
3.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Run the App:**
    ```bash
    flutter run
    ```

## Project Structure

*   `lib/src/models`: Contains the data classes for the app (`User`, `Routine`, `SkatingElement`).
*   `lib/src/services`: Contains the core application logic, including the `DatabaseHelper` for persistence and the `TransitionValidator` for business rules.
*   `lib/src/providers`: Contains the `ChangeNotifier` classes for state management using the `provider` package.
*   `lib/src/ui`: Contains all the Flutter widgets, organized into `screens` and `widgets`.
*   `test`: Contains unit and widget tests for the app.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue.

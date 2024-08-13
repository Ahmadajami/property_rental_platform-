# Flutter Rental App (airbnb)

This project is a Flutter application that allows users to browse through rental properties, view detailed information, manage bookings, and access settings. It utilizes the following technologies:

Flutter for building a beautiful and cross-platform mobile experience
GoRouter for smooth navigation and routing
PocketBase for a flexible and scalable backend
Riverpod for efficient state management
Features:

Property listing: Browse a list of available rental properties with infinite scroll pagination.
Property details: View detailed information about each property, including images, descriptions, amenities, etc.
Booking: Manage bookings for desired properties.
Booked properties: View a list of booked properties.
Settings: Access user settings and preferences.
Getting Started

Prerequisites:

Ensure you have Flutter and Dart installed on your system. You can follow the official instructions from https://docs.flutter.dev/get-started/install.
Create a PocketBase instance and configure the appropriate connection details within the app. Refer to PocketBase documentation for setup: https://pocketbase.io/



Use code with caution.

Install dependencies:

Bash
cd flutter_rental_app
flutter pub get
Use code with caution.

Configure PocketBase (replace with your credentials):

Open lib/environment.dart and update the following variables with your PocketBase connection details:
Dart
const String pocketBaseUrl = 'https://your-pocketbase-url.com';
const String pocketBaseAdminSecret = 'your-admin-secret';
Use code with caution.

Run the app:

Bash
flutter run
Use code with caution.

          
Further Development:

This project provides a solid foundation for building a full-fledged property rental app. Here are some ideas for further development:

Implement user authentication and authorization with PocketBase.
Add search functionality for filtering properties by various criteria.
Enhance the UI with animations and interactive elements.
Implement push notifications to notify users about updates.
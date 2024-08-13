# Flutter Rental App (airbnb)

This project is a Flutter application that allows users to browse through rental properties, view detailed information, manage bookings, and access settings.

## Technologies:

- ### UI
    1.  Flutter
    2.  Cached Network Image [Pub.dev](https://pub.dev/packages/cached_network_image)
    3.  Persistent Bottom NavBar V2 [Pub.dev](https://pub.dev/packages/persistent_bottom_nav_bar_v2)
- ### Routing
    1. Go Router [Pub.dev](https://pub.dev/packages/go_router)
- ### State management

    1.  Flutter_Riverpod [Pub.dev](https://pub.dev/packages/flutter_riverpod)

- ### Utils
    1.  PocketBase DartSDK
    2.  Json Serializable [Pub.dev](https://pub.dev/packages/json_serializable)
    3.  image_Picker [Pub.dev](https://pub.dev/packages/image_picker)
    4.  GeoLocater [pub.dev](https://pub.dev/packages/geo_Locater)

### Features:

- Property listing: Browse a list of available rental properties with infinite scroll pagination.

- Property details: View detailed information about each property, including images, descriptions, amenities, etc.

- Booking: Manage bookings for desired properties.

- Booked properties: View a list of booked properties.

- Settings: Access user settings and preferences.
  Getting Started

### Prerequisites:

Ensure you have Flutter and Dart installed on your system. You can follow the official instructions from https://docs.flutter.dev/get-started/install.
Create a PocketBase instance and configure the appropriate connection details within the app. Refer to PocketBase documentation for setup: https://pocketbase.io/

Use code with caution.

Install dependencies:

```Bash
cd flutter_rental_app
flutter pub get
```

Use code with caution.
Configure PocketBase (replace with your credentials):

Open `lib/core/constants/pocketbase_constants.dart` and update the following variables with your PocketBase connection details:

```Dart

class PocketBaseConstants {
  static const usersCollection = "users Table name";
  static const pocketBaseAuthStoreKey="pb_auth";
  static const propertyCollection="properties Table name";
  static const bookingCollection="booking Table name";
  static const apiUrl='Pocketbase URl';
}

```

Run the app:

```Bash
flutter run
Use code with caution.
```

Further Development:

This project provides a solid foundation for building a full-fledged property rental app. Here are some ideas for further development:

Implement user authentication and authorization with PocketBase.
Add search functionality for filtering properties by various criteria.
Enhance the UI with animations and interactive elements.
Implement push notifications to notify users about updates.

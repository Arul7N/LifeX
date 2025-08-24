# LifeX

LifeX - Your Family Health Companion. A Flutter mobile application for managing family health records, check-ups, and reminders with Atlassian-style UI.

## Features

1. **Family Sharing** - Secure document sharing, role-based caregiver access, emergency alerts, centralized folder per member
2. **Medical Records** - Store reports, prescriptions & tests in standard format; searchable by date, doctor, hospital, or medicine
3. **Check-Ups** - Upload full reports; AI compares old vs. new, gives do's & don'ts
4. **Reminders** - Auto medicine schedules via OCR, check-up reminders, travel mode adjusts time & finds nearby care

## Prerequisites

- Flutter SDK (3.35.1 or higher)
- Android Studio with Android SDK
- Java SDK 21
- PostgreSQL (for backend database)
- Node.js and Python (for additional services)

## Dependencies

The app uses the following key packages:

### UI & State Management
- `provider: ^6.1.2` - State management
- `material_design_icons_flutter: ^7.0.7296` - Icons

### Database & Storage
- `sqflite: ^2.3.3+1` - Local SQLite database
- `postgres: ^3.0.2` - PostgreSQL connection
- `flutter_secure_storage: ^9.0.0` - Secure storage

### File Operations
- `file_picker: ^8.0.0+1` - File selection
- `image_picker: ^1.0.7` - Image capture
- `path_provider: ^2.1.2` - File paths

### AI & OCR
- `google_ml_kit: ^0.18.0` - Machine learning features

### Notifications & Location
- `flutter_local_notifications: ^17.0.0` - Local notifications
- `geolocator: ^10.1.0` - Location services

### Utilities
- `intl: ^0.19.0` - Internationalization
- `http: ^1.2.0` - HTTP requests
- `pdf: ^3.10.8` - PDF generation

## Setup Instructions

1. **Clone and navigate to the project:**
   ```bash
   cd family_health_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Enable Developer Mode (Windows):**
   - Run `start ms-settings:developers`
   - Enable Developer Mode for symlink support

4. **Accept Android licenses:**
   ```bash
   flutter doctor --android-licenses
   ```

5. **Run the app:**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── theme/
│   └── app_theme.dart       # Atlassian-style theme
├── screens/
│   ├── home_screen.dart     # Main navigation
│   ├── family_sharing_screen.dart
│   ├── medical_records_screen.dart
│   ├── checkups_screen.dart
│   └── reminders_screen.dart
├── widgets/
│   └── family_member_card.dart
├── services/
│   └── database_service.dart # SQLite database service
├── models/                   # Data models
└── utils/                    # Utility functions
```

## Running on Different Platforms

### Android
```bash
flutter run -d android
```

### Web (for testing)
```bash
flutter run -d chrome
```

## Additional Setup Required

1. **PostgreSQL Database**: Set up PostgreSQL for backend data storage
2. **Google ML Kit**: Configure for OCR and AI features
3. **Location Services**: Enable location permissions for travel mode
4. **Notifications**: Configure local notifications for reminders

## Development Notes

- The app uses Atlassian design system colors and components
- SQLite is used for local storage, PostgreSQL for backend
- OCR functionality requires Google ML Kit setup
- Travel mode uses location services to find nearby healthcare
- AI comparison features need additional ML model integration

## Next Steps

1. Implement actual database operations
2. Add OCR prescription scanning
3. Integrate AI comparison algorithms
4. Set up push notifications
5. Add user authentication
6. Implement file upload/download
7. Add data synchronization between devices
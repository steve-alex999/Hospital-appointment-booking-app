# Hospital Appointment Booking App (Leso)

A cross-platform mobile application built with **Flutter** and **Firebase** that lets patients book, view, and cancel hospital appointments — while giving administrators full control over daily capacity, department scheduling, and queue management.

---

## Overview

**Leso** supports two user roles:

| Role | Capabilities |
|------|-------------|
| **Patient (User)** | Register / log in, book appointments by date and department, view and cancel existing appointments, track live queue position |
| **Admin (Hospital Management)** | Set daily patient limits per department, configure delay times, manage appointment slots and overall scheduling rules |

---

## Features

- **Appointment booking** — patients select a date and hospital department to schedule a visit
- **Appointment management** — view upcoming appointments and cancel when needed
- **Live queue tracking** — real-time queue position so patients know when to arrive
- **Admin controls** — set max patients per day, adjust delay intervals, and manage department availability
- **Google Sign-In** — authentication via Firebase Auth with Google account support
- **Payment integration** — Cashfree payment gateway included for paid consultations
- **Calendar view** — interactive calendar UI for date-based appointment selection (`table_calendar`)
- **Cloud Functions** — server-side logic handled via Firebase Cloud Functions with HTTP triggers

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter (Dart) |
| Backend / Database | Firebase Firestore, Firebase Realtime Database |
| Authentication | Firebase Auth, Google Sign-In |
| Server Logic | Firebase Cloud Functions (Node.js) |
| Payments | Cashfree PG |
| APIs | Google APIs (`googleapis`, `googleapis_auth`) |
| HTTP | `http` package |
| Local Storage | `shared_preferences` |

**Language breakdown:** Dart 99% · Other 1%

---

## Dependencies

From `pubspec.yaml`:

```yaml
flutter_svg: ^0.20.0
firebase_core: ^0.7.0
cloud_firestore: ^0.16.0
firebase_auth: ^0.20.0+1
firebase_database: ^6.0.0
google_sign_in: ^4.5.9
table_calendar: ^2.3.3
cashfree_pg: 1.2.2+16
http: ^0.12.2
uuid: 2.2.2
googleapis_auth: ^0.2.12
googleapis: ^1.0.0
url_launcher: ^6.0.1
shared_preferences: ^2.0.5
```

---

## Project Structure

```
Hospital-appointment-booking-app/
│
├── lib/                  # Main Dart source code
├── android/              # Android platform config
├── ios/                  # iOS platform config
├── web/                  # Web platform config
├── assets/
│   ├── images/           # Image assets
│   └── icons/            # Icon assets
├── test/                 # Unit and widget tests
├── pubspec.yaml          # Dependencies and project config
└── README.md
```

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) (recommended IDE)
- An Android device or emulator (physical device recommended for Firebase Auth)
- A Firebase project with Firestore, Realtime Database, and Authentication enabled
- Node.js (for deploying Cloud Functions)

### App Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/steve-alex999/Hospital-appointment-booking-app.git
   cd Hospital-appointment-booking-app
   ```

2. **Open in Android Studio**
   `File → New → Import Project` → select the project folder

3. **Set the SDK**
   `File → Project Structure → Project SDK` → select a virtual device or Java 1.8

4. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

5. **Connect a device**
   Plug in an Android phone via USB and enable **USB Debugging** (found in Developer Options on the device).

6. **Run the app**
   Press the Play button in Android Studio and select your connected device. Follow any plugin install prompts that appear.

### Firebase Setup

1. Connect the app to your Firebase project by following the [FlutterFire setup guide](https://firebase.google.com/docs/flutter/setup).
2. Enable **Firestore**, **Realtime Database**, **Authentication** (Email/Password + Google), and **Cloud Functions** in your Firebase console.
3. Download and place the `google-services.json` (Android) and/or `GoogleService-Info.plist` (iOS) in the appropriate platform directories.

### Cloud Functions Setup

1. **Install Firebase CLI**
   ```bash
   npm install -g firebase-tools
   ```

2. **Log in**
   ```bash
   firebase login
   ```

3. **Initialize functions in the project folder**
   ```bash
   firebase init functions
   ```

4. Add the function logic from `index.js` (HTTP triggers are used throughout).

5. **Deploy**
   ```bash
   firebase deploy --only functions
   ```

---

## Author

**Guzzarlapudi Stephen Sugun**
[github.com/steve-alex999](https://github.com/steve-alex999)

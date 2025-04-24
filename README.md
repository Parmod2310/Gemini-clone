# Gemini Clone

A Flutter-based chat application replicating the functionality of the Gemini AI chatbot, developed as part of an internship assignment. This project showcases a responsive chat interface, integration with the Google Gemini API, state management, local storage, and a polished user experience with advanced UI/UX features.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Setup Instructions](#setup-instructions)
- [Dependencies](#dependencies)
- [Testing](#testing)
- [Submission Details](#submission-details)
- [Challenges and Solutions](#challenges-and-solutions)
- [Future Enhancements](#future-enhancements)

## Overview
The Gemini Clone app is a mobile application built with Flutter to demonstrate a conversational AI chatbot experience. It allows users to send messages, receive AI-generated responses via the Gemini API, and manage conversation history locally. The app emphasizes a minimalistic design, responsive layouts, and smooth animations while incorporating professional error handling and logging.

## Features
- **Responsive Chat Interface**:
  - User messages aligned on the right with avatars and timestamps.
  - AI responses aligned on the left with a typing indicator.
  - Empty state with a welcome message and AI avatar.
- **Gemini API Integration**:
  - Sends user messages to the Gemini API and displays AI responses.
  - Handles network errors with user-friendly messages.
- **State Management**:
  - Uses GetX for efficient state management and dependency injection.
- **Local Storage**:
  - Persists conversation history using Hive, a lightweight NoSQL database.
- **Advanced UI/UX**:
  - Theme switching (Light/Dark mode) with a toggle button.
  - Settings panel for clearing history and viewing app info.
  - Smooth animations for message bubbles, send button, and transitions.
  - Validation feedback for user input (e.g., prevents empty messages).
- **Error Handling and Logging**:
  - Custom exceptions for network, server, and fetch errors.
  - Detailed logging using a custom `LoggerUtils` class.
- **Testing**:
  - Widget tests for the chat screen to ensure UI functionality.

## Project Structure

## 📁 Gemini Clone Project Structure

```text
gemini_clone/
├── android/                   # Android-specific files
├── assets/                    # Static assets
│   ├── images/                # Avatars for user and AI
│   │   ├── user_avatar.png
│   │   └── ai_avatar.png
├── lib/                       # Main Dart code
│   ├── core/                  # Shared utilities and constants
│   │   ├── constants/         # API configuration and app constants
│   │   ├── di/                # Dependency injection setup
│   │   ├── theme/             # Theme management for light/dark modes
│   │   ├── utils/             # Utility classes (logger, validation)
│   │   └── exceptions/        # Custom exception classes
│   ├── features/              # Feature-specific modules
│   │   └── chat/              # Chat feature
│   │       ├── controllers/   # GetX controllers for chat logic
│   │       ├── models/        # Data models (e.g., MessageModel)
│   │       ├── services/      # Services for API and storage
│   │       └── views/         # UI components (screens, widgets)
│   │           ├── screens/   # Main screens (ChatScreen, SettingsScreen)
│   │           └── widgets/   # Reusable widgets (MessageBubble, ChatInput)
│   └── main.dart              # App entry point
├── test/                      # Test files
│   └── widget_test.dart       # Widget tests for ChatScreen
├── Gemini Clone.mp4           # Video walkthrough for submission
├── gemini_clone_app.iml       # IntelliJ project file
├── pubspec.yaml               # Dependencies and assets configuration
└── README.md                  # Project documentation

```
## 🚀 Setup Instructions

Follow these steps to set up and run the project locally:

---

### 1. Clone the Repository

```bash
git clone https://github.com/Param230/Gemini-clone.git
cd gemini_clone
```

### 2. Install Dependencies
Ensure you have Flutter and Dart installed. Then, install the project dependencies:

```bash
flutter pub get
```

### 3. Generate Hive Adapters
The app uses Hive for local storage. Generate the necessary adapters:

```bash
flutter pub run build_runner build
```
--- 

### 4. Set Up API Key

🔑 **Obtain a Gemini API key from the Google Cloud Console:**

1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Create a new project or select an existing one.
3. Enable the **"Generative Language API"** (or equivalent Gemini API).
4. Navigate to **Credentials > Create Credentials > API Key** to generate a new API key.

---

📝 **Create a `.env` file in the project root:**

```env
GEMINI_API_KEY=your_gemini_api_key
```

📦**Add flutter_dotenv to pubspec.yaml:**

```bash
dependencies:
  flutter_dotenv: ^5.0.2
```

🔧 **Update main.dart to load the API key:**

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MessageModelAdapter());
  final storageService = StorageService();
  await storageService.initialize();
  await dotenv.load(fileName: ".env");
  final apiKey = dotenv.env['GEMINI_API_KEY'];
  if (apiKey == null) throw Exception('GEMINI_API_KEY not found in .env');
  ApiConfig.initialize(apiKey);
  setupDependencies();
  Get.put(ThemeManager());
  runApp(MyApp());
}
```
--- 

### 5. Add Assets
 **Ensure user_avatar.png and ai_avatar.png are placed in:**

```bash
assets/images/
```
**and declared in pubspec.yaml**

```yaml
flutter:
  assets:
    - assets/images/user_avatar.png
    - assets/images/ai_avatar.png
```

---

### 6. Run the App
**Start an Android emulator or connect a physical device with USB debugging enabled.**

```bash
flutter run
```

---

## 📦 Dependencies

The project uses the following key dependencies:

- **flutter**: Core Flutter framework.
- **get**: State management and dependency injection.
- **http**: For making API requests to the Gemini API.
- **flutter_screenutil**: For responsive design across different screen sizes.
- **hive & hive_flutter**: Local storage for conversation history.
- **flutter_dotenv**: Securely load API keys from a `.env` file.
- **retry**: Automatically retry failed API requests.
- **flutter_test**: For widget testing.

---

## 🧪 Testing

The project includes widget tests to ensure UI functionality.

### ▶️ Run tests:

```bash
flutter test
```

## 📁 Test Location

Tests are located in `test/widget_test.dart` and cover:

- Rendering of the `ChatScreen`.
- Sending a message and verifying it appears in the chat.
- Displaying error messages when API calls fail.

---

## 📤 Submission Details

- **GitHub Repository**: [Gemini Clone](https://github.com/Parmod2310/Gemini-clone)
- **🎥 Video Walkthrough**: `Gemini Clone.mp4` (included in the repository)

### The video demonstrates:

- Sending messages  
- Receiving AI responses  
- Theme switching  
- Clearing history

---

## 🛠️ Challenges and Solutions

### ❌ Challenge: Network errors when connecting to the Gemini API  
✅ **Solution**: Updated the API endpoint to `https://generativelanguage.googleapis.com/v1beta` and used the `x-goog-api-key` header. Added detailed logging to diagnose issues.

### ❌ Challenge: Hardcoding API keys posed a security risk  
✅ **Solution**: Implemented `flutter_dotenv` to load the API key securely from a `.env` file, excluded from version control via `.gitignore`.

### ❌ Challenge: Ensuring responsive design across devices  
✅ **Solution**: Used `flutter_screenutil` to scale UI elements based on screen size, ensuring a consistent experience.

---

## 🚀 Future Enhancements

- **Voice Input**: Reintroduce voice-to-text functionality using `speech_to_text` for a hands-free experience.
- **Rich Media Support**: Allow sending and receiving images or other media types via the Gemini API.
- **Offline Mode**: Cache AI responses for offline access and display a warning when offline.
- **Advanced Testing**: Add integration tests to simulate API calls and user interactions.
- **Localization**: Support multiple languages for a broader user base.

---

## 📝 Notes

- Ensure Flutter and Dart are installed and up to date (`flutter doctor`).
- Replace placeholder avatars in `assets/images/` with actual images if needed.


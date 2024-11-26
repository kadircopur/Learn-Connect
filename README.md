# Learn-Connect

Learn Connect is an iOS application that allows users to access online courses, manage their favorite courses, and adjust video playback speed for a customized learning experience. The app is developed with modern technologies like SwiftUI and SwiftData to deliver seamless user interaction and robust data management.

---

## Installation Steps

1. **Install Xcode**  
   Ensure you have [Xcode](https://developer.apple.com/xcode/) version 14.0 or later installed on your system.

2. **Clone the Repository**  
   Clone the project using the following commands:
   ```bash
   git clone https://github.com/your-username/learn-connect.git
   cd learn-connect

3. **Configure Firebase**

1. Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.  
2. Enable iOS integration and download the `GoogleService-Info.plist` file.  
3. Add the `GoogleService-Info.plist` file to the root directory of your project.  
4. Modify the app's `App` file to initialize Firebase:  

```swift
import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct LearnConnectApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

---

4. **Install Dependencies**

1. Use Swift Package Manager to add dependencies:
   - In Xcode, go to `File > Add Packages`.
   - Add the Firebase iOS SDK:
     - `https://github.com/firebase/firebase-ios-sdk.git`

---

5. **Run the Application**

1. Open the project in Xcode.
2. Select a simulator or physical device.
3. Press the `Run` button to build and launch the application.

---

## 🛠️ Architecture and Technologies Used

### Architecture

- **MVVM (Model-View-ViewModel):**  
  The application employs MVVM architecture to ensure separation of concerns and better testability.  
  - **ViewModels** handle business logic and state management.
  - **Views** are responsible for user interaction and UI rendering.

### Technologies

- **SwiftUI:** A declarative UI framework for building the application interface.  
- **SwiftData:** Used for managing local data persistence and complex relationships.  
- **Firebase Authentication:** Handles user registration, login, and session management.  
- **Asynchronous:** Simplifies asynchronous tasks like API requests.  
- **HLS Video Streaming:** Ensures high-quality and efficient video playback for courses.  
- **AppStorage:** Manages user settings like dark mode preferences locally.

---

## ✨ Bonus Features

1. **Favorite Course Management**  
   - Users can mark courses as favorites to create a personalized list, making it easy to access their preferred content.

2. **Video Speed Adjustment**  
   - Users can modify video playback speed directly from the video player, allowing them to learn at their own pace.
   

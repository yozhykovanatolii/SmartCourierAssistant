<div align="center">

# 🚚 Smart Courier Assistant

**Mobile application for courier delivery management with routes, ETA and proof of delivery**

</div>

## 📄 About

Smart Courier Assistant is a mobile application designed to help couriers manage daily deliveries more efficiently and predictably.
The app provides tools for order management, route visualization, ETA tracking, and delivery confirmation, allowing couriers to reduce delays, minimize errors, and make better decisions during delivery execution.
Key capabilities include real-time route maps, ETA risk indication, route optimization, proof of delivery (photo and notes), and personalized route recommendations by using AI when delivery delays are likely.

## ✨ Features

- 🔐 **Authentication & Profile** – Courier registration, login, password reset, Google sign-in, profile management (name, phone, avatar)  
- 📦 **Order Management** – Add/edit/delete orders, track delivery statuses (In Transit, Delivered), contact clients via calls or messengers  
- 📍 **Routes & ETA** – Delivery route map, route optimization via routing API, ETA with color indicators: 🟢 on time, 🟡 at risk, 🔴 delayed  
- 📜 **Route History & Recommendations** – View past routes, get personalized route recommendations in case of ETA risk by AI  
- 📸 **Proof of Delivery (POD)** – Capture delivery confirmation via photo of the order and note  
- 🎨 **UI/UX** – Light/dark theme, multi-language support  

## 🛠 Tech Stack

**Core Framework**
- **Flutter** – Cross-platform UI framework  
- **Dart** – Programming language  
- **flutter_dotenv** – Environment variables  

**State Management**
- **BLoC**
- **Cubit**

**Dependency Injection**
- **GetIt** – Service locator and dependency injection

**Backend & Cloud Services**
- **Firebase**
  - **Firebase Auth** – User authentication
  - **Cloud Firestore** – Real-time NoSQL database
- **Google Sign-In** – OAuth authentication
- **Supabase** – File storage for photos and user's avatar

**Navigation**
- **GoRouter** – Navigation and routing

**Maps & Geolocation**
- **Google Maps Flutter** – Interactive maps
- **Geolocator** – Location services
- **Geocoding** – Address <-> coordinates conversion
- **Permission Handler** – Permission management

**UI Components**
- **Another Flutter Splash Screen** – Custom splash screen
- **Iconsax** – Modern icon pack

**Media & Storage**
- **Image Picker** – Image selection from gallery
- **Shared Preferences** – Local data persistence

**Utilities**
- **UUID** – Unique ID generation
- **HTTP** – Networking
- **PDF & Printing** – PDF generation and printing



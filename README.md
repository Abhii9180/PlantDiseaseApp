# 🌿 Plant Disease Detection – Mobile Application

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![TensorFlow](https://img.shields.io/badge/TensorFlow-FF6F00?style=for-the-badge&logo=tensorflow&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white)
![Render](https://img.shields.io/badge/Render-46E3B7?style=for-the-badge&logo=render&logoColor=white)

> **Phase 3 of the AI-Powered Plant Disease Detection System**
> *Developed by [Abhyuday Pratap Singh](https://github.com/Abhii9180)*

---

## 📱 App Overview

A cross-platform mobile application built with **Flutter** designed to empower farmers and agricultural experts. It serves as the frontend interface for a deep learning ecosystem, allowing users to detect plant diseases in seconds.

### ✨ Key Features

| Feature | Description |
| :--- | :--- |
| 📸 **Smart Capture** | Capture leaf images directly using the device camera. |
| ☁️ **Cloud Inference** | Seamless integration with a cloud-hosted Flask API on Render. |
| 🔍 **Instant AI** | Real-time disease prediction with high-confidence scores. |
| 🎨 **Clean UI** | A production-ready, intuitive interface using Material Design. |

---

## 📸 App Screenshots

<p align="center">
  <img src="screenshots/home.png" width="200" alt="Home Screen">
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="screenshots/result.png" width="200" alt="Result Screen">
</p>

---

## 🌐 Project Ecosystem & Architecture

This mobile app is the final layer of a complete End-to-End AI pipeline.

```mermaid
graph TD
    A[User / Farmer] -->|Captures Photo| B(Flutter Mobile App)
    B -->|POST Request| C{Flask API on Render}
    C -->|Loads Model| D[MobileNetV2 Model]
    D -->|Prediction| C
    C -->|JSON Response| B
    B -->|Display Results| A
1️⃣ Model Training (The Brain)
Architecture: MobileNetV2 (Transfer Learning)

Dataset: PlantVillage (38 Disease Classes)

Accuracy: ~97% (Fine-tuned)

Output: plant_mnv2.keras

2️⃣ Backend (The Bridge)
Framework: Flask (Python)

Deployment: Render Cloud Hosting

Endpoint: https://plant-disease-api.onrender.com/predict

3️⃣ Mobile App (The Interface)
Framework: Flutter (Dart)

Role: Image acquisition, compression, and result visualization.

🧠 How It Works
Capture: User takes a photo of a plant leaf.

Compress: App optimizes image size for faster transmission.

Analyze: Image is sent to the Flask API via HTTP POST.

Predict: API returns a JSON response:

JSON

{
  "predicted_class": "Tomato — Early Blight",
  "confidence": 0.945
}
Display: User sees the disease name and confidence percentage.

🛠️ Tech Stack
Frontend (Mobile)
Technology	Usage
Flutter	Cross-platform framework
Dart	Programming logic
Image Picker	Camera & Gallery access
HTTP	Asynchronous API calls

Export to Sheets

Backend (AI Service)
Technology	Usage
Flask	REST API creation
TensorFlow	Model inference engine
Render	Cloud deployment

Export to Sheets

📂 Folder Structure
Bash

Plant_Disease_App/
│
├── lib/
│   ├── main.dart               # 🏁 App entry point
│   ├── screens/
│   │   ├── home_screen.dart    # 📸 Capture & Upload UI
│   │   ├── result_screen.dart  # 📊 Prediction Display
│   ├── services/
│   │   └── api_service.dart    # 🔌 API Logic (HTTP)
│   └── widgets/
│       └── custom_button.dart  # 🧩 Reusable UI components
│
├── android/                    # 🤖 Native Android config
├── ios/                        # 🍎 Native iOS config
├── pubspec.yaml                # 📦 Dependencies
└── README.md                   # 📄 Documentation
🚀 Installation & Setup
Follow these steps to run the app locally on your machine.

1️⃣ Clone the Repository
Bash

git clone https://github.com/Abhii9180/PlantDiseaseApp.git
cd PlantDiseaseApp
2️⃣ Install Dependencies
Bash

flutter pub get
3️⃣ Run the App
Select your target device (Emulator or Physical) and run:

Bash

flutter run
🔗 Code Highlight: API Integration
Here is how the Flutter app communicates with the Python backend:

Dart

// Example of the POST request logic in api_service.dart
var request = http.MultipartRequest(
  'POST',
  Uri.parse("https://plant-disease-api.onrender.com/predict"),
);

// Add the image file
request.files.add(
  await http.MultipartFile.fromPath('file', image.path),
);

// Send request and await response
var response = await request.send();
📥 APK Download
Want to try it out without compiling?

<a href="YOUR_APK_DRIVE_LINK_HERE"> <img src="https://upload.wikimedia.org/wikipedia/commons/7/78/Google_Play_Store_badge_EN.svg" width="150" alt="Download APK"> </a>

👨‍💻 Developer
Abhyuday Pratap Singh AI & Full-Stack Developer

Skills: Flutter • Python • Machine Learning • Cloud Technologies

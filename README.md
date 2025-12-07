
# 🌿 Plant Disease Detection – Mobile Application

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![TensorFlow](https://img.shields.io/badge/TensorFlow-FF6F00?style=for-the-badge&logo=tensorflow&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white)
![Render](https://img.shields.io/badge/Render-46E3B7?style=for-the-badge&logo=render&logoColor=white)

> **Phase 3 of the AI-Powered Plant Disease Detection System** > *Developed by [Abhyuday Pratap Singh](https://github.com/Abhii9180)*

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
1️⃣ Model Training (The Brain)Architecture: MobileNetV2 (Transfer Learning)Dataset: PlantVillage (38 Disease Classes)Accuracy: ~97% (Fine-tuned)Output: plant_mnv2.keras2️⃣ Backend (The Bridge)Framework: Flask (Python)Deployment: Render Cloud HostingEndpoint: https://plant-disease-api.onrender.com/predict3️⃣ Mobile App (The Interface)Framework: Flutter (Dart)Role: Image acquisition, compression, and result visualization.🧠 How It WorksCapture: User takes a photo of a plant leaf.Compress: App optimizes image size for faster transmission.Analyze: Image is sent to the Flask API via HTTP POST.Predict: API returns a JSON response:JSON{
  "predicted_class": "Tomato — Early Blight",
  "confidence": 0.945
}
Display: User sees the disease name and confidence percentage.🛠️ Tech StackFrontend (Mobile)TechnologyUsageFlutterCross-platform frameworkDartProgramming logicImage PickerCamera & Gallery accessHTTPAsynchronous API callsBackend (AI Service)TechnologyUsageFlaskREST API creationTensorFlowModel inference engineRenderCloud deployment📂 Folder StructureBashPlant_Disease_App/
│
├── lib/
│   ├── main.dart               # 🏁 App entry point
│   ├── screens/
│   │   ├── home_screen.dart    # 📸 Capture & Upload UI
│   │   └── result_screen.dart  # 📊 Prediction Display
│   ├── services/
│   │   └── api_service.dart    # 🔌 API Logic (HTTP)
│   └── widgets/
│       └── custom_button.dart  # 🧩 Reusable UI components
│
├── android/                    # 🤖 Native Android config
├── ios/                        # 🍎 Native iOS config
├── pubspec.yaml                # 📦 Dependencies
└── README.md                   # 📄 Documentation
🚀 Installation & SetupFollow these steps to run the app locally on your machine.1️⃣ Clone the RepositoryBashgit clone [https://github.com/Abhii9180/PlantDiseaseApp.git](https://github.com/Abhii9180/PlantDiseaseApp.git)
cd PlantDiseaseApp
2️⃣ Install DependenciesBashflutter pub get
3️⃣ Run the AppSelect your target device (Emulator or Physical) and run:Bashflutter run
🔗 Code Highlight: API IntegrationHere is how the Flutter app communicates with the Python backend:Dart// Example of the POST request logic in api_service.dart
var request = http.MultipartRequest(
  'POST',
  Uri.parse("[https://plant-disease-api.onrender.com/predict](https://plant-disease-api.onrender.com/predict)"),
);

// Add the image file
request.files.add(
  await http.MultipartFile.fromPath('file', image.path),
);

// Send request and await response
var response = await request.send();
📥 APK DownloadWant to try it out without compiling?ShutterstockDownload the Latest Release (.apk)👨‍💻 DeveloperAbhyuday Pratap SinghAI & Full-Stack DeveloperSkills: Flutter • Python • Machine Learning • Cloud Technologies
---

### 💡 Recommendation for the "Screenshots"
To make this truly attractive, you **must** add screenshots.
1.  Take a screenshot of the Home Screen (Camera view).
2.  Take a screenshot of the Result Screen (Disease prediction).
3.  Place them in a folder named `screenshots` in your repo.
4.  Add this code under the "App Overview" section:

```markdown
<p align="center">
  <img src="screenshots/home.png" width="200" alt="Home Screen">
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="screenshots/result.png" width="200" alt="Result Screen">
</p>

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

// --- Configuration ---
// Your API URL (already correct!)
const String apiUrl = "https://plantdiseaseapi-owi3.onrender.com/predict";
// The key your Flask API expects
const String apiKey = "file";
// ---------------------

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Disease API',
      debugShowCheckedModeBanner: false, // Hides the debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const ClassifierHome(),
    );
  }
}

class ClassifierHome extends StatefulWidget {
  const ClassifierHome({super.key});

  @override
  State<ClassifierHome> createState() => _ClassifierHomeState();
}

class _ClassifierHomeState extends State<ClassifierHome> {
  XFile? _imageFile;
  String _predictionResult = "";
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  void _showLoading(String message) {
    setState(() {
      _isLoading = true;
      _predictionResult = message;
    });
  }

  void _setResult(String message) {
    setState(() {
      _isLoading = false;
      _predictionResult = message;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile == null) return; // User cancelled

      setState(() {
        _imageFile = pickedFile;
        _predictionResult = ""; // Clear old result
      });
    } catch (e) {
      _setResult("Failed to pick image: $e");
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      _setResult("Please select an image first.");
      return;
    }

    _showLoading("Uploading & Analyzing...\n(This may take 15-20s for the server to wake up)");

    try {
      // 1. Create the POST request
      var request = http.MultipartRequest("POST", Uri.parse(apiUrl));

      // 2. Read the file as bytes
      var fileBytes = await _imageFile!.readAsBytes();
      
      // 3. Create the multipart file
      var multipartFile = http.MultipartFile.fromBytes(
        apiKey, // The key 'file'
        fileBytes,
        filename: _imageFile!.name,
        contentType: MediaType('image', 'jpeg'), 
      );

      // 4. Add the file to the request
      request.files.add(multipartFile);

      // 5. Send the request
      var response = await request.send();

      // 6. Get the response body
      var responseBody = await response.stream.bytesToString();

      // 7. Handle the response
      if (response.statusCode == 200) {
        var data = jsonDecode(responseBody);
        String prediction = data['predicted_class'] ?? 'N/A';
        double confidence = (data['confidence'] ?? 0.0) * 100;
        _setResult(
          "Prediction: $prediction\nConfidence: ${confidence.toStringAsFixed(2)}%",
        );
      } else {
        // Show the error from the server
        _setResult(
          "Error: ${response.statusCode}\nResponse: $responseBody",
        );
      }
    } catch (e) {
      _setResult("Error uploading: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🌿 Plant Disease Classifier'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Image preview box
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: _imageFile == null
                        ? const Text('No image selected.',
                            style: TextStyle(color: Colors.grey))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(_imageFile!.path),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 24),
                // Buttons for Camera/Gallery
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Camera'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Gallery'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Analyze Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _uploadImage,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      backgroundColor: Colors.green.shade700,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Analyze Plant'),
                  ),
                ),
                const SizedBox(height: 32),
                // Result Display
                _isLoading
                    ? Column(
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 16),
                          Text(
                            _predictionResult,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        _predictionResult,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
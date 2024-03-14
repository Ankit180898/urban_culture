import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urban_culture/controller/auth_controller.dart';
import 'package:urban_culture/services/firestore_service.dart'; // Import your Firestore service

class HomeController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final FirestoreService firestoreService = FirestoreService(); // Instantiate your Firestore service

  var photoUploaded = false.obs; // Flag to track if a photo has been uploaded
  String? imagePath; // Variable to store the image path
  int streakCounter = 0; // Counter to track the streaks
  RxList<Map<String, dynamic>> skincareProducts = <Map<String, dynamic>>[
    {'name': 'Cleanser', 'description': 'Cetaphil Gentle Skin Cleanser', 'completed': false.obs},
    {'name': 'Toner', 'description': 'Thayers Witch Hazel Toner', 'completed': false.obs},
    {'name': 'Moisturizer', 'description': "Kiehl's Ultra Facial Cream", 'completed': false.obs},
    {'name': 'Sunscreen', 'description': 'Supergoop Unseen Sunscreen SPF 40', 'completed': false.obs},
    {'name': 'Lip Balm', 'description': 'Glossier Birthday Balm Dotcom', 'completed': false.obs},
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Check streaks when the app starts
    // checkStreaks();
  }

  Future<void> logout() async {
    await authController.signOut();
  }
  List<bool> routineCompletionStatuses = List.generate(
    5,
        (_) => false,
  );

  Future<void> saveSkincareRoutine(int index) async {
    // Get user ID from AuthController
    final String userId = authController.email ?? '';

    // Check if user is authenticated
    if (userId.isNotEmpty) {
      try {
        // Pick and upload image
        final File? pickedImage = await pickImage();
        if (pickedImage != null) {
          imagePath = await uploadImage(pickedImage);
          if (imagePath != null) {
            skincareProducts[index]['completed'].value=true;
          }
        }

        await firestoreService.addSkincareRoutine(
          userId: userId,
          faceWashCompleted: skincareProducts[0]['completed'].value,
          tonerCompleted: skincareProducts[1]['completed'].value,
          moisturizerCompleted: skincareProducts[2]['completed'].value,
          sunscreenCompleted: skincareProducts[3]['completed'].value,
          lipBalmCompleted: skincareProducts[4]['completed'].value,
          photoPaths: photoUploaded.value ? [imagePath!] : [],
          streaks: streakCounter,
        );
        print('Skincare routine saved successfully!');
      } catch (error) {
        print('Error saving skincare routine: $error');
      }
    } else {
      print('User not authenticated');
    }
  }

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      // Generate a unique filename or path for the uploaded image
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Reference to Firebase Storage bucket with the generated filename
      final storageRef = FirebaseStorage.instance.ref().child('images/$fileName');

      // Upload image to Firebase Storage
      final uploadTask = storageRef.putFile(imageFile);

      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

      // Get the download URL of the uploaded image
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (error) {
      print('Error uploading image: $error');
      return null;
    }
  }

  Future<void> checkStreaks() async {
    // Get user ID from AuthController
    final String userId = authController.email ?? '';

    // Get the last recorded skincare routine date from Firestore
    final DateTime lastRecordedDate = await firestoreService.getLastRecordedDate(userId);

    // Compare the last recorded date with the current date
    final DateTime currentDate = DateTime.now();
    final bool isRoutineRecordedToday = currentDate.difference(lastRecordedDate).inDays == 0;

    // Update streak counter based on routine recording status
    if (isRoutineRecordedToday) {
      streakCounter++; // Increment streak counter
    } else {
      streakCounter = 0; // Reset streak counter
    }

    // Save streak counter to Firestore
    await firestoreService.updateStreakCounter(userId, streakCounter);
  }
}

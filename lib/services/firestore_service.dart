import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUserToFirestore(String email, String displayName) async {
    try {
      // Check if the user already exists in the 'users' collection
      final DocumentSnapshot userSnapshot = await _firestore
          .collection('users')
          .doc(email)
          .get();

      if (userSnapshot.exists) {
        // User already exists, do not add duplicate entry
        print('User already exists in Firestore.');
        return;
      }

      // User does not exist, add new entry to Firestore with email as document ID
      await _firestore.collection('users').doc(email).set({
        'email': email,
        'displayName': displayName,
        // Add other user data if needed
      });

      print('User added to Firestore successfully.');
    } catch (error) {
      print('Error adding user to Firestore: $error');
    }
  }

  Future<void> addSkincareRoutine({
    required String userId,
    required bool faceWashCompleted,
    required bool tonerCompleted,
    required bool moisturizerCompleted,
    required bool sunscreenCompleted,
    required bool lipBalmCompleted,
    required List<String> photoPaths,
    required int streaks,
  }) async {
    try {
      // Add a new document with auto-generated ID
      await _firestore.collection('skincare_routines').add({
        'userId': userId,
        'date': Timestamp.now(),
        'faceWashCompleted': faceWashCompleted,
        'tonerCompleted': tonerCompleted,
        'moisturizerCompleted': moisturizerCompleted,
        'sunscreenCompleted': sunscreenCompleted,
        'lipBalmCompleted': lipBalmCompleted,
        'photoPaths': photoPaths,
        'streaks': streaks,
      });
      print('Skincare routine added successfully!');
    } catch (error) {
      print('Error adding skincare routine: $error');
    }
  }
  Future<void> updateStreakCounter(String userId, int streakCounter) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'streaks': streakCounter,
      });
      print('Streak counter updated successfully!');
    } catch (error) {
      print('Error updating streak counter: $error');
    }
  }

  Future<DateTime> getLastRecordedDate(String userId) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('skincare_routines')
          .where('email', isEqualTo: userId)
          .orderBy('date', descending: true)
          .limit(1)
          .get();

      final List<DocumentSnapshot> documents = querySnapshot.docs;
      if (documents.isNotEmpty) {
        final Map<String, dynamic> data = documents.first.data() as Map<String, dynamic>;
        final Timestamp timestamp = data['date'] as Timestamp;
        return timestamp.toDate();
      } else {
        // No recorded date found, return a default date
        return DateTime.now();
      }
    } catch (error) {
      print('Error getting last recorded date: $error');
      // Return current date in case of error
      return DateTime.now();
    }
  }
}

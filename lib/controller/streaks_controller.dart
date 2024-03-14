import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StreaksController extends GetxController {
  RxInt streaksCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Call a method to fetch streaks count from Firestore when the controller initializes
    fetchStreaksCount();
  }

  Future<void> fetchStreaksCount() async {
    try {
      // Access Firestore collection containing streaks count data
      final DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('streaks').doc('streaksDocument').get();

      // Extract streaks count from the snapshot
      final int count = snapshot.data()?['streaks'] ?? 0;

      // Update streaks count observable
      streaksCount.value = count;
    } catch (error) {
      print('Error fetching streaks count: $error');
    }
  }
}

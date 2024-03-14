import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_culture/controller/home_controller.dart';
import 'package:urban_culture/res/constants.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> skincareProducts = [
    {'name': 'Cleanser', 'description': 'Cetaphil Gentle Skin Cleanser'},
    {'name': 'Toner', 'description': 'Thayers Witch Hazel Toner'},
    {'name': 'Moisturizer', 'description': "Kiehl's Ultra Facial Cream"},
    {'name': 'Sunscreen', 'description': 'Supergoop Unseen Sunscreen SPF 40 '},
    {'name': 'Lip Balm', 'description': 'Glossier Birthday Balm Dotcom'},
  ];

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          "Daily Skincare",
          style: GoogleFonts.epilogue(
            textStyle: TextStyle(
              color: headerTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              controller.logout();
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: skincareProducts.length,
        itemBuilder: (context, index) {
          return Obx(()=>
            ListTile(
              leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: controller.skincareProducts[index]['completed'].value ? Colors.green : secondaryColor,

                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              title: Text(
                skincareProducts[index]['name']!,
                style: GoogleFonts.epilogue(
                  textStyle: TextStyle(
                    color: headerTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              subtitle: Text(
                skincareProducts[index]['description']!,
                style: GoogleFonts.epilogue(
                  textStyle: TextStyle(
                    color: bodyTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              trailing: ElevatedButton(
                onPressed: () async {
                  // Pick and upload photo
                  File? pickedImage = await controller.pickImage();
                  if (pickedImage != null) {
                    await controller.saveSkincareRoutine(index);
                  }
                  ;
                  if (controller.skincareProducts[index]['completed'].value) {
                    // Show toast
                    Get.snackbar(
                      'Photo Uploaded',
                      'Photo for ${skincareProducts[index]['name']} uploaded successfully',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  }
                },
                child: const Text("Upload Photo"),
              ),
            ),
          );
        },
      ),
    );
  }
}

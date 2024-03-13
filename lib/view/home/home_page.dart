import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_culture/res/constants.dart';
class HomePage extends StatelessWidget {
  final List<Map<String, String>> skincareProducts = [
    {
      'name': 'Cleanser',
      'description': 'Cetaphil Gentle Skin Cleanser'
    },
    {
      'name': 'Toner',
      'description': 'Thayers Witch Hazel Toner'
    },
    {
      'name': 'Moisturizer',
      'description': "Kiehl's Ultra Facial Cream"
    },
    {
      'name': 'Sunscreen',
      'description': 'Supergoop Unseen Sunscreen SPF 40 '
    },
    {
      'name': 'Lip Balm',
      'description': 'Glossier Birthday Balm Dotcom'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
     appBar: AppBar(
       title: Text("Daily Skincare",style: GoogleFonts.epilogue(color:headerTextColor,fontWeight:FontWeight.bold,)),
       centerTitle: true,
       backgroundColor: Colors.transparent,
     ),
      body: ListView.builder(
          itemCount:skincareProducts.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: secondaryColor,
                ),
                child: Center(
                  child: Icon(Icons.check),
                ),
              ),
              title: Text(skincareProducts[index]['name']!,style: GoogleFonts.epilogue(color:headerTextColor)),
              subtitle: Text(skincareProducts[index]['description']!,style: GoogleFonts.epilogue(color:bodyTextColor)),
            );
          }
      ),
    );
  }
}

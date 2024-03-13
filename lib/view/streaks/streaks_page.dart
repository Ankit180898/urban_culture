import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:urban_culture/res/constants.dart';

class StreaksPage extends StatelessWidget {
  const StreaksPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Streaks",style: GoogleFonts.epilogue(
            textStyle: TextStyle(
                color: headerTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w700))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today's Goal: 3 streak days",style: GoogleFonts.epilogue(
            textStyle: TextStyle(
                color: headerTextColor,
                fontSize: 22,
                fontWeight: FontWeight.w700))),
            defaultPadding,
            Container(
              padding: EdgeInsets.all(16),
              height: size.height*0.13,
              width: size.width,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(16),

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Streak Days",style: GoogleFonts.epilogue(
                      textStyle: TextStyle(
                          color: headerTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500))),
                  const SizedBox(height: 5,),
                  Text("2",style: GoogleFonts.epilogue(
                      textStyle: TextStyle(
                          color: headerTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700)))
                ],
              ),
            ),
            defaultPadding,
            defaultPadding,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Daily Streak",style: GoogleFonts.epilogue(
                    textStyle: TextStyle(
                        color: headerTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500))),
                Text("2",style: GoogleFonts.epilogue(
                    textStyle: TextStyle(
                        color: headerTextColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w700)))
              ],
            ),
            defaultPadding,
            defaultPadding,
            Container(
                child: SfSparkLineChart(
                   color: bodyTextColor,

                  data: <double>[
                    1, 5, -6, 0, 1, -2, 7, -7, -4, -10, 13, -6, 7, 5, 11, 5, 3
                  ],
                )
            )

          ],
        ),
      ),
    );
  }
}

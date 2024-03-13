import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_culture/res/constants.dart';
import 'package:urban_culture/view/home/home_page.dart';
import 'package:urban_culture/view/streaks/streaks_page.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _tabs = [
    HomePage(),
    StreaksPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ensure _selectedIndex falls within the valid range
    _selectedIndex = _selectedIndex.clamp(0, _tabs.length - 1);

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: _tabs,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _onItemTapped(0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _selectedIndex == 0
                      ? Image.asset(
                          "assets/search.png",
                          color: headerTextColor,
                          height: 24,
                          width: 24,
                        )
                      : Image.asset(
                          "assets/search.png",
                          height: 24,
                          width: 24,
                        ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('Routine',
                      style: GoogleFonts.epilogue(
                          textStyle: TextStyle(
                              color: _selectedIndex == 0
                                  ? headerTextColor
                                  : bodyTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500))),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            GestureDetector(
              onTap: () => _onItemTapped(1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _selectedIndex == 1
                      ? Image.asset(
                          "assets/people.png",
                          color: headerTextColor,
                          height: 24,
                          width: 24,
                        )
                      : Image.asset(
                          "assets/people.png",
                          height: 24,
                          width: 24,
                        ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('Streaks',
                      style: GoogleFonts.epilogue(
                          textStyle: TextStyle(
                              color: _selectedIndex == 1
                                  ? headerTextColor
                                  : bodyTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

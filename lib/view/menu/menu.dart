import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myapp/helpers/icon_constants.dart';
import 'package:myapp/helpers/utils.dart';
import 'package:myapp/view/friends/friends.dart';
import 'package:myapp/view/home/home.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _bottomNavIndex = 0;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;

  final iconList = <String>[
    IconsConstants.home,
    IconsConstants.addfriend,
  ];
  final List _pages = <Widget>[
    const HomePage(),
   const Friends(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffF2F2F2),
      body: _pages[_bottomNavIndex],
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          backgroundColor: const Color(0xff1488CC),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return const AlertPage();
            // }));
          },
          child: appIcon(IconsConstants.add, false, context, 20, 20,
              color: Colors.white),
          //params
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        safeAreaValues: const SafeAreaValues(bottom: true),
        itemCount: iconList.length,
        tabBuilder: (index, isActive) {
          final color =
              (isActive) ? const Color(0xff1488CC) : const Color(0xffA4A4A4);

          return SizedBox(
            height: 80,
            width: 100,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: (isActive)
                                ? const Color(0xffE9F1F5)
                                : const Color(0xffF5F5F5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: isActive
                                  ? appIcon(
                                      iconList[index], false, context, 20, 20,
                                      color: color)
                                  : appIcon(
                                      iconList[index], false, context, 20, 20,
                                      color: const Color(0xffA4A4A4))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        // icons: iconList,
        shadow: Shadow(
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 10.0,
        ),
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,

        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        //other params
      ),
    );
  }
}

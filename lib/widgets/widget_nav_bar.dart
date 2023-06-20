import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lms_app_tugbes/shared/theme.dart';

class NavBarMenu extends StatefulWidget {
  final List<Widget> pageOption;
  const NavBarMenu({super.key, required this.pageOption});

  @override
  State<NavBarMenu> createState() => _NavBarMenuState();
}

class _NavBarMenuState extends State<NavBarMenu> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final MediaQueryofWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: widget.pageOption.elementAt(selectedIndex),
      floatingActionButton: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 17),
              blurRadius: 215,
              color: const Color(0xff7281DF).withOpacity(.12),
            ),
            BoxShadow(
              offset: const Offset(0, 3.84),
              blurRadius: 22.2,
              color: const Color(0xff7281DF).withOpacity(.08),
            ),
          ],
        ),
        child: GNav(
          activeColor: blueColor,
          color: secondaryColor,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: MediaQueryofWidth / 9),
          tabs: const [
            GButton(
              icon: Icons.home_filled,
            ),
            GButton(
              icon: Icons.school_rounded,
            ),
            GButton(
              icon: Icons.person_2_rounded,
            ),
          ],
          selectedIndex: selectedIndex,
          onTabChange: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

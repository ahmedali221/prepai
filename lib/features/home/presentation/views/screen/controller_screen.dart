import 'package:flutter/material.dart';
import 'package:prepai/features/Home/presentation/views/screen/profile_screen.dart';
import 'package:prepai/features/food_chat/presentation/pages/chat_page.dart';
import '../../../../../Core/theme/app_colors.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';

class ControllerScreen extends StatefulWidget {
  const ControllerScreen({super.key});

  @override
  State<ControllerScreen> createState() => _ControllerScreenState();
}

class _ControllerScreenState extends State<ControllerScreen> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    MyHomeScreen(),
    FavoriteScreen(),
    ChatPage(),
    ProfileScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent,
        unselectedItemColor: AppColors.c939393,
        onTap: onTabTapped,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            activeIcon: CircleAvatar(
              backgroundColor: AppColors.c001A3F,
              radius: 35,
              child: Icon(
                Icons.home,
                color: AppColors.cFFFFFF,
                size: 40,
              ),
            ),
            label: "Home",
            icon: Icon(
              Icons.home,
              color: AppColors.c001A3F,
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: CircleAvatar(
              backgroundColor: AppColors.c001A3F,
              radius: 35,
              child: Icon(
                Icons.favorite_border,
                color: AppColors.cFFFFFF,
                size: 40,
              ),
            ),
            label: "Favorite",
            icon: Icon(
              Icons.favorite_border,
              color: AppColors.c001A3F,
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: CircleAvatar(
              backgroundColor: AppColors.c001A3F,
              radius: 35,
              child: Icon(
                Icons.chat_bubble,
                color: AppColors.cFFFFFF,
                size: 40,
              ),
            ),
            label: "Chat",
            icon: Icon(
              Icons.chat_bubble,
              color: AppColors.c001A3F,
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: CircleAvatar(
              backgroundColor: AppColors.c001A3F,
              radius: 35,
              child: Icon(
                Icons.person,
                color: AppColors.cFFFFFF,
                size: 40,
              ),
            ),
            label: "Profile",
            icon: Icon(
              Icons.person,
              color: AppColors.c001A3F,
            ),
          ),
        ],
      ),
    );
  }
}

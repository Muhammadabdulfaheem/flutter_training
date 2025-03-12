import 'package:flutter/material.dart';
import 'package:flutter_training_project/providers.dart/bottom_nav_provider.dart';
import 'package:flutter_training_project/screens/home/home_tab.dart';
import 'package:flutter_training_project/screens/movies/movies_tab.dart';
import 'package:flutter_training_project/screens/profile_tab.dart';
import 'package:flutter_training_project/screens/search_tab.dart';
import 'package:flutter_training_project/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({super.key});

  @override
  State<Tabbar> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<Tabbar> {
  final List<Widget> _tabs = [
    HomeTab(),
    SearchTab(),
    MoviesTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      body: _tabs[bottomNavProvider.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primaryColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.textColor,
        unselectedItemColor: AppColors.secondaryColor,
        currentIndex: bottomNavProvider.selectedIndex,
        onTap:
            (index) =>
                setState(() => bottomNavProvider.setSelectedIndex(index)),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }
}

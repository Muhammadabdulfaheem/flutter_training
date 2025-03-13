import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training_project/screens/home/home_tab.dart';
import 'package:flutter_training_project/screens/movies/movies_tab.dart';
import 'package:flutter_training_project/screens/profile_tab.dart';
import 'package:flutter_training_project/screens/search_tab.dart';
import 'package:flutter_training_project/screens/tabbar/bloc/tabbar_cubit.dart';
import 'package:flutter_training_project/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class Tabbar extends StatelessWidget {
  Tabbar({super.key});

  final List<Widget> _tabs = [
    HomeTab(),
    SearchTab(),
    MoviesTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TabbarCubit, int>(
        builder: (context, currentIndex) {
          return _tabs[currentIndex];
        },
      ),
      bottomNavigationBar: BlocBuilder<TabbarCubit, int>(
        builder: (context, currentIndex) {
          return BottomNavigationBar(
            backgroundColor: AppColors.primaryColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.textColor,
            unselectedItemColor: AppColors.secondaryColor,
            currentIndex: currentIndex,
            onTap: (index) => context.read<TabbarCubit>().updatedIndex(index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.movie), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
            ],
          );
        },
      ),
    );
  }
}

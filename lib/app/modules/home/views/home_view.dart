import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: AppColors.primaryGreen,
      ),
      body: Center(
        child: Text('Main App Screen', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../widgets/custom_bottom_bar.dart';
import '../daily_meal_plan/daily_meal_plan.dart';
import '../grocery_list/grocery_list.dart';
import '../health_insights/health_insights.dart';
import './dashboard_initial_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardInitialPage(),
    const DailyMealPlan(),
    const GroceryList(),
    const HealthInsights(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DailyMealPlan()),
            );
          } else {
            setState(() => _currentIndex = index);
          }
        },
      ),
    );
  }
}

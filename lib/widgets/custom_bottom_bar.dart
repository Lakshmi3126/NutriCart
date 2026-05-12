import 'package:flutter/material.dart';

/// Custom bottom navigation bar widget for the healthcare nutrition app.
/// Implements thumb-reachable navigation with core daily functions.
///
/// Navigation items are based on the Mobile Navigation Hierarchy:
/// - Dashboard: Central meal overview and daily progress
/// - Meal Plans: Daily and weekly meal planning interface
/// - Grocery: Automated shopping lists with budget tracking
/// - Health Insights: Health analytics and personalized nutrition guidance
class CustomBottomBar extends StatelessWidget {
  /// Current selected index
  final int currentIndex;

  /// Callback when navigation item is tapped
  final Function(int) onTap;

  const CustomBottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      elevation: 8.0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          activeIcon: Icon(Icons.dashboard),
          label: 'Dashboard',
          tooltip: 'View daily meal overview and progress',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu_outlined),
          activeIcon: Icon(Icons.restaurant_menu),
          label: 'Meal Plans',
          tooltip: 'Plan your daily and weekly meals',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: 'Grocery',
          tooltip: 'Manage shopping lists and budget',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insights_outlined),
          activeIcon: Icon(Icons.insights),
          label: 'Insights',
          tooltip: 'View health analytics and recommendations',
        ),
      ],
    );
  }
}

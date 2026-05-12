import 'package:flutter/material.dart';
import '../presentation/meal_details/meal_details.dart';
import '../presentation/user_profile_setup/user_profile_setup.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/dashboard/dashboard.dart';
import '../presentation/grocery_list/grocery_list.dart';
import '../presentation/daily_meal_planning/daily_meal_planning.dart';
import '../presentation/daily_meal_plan/daily_meal_plan.dart';
import '../presentation/health_insights/health_insights.dart';
import '../presentation/pantry_management/pantry_management.dart';
import '../presentation/meal_re_engineering/meal_re_engineering.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String mealDetails = '/meal-details';
  static const String userProfileSetup = '/user-profile-setup';
  static const String login = '/login-screen';
  static const String dashboard = '/dashboard';
  static const String groceryList = '/grocery-list';
  static const String dailyMealPlanning = '/daily-meal-planning';
  static const String dailyMealPlan = '/daily-meal-plan';
  static const String healthInsights = '/health-insights';
  static const String pantryManagement = '/pantry-management';
  static const String mealReEngineering = '/meal-re-engineering';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const LoginScreen(),
    mealDetails: (context) => const MealDetails(),
    userProfileSetup: (context) => const UserProfileSetup(),
    login: (context) => const LoginScreen(),
    dashboard: (context) => const Dashboard(),
    groceryList: (context) => const GroceryList(),
    dailyMealPlanning: (context) => const DailyMealPlanning(),
    dailyMealPlan: (context) => const DailyMealPlan(),
    healthInsights: (context) => const HealthInsights(),
    pantryManagement: (context) => const PantryManagement(),
    mealReEngineering: (context) => const MealReEngineering(),
    // TODO: Add your other routes here
  };
}

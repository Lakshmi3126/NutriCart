  /// Mocked data service for Meal Re-engineering
  /// Provides realistic meal substitution data structured like a real API response
  class MealReEngineeringMockService {
    /// Get meal re-engineering data showing original vs updated meal comparison
    static Future<Map<String, dynamic>> getMealReEngineeringData() async {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 850));

      return {
        'updateId': 'update_001',
        'timestamp': DateTime.now().toIso8601String(),
        'originalMeal': {
          'id': 'meal_original_001',
          'name': 'White Rice + Potato Fry + Coconut Chutney',
          'calories': 620,
          'cost': 78.0,
          'status': 'high_gi_high_sodium',
          'statusColor': '#E53935',
          'image': 'assets/images/meals/white rice +potato fry +coconut chutney.png',
          'semanticLabel': 'Rice meal with potato fry and chutney',
        },
        'updatedMeal': {
          'id': 'meal_updated_001',
          'name': 'Brown+White Rice Mix + Beans Poriyal + Low-Salt Chutney',
          'calories': 505,
          'cost': 74.0,
          'status': 'recommended',
          'statusColor': '#43A047',
          'image': 'assets/images/meals/brown_white_rice_mix_sambar_beans_poriyal_curd.png',
          'semanticLabel': 'Balanced rice plate with poriyal and chutney',
        },
        'reason': {
          'title': 'Why this meal was modified',
          'primaryReason': 'Glucose and sodium optimization',
          'explanations': [
            {
              'type': 'original',
              'icon': 'restaurant',
              'title': 'Original meal',
              'description':
                  'White Rice + Potato Fry + Coconut Chutney',
            },
            {
              'type': 'updated',
              'icon': 'auto_fix_high',
              'title': 'NutriCart modification',
              'description':
                  'Brown+White Rice Mix + Beans Poriyal + Low-Salt Chutney',
            },
            {
              'type': 'clinical',
              'icon': 'health_and_safety',
              'title': 'Why it was modified',
              'description':
                  'Large white-rice portion and salted chutney were increasing post-lunch sugar swings and sodium load.',
            },
            {
              'type': 'benefit',
              'icon': 'monitor_heart',
              'title': 'Health benefit',
              'description':
                  'Balanced carbohydrate distribution supports glucose stability, while reduced sodium may support blood pressure management.',
            },
          ],
        },
        'impact': {
          'calorieChange': -115,
          'calorieChangePercentage': -18.5,
          'costChange': -4.0,
          'costChangePercentage': -5.1,
          'healthImpact': 'improved',
          'healthImpactLabel': 'Improved',
          'healthImpactDescription':
              'Portion balancing and lower-sodium prep improve meal quality without changing familiar foods.',
        },
        'alternatives': [
          {
            'id': 'alt_001',
            'name': 'Millet Lemon Rice + Sprouts Kosambari',
            'calories': 460,
            'cost': 68.0,
            'healthBadge': 'Low glycemic',
          },
          {
            'id': 'alt_002',
            'name': '2 Phulkas + Lauki Dal + Cucumber Salad',
            'calories': 445,
            'cost': 72.0,
            'healthBadge': 'Sodium aware',
          },
        ],
      };
    }

    /// Get multiple meal updates (for notification count)
    static Future<int> getPendingUpdatesCount() async {
      await Future.delayed(const Duration(milliseconds: 300));
      return 3;
    }
  }

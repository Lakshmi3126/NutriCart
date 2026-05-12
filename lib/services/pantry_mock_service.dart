/// Mocked data service for Pantry Management
/// Provides realistic pantry inventory data structured like a real API response
class PantryMockService {
  /// Get pantry inventory with categorized ingredients
  static Future<Map<String, dynamic>> getPantryInventory() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return {
      'categories': [
        {
          'name': 'Vegetables',
          'icon': 'eco',
          'items': [
            {
              'id': 'veg_001',
              'name': 'Onions',
              'quantity': 2.0,
              'unit': 'kg',
              'currentStock': 2.0,
              'maxStock': 3.0,
              'purchaseDate': '2026-01-20',
              'expiryDate': '2026-02-10',
              'daysUntilExpiry': 16,
              'status': 'fresh',
              'usageHistory': [
                {'date': '2026-01-24', 'amount': 0.5, 'meal': 'Lunch'},
                {'date': '2026-01-23', 'amount': 0.3, 'meal': 'Dinner'},
              ],
            },
            {
              'id': 'veg_002',
              'name': 'Tomatoes',
              'quantity': 0.8,
              'unit': 'kg',
              'currentStock': 0.8,
              'maxStock': 2.0,
              'purchaseDate': '2026-01-22',
              'expiryDate': '2026-01-28',
              'daysUntilExpiry': 3,
              'status': 'expiring_soon',
              'usageHistory': [
                {'date': '2026-01-24', 'amount': 0.4, 'meal': 'Breakfast'},
              ],
            },
            {
              'id': 'veg_003',
              'name': 'Spinach',
              'quantity': 0.2,
              'unit': 'kg',
              'currentStock': 0.2,
              'maxStock': 0.5,
              'purchaseDate': '2026-01-15',
              'expiryDate': '2026-01-26',
              'daysUntilExpiry': 1,
              'status': 'expired',
              'usageHistory': [],
            },
            {
              'id': 'veg_004',
              'name': 'Carrots',
              'quantity': 1.5,
              'unit': 'kg',
              'currentStock': 1.5,
              'maxStock': 2.0,
              'purchaseDate': '2026-01-18',
              'expiryDate': '2026-02-15',
              'daysUntilExpiry': 21,
              'status': 'fresh',
              'usageHistory': [
                {'date': '2026-01-23', 'amount': 0.3, 'meal': 'Lunch'},
              ],
            },
          ],
        },
        {
          'name': 'Grains',
          'icon': 'grain',
          'items': [
            {
              'id': 'grain_001',
              'name': 'Basmati Rice',
              'quantity': 3.5,
              'unit': 'kg',
              'currentStock': 3.5,
              'maxStock': 5.0,
              'purchaseDate': '2026-01-10',
              'expiryDate': '2026-07-10',
              'daysUntilExpiry': 167,
              'status': 'fresh',
              'usageHistory': [
                {'date': '2026-01-24', 'amount': 0.3, 'meal': 'Dinner'},
                {'date': '2026-01-23', 'amount': 0.2, 'meal': 'Lunch'},
              ],
            },
            {
              'id': 'grain_002',
              'name': 'Whole Wheat Flour',
              'quantity': 2.0,
              'unit': 'kg',
              'currentStock': 2.0,
              'maxStock': 10.0,
              'purchaseDate': '2026-01-05',
              'expiryDate': '2026-04-05',
              'daysUntilExpiry': 70,
              'status': 'fresh',
              'usageHistory': [
                {'date': '2026-01-24', 'amount': 0.5, 'meal': 'Breakfast'},
              ],
            },
            {
              'id': 'grain_003',
              'name': 'Moong Dal',
              'quantity': 0.5,
              'unit': 'kg',
              'currentStock': 0.5,
              'maxStock': 1.0,
              'purchaseDate': '2026-01-12',
              'expiryDate': '2026-06-12',
              'daysUntilExpiry': 139,
              'status': 'fresh',
              'usageHistory': [
                {'date': '2026-01-23', 'amount': 0.2, 'meal': 'Dinner'},
              ],
            },
          ],
        },
        {
          'name': 'Spices',
          'icon': 'local_dining',
          'items': [
            {
              'id': 'spice_001',
              'name': 'Turmeric Powder',
              'quantity': 150.0,
              'unit': 'g',
              'currentStock': 150.0,
              'maxStock': 200.0,
              'purchaseDate': '2026-01-08',
              'expiryDate': '2026-07-08',
              'daysUntilExpiry': 165,
              'status': 'fresh',
              'usageHistory': [
                {'date': '2026-01-24', 'amount': 5.0, 'meal': 'Lunch'},
              ],
            },
            {
              'id': 'spice_002',
              'name': 'Cumin Seeds',
              'quantity': 80.0,
              'unit': 'g',
              'currentStock': 80.0,
              'maxStock': 100.0,
              'purchaseDate': '2026-01-15',
              'expiryDate': '2026-07-15',
              'daysUntilExpiry': 172,
              'status': 'fresh',
              'usageHistory': [
                {'date': '2026-01-23', 'amount': 3.0, 'meal': 'Dinner'},
              ],
            },
            {
              'id': 'spice_003',
              'name': 'Garam Masala',
              'quantity': 60.0,
              'unit': 'g',
              'currentStock': 60.0,
              'maxStock': 100.0,
              'purchaseDate': '2026-01-10',
              'expiryDate': '2026-06-10',
              'daysUntilExpiry': 137,
              'status': 'fresh',
              'usageHistory': [],
            },
          ],
        },
        {
          'name': 'Dairy',
          'icon': 'local_cafe',
          'items': [
            {
              'id': 'dairy_001',
              'name': 'Milk',
              'quantity': 2.0,
              'unit': 'L',
              'currentStock': 2.0,
              'maxStock': 4.0,
              'purchaseDate': '2026-01-24',
              'expiryDate': '2026-01-27',
              'daysUntilExpiry': 2,
              'status': 'expiring_soon',
              'usageHistory': [
                {'date': '2026-01-24', 'amount': 0.5, 'meal': 'Breakfast'},
              ],
            },
            {
              'id': 'dairy_002',
              'name': 'Yogurt',
              'quantity': 0.5,
              'unit': 'kg',
              'currentStock': 0.5,
              'maxStock': 1.0,
              'purchaseDate': '2026-01-23',
              'expiryDate': '2026-01-30',
              'daysUntilExpiry': 5,
              'status': 'fresh',
              'usageHistory': [
                {'date': '2026-01-24', 'amount': 0.2, 'meal': 'Snack'},
              ],
            },
            {
              'id': 'dairy_003',
              'name': 'Paneer',
              'quantity': 0.3,
              'unit': 'kg',
              'currentStock': 0.3,
              'maxStock': 0.5,
              'purchaseDate': '2026-01-22',
              'expiryDate': '2026-01-29',
              'daysUntilExpiry': 4,
              'status': 'expiring_soon',
              'usageHistory': [],
            },
          ],
        },
        {
          'name': 'Proteins',
          'icon': 'restaurant',
          'items': [
            {
              'id': 'protein_001',
              'name': 'Chicken Breast',
              'quantity': 0.8,
              'unit': 'kg',
              'currentStock': 0.8,
              'maxStock': 1.0,
              'purchaseDate': '2026-01-23',
              'expiryDate': '2026-01-26',
              'daysUntilExpiry': 1,
              'status': 'expired',
              'usageHistory': [],
            },
            {
              'id': 'protein_002',
              'name': 'Eggs',
              'quantity': 10.0,
              'unit': 'pcs',
              'currentStock': 10.0,
              'maxStock': 12.0,
              'purchaseDate': '2026-01-20',
              'expiryDate': '2026-02-05',
              'daysUntilExpiry': 11,
              'status': 'fresh',
              'usageHistory': [
                {'date': '2026-01-24', 'amount': 2.0, 'meal': 'Breakfast'},
              ],
            },
          ],
        },
      ],
      'summary': {
        'totalItems': 18,
        'freshItems': 11,
        'expiringSoon': 4,
        'expired': 2,
        'lowStock': 5,
      },
    };
  }

  /// Get meal suggestions based on available pantry stock
  static Future<List<Map<String, dynamic>>> getMealSuggestions() async {
    await Future.delayed(const Duration(milliseconds: 600));

    return [
      {
        'id': 'meal_001',
        'name': 'Vegetable Pulao',
        'image':
            'https://images.unsplash.com/photo-1596797038530-2c107229654b?w=400',
        'calories': 380,
        'cost': 45.0,
        'availablePercentage': 90,
        'requiredIngredients': [
          {'name': 'Basmati Rice', 'available': true, 'inPantry': true},
          {'name': 'Onions', 'available': true, 'inPantry': true},
          {'name': 'Carrots', 'available': true, 'inPantry': true},
          {'name': 'Cumin Seeds', 'available': true, 'inPantry': true},
          {'name': 'Green Peas', 'available': false, 'inPantry': false},
        ],
        'missingIngredients': ['Green Peas'],
        'estimatedCost': 20.0,
      },
      {
        'id': 'meal_002',
        'name': 'Dal Tadka',
        'image':
            'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=400',
        'calories': 280,
        'cost': 35.0,
        'availablePercentage': 100,
        'requiredIngredients': [
          {'name': 'Moong Dal', 'available': true, 'inPantry': true},
          {'name': 'Onions', 'available': true, 'inPantry': true},
          {'name': 'Tomatoes', 'available': true, 'inPantry': true},
          {'name': 'Turmeric Powder', 'available': true, 'inPantry': true},
          {'name': 'Cumin Seeds', 'available': true, 'inPantry': true},
        ],
        'missingIngredients': [],
        'estimatedCost': 0.0,
      },
      {
        'id': 'meal_003',
        'name': 'Paneer Butter Masala',
        'image':
            'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=400',
        'calories': 420,
        'cost': 85.0,
        'availablePercentage': 75,
        'requiredIngredients': [
          {'name': 'Paneer', 'available': true, 'inPantry': true},
          {'name': 'Onions', 'available': true, 'inPantry': true},
          {'name': 'Tomatoes', 'available': true, 'inPantry': true},
          {'name': 'Cream', 'available': false, 'inPantry': false},
          {'name': 'Butter', 'available': false, 'inPantry': false},
        ],
        'missingIngredients': ['Cream', 'Butter'],
        'estimatedCost': 60.0,
      },
      {
        'id': 'meal_004',
        'name': 'Egg Curry',
        'image':
            'https://images.unsplash.com/photo-1606491956689-2ea866880c84?w=400',
        'calories': 320,
        'cost': 55.0,
        'availablePercentage': 85,
        'requiredIngredients': [
          {'name': 'Eggs', 'available': true, 'inPantry': true},
          {'name': 'Onions', 'available': true, 'inPantry': true},
          {'name': 'Tomatoes', 'available': true, 'inPantry': true},
          {'name': 'Turmeric Powder', 'available': true, 'inPantry': true},
          {'name': 'Coconut Milk', 'available': false, 'inPantry': false},
        ],
        'missingIngredients': ['Coconut Milk'],
        'estimatedCost': 40.0,
      },
    ];
  }

  /// Simulate adding item to grocery list
  static Future<bool> addToGroceryList(String itemId, double quantity) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return true;
  }

  /// Simulate marking item as used
  static Future<bool> markAsUsed(String itemId, double portionUsed) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return true;
  }

  /// Simulate updating item quantity
  static Future<bool> updateQuantity(String itemId, double newQuantity) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return true;
  }

  /// Simulate adding new item to pantry
  static Future<bool> addNewItem(Map<String, dynamic> itemData) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }
}

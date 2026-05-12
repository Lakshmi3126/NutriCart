import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_widget.dart';
import '../../widgets/empty_state_widget.dart';
import './widgets/add_ingredient_dialog_widget.dart';
import './widgets/budget_summary_card_widget.dart';
import './widgets/ingredient_category_widget.dart';
import '../../l10n/app_localizations.dart';

/// Grocery List screen manages automated shopping lists generated from meal plans
/// with budget tracking and pantry integration.
///
/// Features:
/// - Budget summary with weekly estimate and remaining budget
/// - Categorized ingredient list (Vegetables, Grains, Spices, Dairy)
/// - Swipe actions for pantry and list management
/// - Voice input for adding items
/// - Smart suggestions for frequently purchased items
/// - Budget-conscious substitution suggestions
/// - Offline mode with sync indicator
/// - Share functionality for family members
class GroceryList extends StatefulWidget {
  const GroceryList({Key? key}) : super(key: key);

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final TextEditingController _searchController = TextEditingController();
  bool _isOfflineMode = false;
  bool _isSyncing = false;
  String? _selectedDeliveryOption;

  // Mock data for budget summary
  final Map<String, dynamic> budgetData = {
  "weeklyEstimate": 1920.0,
  "monthlyBudget": 9200.0,
  "spent": 3120.0,
  "remaining": 6080.0,
  "currency": "₹",
};

  // Mock data for categorized ingredients
  final List<Map<String, dynamic>> ingredientCategories = [
    {
      "category": "Vegetables",
      "icon": "eco",
      "items": [
        {
          "id": 1,
          "name": "Onions",
          "quantity": "1.5 kg",
          "price": 54.0,
          "isPurchased": false,
          "inPantry": false,
          "alternatives": ["Small Onions (₹70/kg)", "Leeks (₹85/kg)"],
        },
        {
          "id": 2,
          "name": "Tomatoes",
          "quantity": "1.5 kg",
          "price": 48.0,
          "isPurchased": false,
          "inPantry": false,
          "alternatives": ["Hybrid Tomato (₹40/kg)"],
        },
        {
          "id": 3,
          "name": "Spinach",
          "quantity": "3 bunches",
          "price": 48.0,
          "isPurchased": true,
          "inPantry": false,
          "alternatives": ["Amaranth Greens (₹12/bunch)"],
        },
        {
          "id": 4,
          "name": "Beans",
          "quantity": "750 g",
          "price": 42.0,
          "isPurchased": false,
          "inPantry": true,
          "alternatives": ["Cabbage (₹30/kg)"],
        },
      ],
    },
    {
      "category": "Grains",
      "icon": "grain",
      "items": [
        {
          "id": 5,
          "name": "Sona Masoori Rice",
          "quantity": "5 kg",
          "price": 290.0,
          "isPurchased": false,
          "inPantry": false,
          "alternatives": ["Brown Rice (₹360/5kg)", "Millet Mix (₹90/kg)"],
        },
        {
          "id": 6,
          "name": "Whole Wheat Flour",
          "quantity": "5 kg",
          "price": 220.0,
          "isPurchased": false,
          "inPantry": false,
          "alternatives": ["Ragi Flour (₹65/kg)", "Jowar Flour (₹58/kg)"],
        },
        {
          "id": 7,
          "name": "Toor Dal",
          "quantity": "1 kg",
          "price": 140.0,
          "isPurchased": false,
          "inPantry": false,
          "alternatives": ["Moong Dal (₹130/kg)", "Masoor Dal (₹110/kg)"],
        },
      ],
    },
    {
      "category": "Spices",
      "icon": "local_dining",
      "items": [
        {
          "id": 8,
          "name": "Turmeric Powder",
          "quantity": "100 g",
          "price": 36.0,
          "isPurchased": false,
          "inPantry": true,
          "alternatives": ["Fresh Turmeric (₹25/100g)"],
        },
        {
          "id": 9,
          "name": "Cumin Seeds",
          "quantity": "100 g",
          "price": 42.0,
          "isPurchased": false,
          "inPantry": false,
          "alternatives": ["Jeera Powder (₹40/100g)"],
        },
        {
          "id": 10,
          "name": "Garam Masala",
          "quantity": "50 g",
          "price": 28.0,
          "isPurchased": true,
          "inPantry": false,
          "alternatives": ["Homemade Mix (₹18/50g)"],
        },
      ],
    },
    {
      "category": "Dairy",
      "icon": "local_cafe",
      "items": [
        {
          "id": 11,
          "name": "Toned Milk",
          "quantity": "6 liters",
          "price": 348.0,
          "isPurchased": false,
          "inPantry": false,
          "alternatives": ["Cow Milk (₹64/L)"],
        },
        {
          "id": 12,
          "name": "Low-fat Curd",
          "quantity": "1.5 kg",
          "price": 90.0,
          "isPurchased": false,
          "inPantry": false,
          "alternatives": ["Homemade Curd (₹65/1.5kg)"],
        },
        {
          "id": 13,
          "name": "Paneer",
          "quantity": "400 g",
          "price": 160.0,
          "isPurchased": false,
          "inPantry": false,
          "alternatives": ["Homemade Paneer (₹130/400g)", "Tofu (₹120/400g)"],
        },
      ],
    },
  ];

  double _calculateCartTotal() {
    double total = 0;
    for (final category in ingredientCategories) {
      for (final item in category["items"] as List) {
        final isPurchased = item["isPurchased"] == true;
        final inPantry = item["inPantry"] == true;
        if (!isPurchased && !inPantry) {
          total += (item["price"] as double? ?? 0.0);
        }
      }
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Check network connectivity and set offline mode
  void _checkConnectivity() {
    // Simulate connectivity check
    setState(() {
      _isOfflineMode = false;
    });
  }

  Future<void> _syncGroceryList() async {
    setState(() {
      _isSyncing = true;
    });

    // Simulate sync delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isSyncing = false;
    });
  }

  /// Toggle item purchased status
  void _togglePurchased(int categoryIndex, int itemIndex) {
    setState(() {
      ingredientCategories[categoryIndex]["items"][itemIndex]["isPurchased"] =
          !ingredientCategories[categoryIndex]["items"][itemIndex]["isPurchased"];
    });
  }

  /// Add item to pantry
  void _addToPantry(int categoryIndex, int itemIndex) {
    setState(() {
      ingredientCategories[categoryIndex]["items"][itemIndex]["inPantry"] =
          true;
      ingredientCategories[categoryIndex]["items"][itemIndex]["isPurchased"] =
          true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.grocerySnackAddedToPantry),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              ingredientCategories[categoryIndex]["items"][itemIndex]["inPantry"] =
                  false;
              ingredientCategories[categoryIndex]["items"][itemIndex]["isPurchased"] =
                  false;
            });
          },
        ),
      ),
    );
  }

  /// Remove item from list
  void _removeFromList(int categoryIndex, int itemIndex) {
    final removedItem = ingredientCategories[categoryIndex]["items"][itemIndex];

    setState(() {
      ingredientCategories[categoryIndex]["items"].removeAt(itemIndex);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.grocerySnackRemovedFromList),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              ingredientCategories[categoryIndex]["items"].insert(
                itemIndex,
                removedItem,
              );
            });
          },
        ),
      ),
    );
  }

  /// Show add ingredient dialog
  void _showAddIngredientDialog() {
    showDialog(
      context: context,
      builder: (context) => AddIngredientDialogWidget(
        onAdd: (name, quantity, category) {
          setState(() {
            final categoryIndex = ingredientCategories.indexWhere(
              (cat) => cat["category"] == category,
            );
            if (categoryIndex != -1) {
              ingredientCategories[categoryIndex]["items"].add({
                "id": DateTime.now().millisecondsSinceEpoch,
                "name": name,
                "quantity": quantity,
                "price": 0.0,
                "isPurchased": false,
                "inPantry": false,
                "alternatives": [],
              });
            }
          });
        },
      ),
    );
  }

  /// Show budget substitution suggestions
  void _showBudgetSubstitutions() {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        height: 60.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.groceryBudgetFriendlyAlts,
                  style: theme.textTheme.titleLarge,
                ),
                IconButton(
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: theme.colorScheme.onSurface,
                    size: 24,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              l10n.groceryExceedsBudgetInfo('₹120'),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: ListView(
                children: [
                  _buildSubstitutionCard(
                    theme,
                    l10n.grocerySubstitutionPrompt(
                      '100% white rice',
                      '60:40 white + brown rice',
                    ),
                    l10n.grocerySaveAmount('₹45'),
                    'Lower glycemic impact with similar taste acceptance',
                  ),
                  _buildSubstitutionCard(
                    theme,
                    l10n.grocerySubstitutionPrompt(
                      'Out-of-season cauliflower',
                      'Beans or cabbage',
                    ),
                    l10n.grocerySaveAmount('₹35'),
                    'Cheaper seasonal swap with fiber benefit',
                  ),
                  _buildSubstitutionCard(
                    theme,
                    l10n.grocerySubstitutionPrompt(
                      'Packaged low-fat curd cups',
                      'Homemade curd batch',
                    ),
                    l10n.grocerySaveAmount('₹70'),
                    'Lower sodium and better weekly value',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubstitutionCard(
    ThemeData theme,
    String substitution,
    String savings,
    String impact,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: 'swap_horiz',
                color: theme.colorScheme.secondary,
                size: 24,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(substitution, style: theme.textTheme.titleMedium),
                  SizedBox(height: 0.5.h),
                  Text(impact, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            Text(
              savings,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Share grocery list
  void _shareGroceryList() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.groceryShareTitle, style: theme.textTheme.titleLarge),
              SizedBox(height: 2.h),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'message',
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
                title: const Text('WhatsApp'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.grocerySnackOpeningWhatsApp),
                    ),
                  );
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'sms',
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
                title: const Text('SMS'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.grocerySnackOpeningSms),
                    ),
                  );
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'content_copy',
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
                title: const Text('Copy to Clipboard'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.grocerySnackCopiedList),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Localized categories helper
    final localizedCategories = ingredientCategories.map((category) {
      String catName = category["category"];
      
      if (catName == "Vegetables") catName = l10n.groceryCategoryVegetables;
      if (catName == "Grains") catName = l10n.groceryCategoryGrains;
      if (catName == "Spices") catName = l10n.groceryCategorySpices;
      if (catName == "Dairy") catName = l10n.groceryCategoryDairy;
      
      final items = (category["items"] as List).map((item) {
        String itemName = item["name"];
        if (itemName == "Onions") itemName = l10n.mockGroceryOnions;
        if (itemName == "Tomatoes") itemName = l10n.mockGroceryTomatoes;
        if (itemName == "Basmati Rice") itemName = l10n.mockGroceryBasmatiRice;
        if (itemName == "Whole Wheat Flour") itemName = l10n.mockGroceryWholeWheatFlour;
        if (itemName == "Moong Dal") itemName = l10n.groceryItemMoongDal;
        if (itemName == "Turmeric Powder") itemName = l10n.mockGroceryTurmericPowder;
        if (itemName == "Cumin Seeds") itemName = l10n.mockGroceryCuminSeeds;
        if (itemName == "Garam Masala") itemName = l10n.mockGroceryGaramMasala;
        if (itemName == "Milk") itemName = l10n.mockGroceryMilk;
        if (itemName == "Yogurt") itemName = l10n.mockGroceryYogurt;
        if (itemName == "Paneer") itemName = l10n.mockGroceryPaneer;
        
        return {...item, "name": itemName};
      }).toList();
      
      return {...category, "category": catName, "items": items};
    }).toList();
    final cartTotal = _calculateCartTotal();

    // Filter categories based on search
    final filteredCategories = _searchController.text.isEmpty
        ? localizedCategories
        : localizedCategories
              .map((category) {
                final filteredItems = (category["items"] as List)
                    .where(
                      (item) => (item["name"] as String).toLowerCase().contains(
                        _searchController.text.toLowerCase(),
                      ),
                    )
                    .toList();
                return {...category, "items": filteredItems};
              })
              .where((category) => (category["items"] as List).isNotEmpty)
              .toList();

    final hasItems = filteredCategories.isNotEmpty;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Enhanced Header
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withValues(alpha: 0.05),
                    blurRadius: 8.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: CustomIconWidget(
                          iconName: 'arrow_back',
                          color: theme.colorScheme.onSurface,
                          size: 24,
                        ),
                        onPressed: () =>
                            Navigator.of(context, rootNavigator: true).pop(),
                      ),
                      Expanded(
                        child: Text(
                          l10n.groceryTitle,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onSurface,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      if (_isSyncing)
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.primary,
                            ),
                          ),
                        )
                      else if (_isOfflineMode)
                        Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.errorContainer,
                            shape: BoxShape.circle,
                          ),
                          child: CustomIconWidget(
                            iconName: 'cloud_off',
                            color: theme.colorScheme.error,
                            size: 20,
                          ),
                        )
                      else
                        IconButton(
                          icon: CustomIconWidget(
                            iconName: 'share',
                            color: theme.colorScheme.primary,
                            size: 24,
                          ),
                          onPressed: _shareGroceryList,
                        ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  // Enhanced Search Bar
                  TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: l10n.grocerySearchHint,
                      prefixIcon: Icon(
                        Icons.search,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: theme.colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.5.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: !hasItems
                  ? EmptyStateWidget(
                      title: l10n.groceryEmptyTitle,
                      message: _searchController.text.isEmpty
                          ? l10n.groceryEmptyMessageDefault
                          : l10n.groceryEmptyMessageFiltered,
                      iconName: 'shopping_cart',
                      actionLabel: _searchController.text.isEmpty
                          ? l10n.groceryEmptyPrimary
                          : l10n.groceryEmptyClearSearch,
                      onAction: () {
                        if (_searchController.text.isEmpty) {
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pushNamed('/daily-meal-planning');
                        } else {
                          _searchController.clear();
                          setState(() {});
                        }
                      },
                    )
                  : RefreshIndicator(
                      onRefresh: _syncGroceryList,
                      color: theme.colorScheme.primary,
                      child: ListView(
                        padding: EdgeInsets.all(4.w),
                        children: [
                          // Budget Summary Card
                          BudgetSummaryCardWidget(
                            budgetData: budgetData,
                            onViewDetails: _showBudgetSubstitutions,
                          ),
                          SizedBox(height: 2.h),

                          // Delivery Integration
                          _buildDeliveryIntegrationSection(theme, cartTotal),
                          SizedBox(height: 2.h),

                          // Progress Indicator
                          _buildProgressIndicator(theme),
                          SizedBox(height: 2.h),

                          // Category List
                          ...filteredCategories.map((category) {
                            final categoryIndex = localizedCategories.indexOf(
                              category,
                            );
                            return Padding(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: IngredientCategoryWidget(
                                category: category,
                                onTogglePurchased: (itemIndex) =>
                                    _togglePurchased(categoryIndex, itemIndex),
                                onAddToPantry: (itemIndex) =>
                                    _addToPantry(categoryIndex, itemIndex),
                                onRemoveFromList: (itemIndex) =>
                                    _removeFromList(categoryIndex, itemIndex),
                              ),
                            );
                          }),

                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),

      // Enhanced FAB
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddIngredientDialog,
        backgroundColor: theme.colorScheme.primary,
        icon: CustomIconWidget(
          iconName: 'add',
          color: theme.colorScheme.onPrimary,
          size: 24,
        ),
        label: Text(
          l10n.groceryFabAddItem,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(ThemeData theme) {
    final totalItems = ingredientCategories.fold<int>(
      0,
      (sum, category) => sum + (category["items"] as List).length,
    );
    final purchasedItems = ingredientCategories.fold<int>(
      0,
      (sum, category) =>
          sum +
          (category["items"] as List)
              .where((item) => item["isPurchased"] == true)
              .length,
    );
    final progress = totalItems > 0 ? purchasedItems / totalItems : 0.0;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.1),
            theme.colorScheme.secondary.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.groceryShoppingProgressTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  AppLocalizations.of(context)!.groceryShoppingProgressLabel(
                    purchasedItems,
                    totalItems,
                  ),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryIntegrationSection(
    ThemeData theme,
    double cartTotal,
  ) {
    final currency = budgetData["currency"] as String? ?? '₹';

    final isBigBasketAvailable = cartTotal >= 500;
    final isBlinkitAvailable = cartTotal >= 199;

    TextStyle availabilityStyle(bool available) {
      return theme.textTheme.bodySmall!.copyWith(
        color: available
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurfaceVariant,
        fontWeight: available ? FontWeight.w600 : FontWeight.w400,
      );
    }

    Widget buildOptionCard({
      required String id,
      required String title,
      required String subtitle,
      required String feeLabel,
      required String etaLabel,
      required bool enabled,
      required String availabilityText,
      required bool isAvailableForCart,
    }) {
      final isSelected = _selectedDeliveryOption == id;

      Color borderColor;
      if (!enabled) {
        borderColor = theme.colorScheme.outline.withValues(alpha: 0.3);
      } else if (isSelected) {
        borderColor = theme.colorScheme.primary;
      } else {
        borderColor = theme.colorScheme.outline.withValues(alpha: 0.2);
      }
 
      return GestureDetector(
        onTap: enabled && isAvailableForCart
            ? () {
                setState(() {
                  _selectedDeliveryOption = id;
                });
              }
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.all(3.w),
          margin: EdgeInsets.only(bottom: 1.5.h),
          decoration: BoxDecoration(
            color: !enabled
                ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4)
                : isSelected
                    ? theme.colorScheme.primaryContainer.withValues(alpha: 0.4)
                    : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: borderColor,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Stack(
            children: [
              // Main content column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.5.w),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          id == 'bigbasket'
                              ? Icons.shopping_bag
                              : id == 'blinkit'
                                  ? Icons.flash_on
                                  : Icons.storefront,
                          color: theme.colorScheme.secondary,
                          size: 22,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 0.4.h),
                            Text(
                              subtitle,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 6.w), // space reserved under the chip
                    ],
                  ),
                  SizedBox(height: 1.2.h),
                  Row(
                    children: [
                      Icon(
                        Icons.delivery_dining,
                        size: 16,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 1.w),
                      Expanded(
                        child: Text(
                          feeLabel,
                          style: theme.textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 1.w),
                      Expanded(
                        child: Text(
                          etaLabel,
                          style: theme.textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.8.h),
                  Text(
                    availabilityText,
                    style: enabled
                        ? availabilityStyle(isAvailableForCart)
                        : theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                  ),
                ],
              ),
              if (enabled)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.4.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: isAvailableForCart
                          ? (isSelected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.primaryContainer)
                          : theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isSelected
                          ? AppLocalizations.of(context)!.deliveryChipSelected
                          : AppLocalizations.of(context)!.deliveryChipSelect,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isAvailableForCart
                            ? (isSelected
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.primary)
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    String selectedLabel() {
      switch (_selectedDeliveryOption) {
        case 'bigbasket':
          return AppLocalizations.of(context)!.deliveryBigBasketTitle;
        case 'blinkit':
          return AppLocalizations.of(context)!.deliveryBlinkitTitle;
        case 'dmart':
          return AppLocalizations.of(context)!.deliveryDMartTitle;
        default:
          return '-';
      }
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.deliverySectionTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  '$currency${cartTotal.toStringAsFixed(0)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.5.h),
            Text(
              AppLocalizations.of(context)!.deliverySectionSubtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 2.h),
            buildOptionCard(
              id: 'bigbasket',
              title: AppLocalizations.of(context)!.deliveryBigBasketTitle,
              subtitle:
                  AppLocalizations.of(context)!.deliveryBigBasketSubtitle,
              feeLabel: AppLocalizations.of(context)!.deliveryBigBasketFee,
              etaLabel: AppLocalizations.of(context)!.deliveryBigBasketEta,
              enabled: true,
              availabilityText: isBigBasketAvailable
                  ? AppLocalizations.of(context)!.deliveryAvailableForCart
                  : AppLocalizations.of(context)!.deliveryMinOrderNotMet,
              isAvailableForCart: isBigBasketAvailable,
            ),
            buildOptionCard(
              id: 'blinkit',
              title: AppLocalizations.of(context)!.deliveryBlinkitTitle,
              subtitle: AppLocalizations.of(context)!.deliveryBlinkitSubtitle,
              feeLabel: AppLocalizations.of(context)!.deliveryBlinkitFee,
              etaLabel: AppLocalizations.of(context)!.deliveryBlinkitEta,
              enabled: true,
              availabilityText: isBlinkitAvailable
                  ? AppLocalizations.of(context)!.deliveryAvailableForCart
                  : AppLocalizations.of(context)!.deliveryMinOrderNotMet,
              isAvailableForCart: isBlinkitAvailable,
            ),
            buildOptionCard(
              id: 'dmart',
              title: AppLocalizations.of(context)!.deliveryDMartTitle,
              subtitle: AppLocalizations.of(context)!.deliveryDMartSubtitle,
              feeLabel: AppLocalizations.of(context)!.deliveryDMartFee,
              etaLabel: AppLocalizations.of(context)!.deliveryDMartEta,
              enabled: false,
              availabilityText:
                  AppLocalizations.of(context)!.deliveryUnavailable,
              isAvailableForCart: false,
            ),
            SizedBox(height: 1.5.h),
            Text(
              AppLocalizations.of(context)!.deliverySelectedLabel(
                selectedLabel(),
              ),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../services/pantry_mock_service.dart';
import '../../widgets/empty_state_widget.dart';
import '../../widgets/loading_state_widget.dart';
import './widgets/add_pantry_item_dialog_widget.dart';
import './widgets/meal_suggestion_widget.dart';
import './widgets/pantry_category_widget.dart';
import '../../l10n/app_localizations.dart';

/// Pantry Management screen tracks available ingredients at home
/// with quantity tracking, expiry monitoring, and meal suggestions.
///
/// Features:
/// - Categorized ingredient inventory (Vegetables, Grains, Spices, Dairy, Proteins)
/// - Visual quantity indicators with progress bars
/// - Expiry date monitoring with color-coded alerts
/// - Swipe actions for adding to grocery list and marking as used
/// - Smart meal suggestions based on available stock
/// - Search functionality for quick ingredient lookup
/// - Floating action button for manual ingredient addition
/// - Auto-sync with grocery list integration
class PantryManagement extends StatefulWidget {
  const PantryManagement({Key? key}) : super(key: key);

  @override
  State<PantryManagement> createState() => _PantryManagementState();
}

class _PantryManagementState extends State<PantryManagement>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  bool _isLoading = true;
  String _searchQuery = '';
  Map<String, dynamic> _pantryData = {};
  List<Map<String, dynamic>> _mealSuggestions = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadPantryData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadPantryData() async {
    setState(() => _isLoading = true);
    try {
      final data = await PantryMockService.getPantryInventory();
      final suggestions = await PantryMockService.getMealSuggestions();
      setState(() {
        _pantryData = data;
        _mealSuggestions = suggestions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _handleAddToGroceryList(String itemId, String itemName) async {
    final success = await PantryMockService.addToGroceryList(itemId, 1.0);
    if (success && mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.pantrySnackAddedToList(itemName)),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _handleMarkAsUsed(String itemId, String itemName, double portion) async {
    final success = await PantryMockService.markAsUsed(itemId, portion);
    if (success && mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.pantrySnackMarkedUsed(itemName)),
          backgroundColor: Theme.of(context).colorScheme.primary,
          duration: const Duration(seconds: 2),
        ),
      );
      _loadPantryData();
    }
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) => AddPantryItemDialogWidget(
        onAdd: (itemData) async {
          final success = await PantryMockService.addNewItem(itemData);
          if (success && mounted) {
            final l10n = AppLocalizations.of(context)!;
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  l10n.pantrySnackAddedToPantry(itemData['name'] ?? ''),
                ),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
            );
            _loadPantryData();
          }
        },
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCategories() {
    if (_searchQuery.isEmpty) {
      return List<Map<String, dynamic>>.from(_pantryData['categories'] ?? []);
    }

    final categories = List<Map<String, dynamic>>.from(
      _pantryData['categories'] ?? [],
    );

    return categories
        .map((category) {
          final filteredItems = (category['items'] as List).where((item) {
            return item['name'].toString().toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );
          }).toList();

          return {...category, 'items': filteredItems};
        })
        .where((category) => (category['items'] as List).isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
        title: Text(
          l10n.pantryTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: CustomIconWidget(
              iconName: 'refresh',
              color: theme.colorScheme.onPrimary,
              size: 24,
            ),
            onPressed: _loadPantryData,
            tooltip: l10n.pantryRefreshTooltip,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(14.h),
          child: Container(
            color: theme.colorScheme.primary,
            padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 2.h),
            child: Column(
              children: [
                // Search bar
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() => _searchQuery = value);
                    },
                    decoration: InputDecoration(
                      hintText: l10n.pantrySearchHint,
                      prefixIcon: CustomIconWidget(
                        iconName: 'search',
                        color: theme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: CustomIconWidget(
                                iconName: 'close',
                                color: theme.colorScheme.onSurfaceVariant,
                                size: 20,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.5.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                // Tab bar
                TabBar(
                  controller: _tabController,
                  indicatorColor: theme.colorScheme.onPrimary,
                  labelColor: theme.colorScheme.onPrimary,
                  unselectedLabelColor: theme.colorScheme.onPrimary.withValues(
                    alpha: 0.6,
                  ),
                  tabs: [
                    Tab(text: l10n.pantryTabInventory),
                    Tab(text: l10n.pantryTabSuggestions),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const LoadingStateWidget()
          : TabBarView(
              controller: _tabController,
              children: [
                _buildInventoryTab(theme),
                _buildMealSuggestionsTab(theme),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddItemDialog,
        backgroundColor: theme.colorScheme.secondary,
        icon: CustomIconWidget(
          iconName: 'add',
          color: theme.colorScheme.onSecondary,
          size: 24,
        ),
        label: Text(
          l10n.pantryFabAddItem,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildInventoryTab(ThemeData theme) {
    final summary = _pantryData['summary'] as Map<String, dynamic>? ?? {};
    final filteredCategories = _getFilteredCategories();
    final l10n = AppLocalizations.of(context)!;

    if (filteredCategories.isEmpty) {
      return EmptyStateWidget(
        iconName: 'inventory_2',
        title:
            _searchQuery.isEmpty
                ? l10n.pantryEmptyNoItems
                : l10n.pantryEmptyNoResults,
        message:
            _searchQuery.isEmpty
                ? l10n.pantryEmptyMessageNoItems
                : l10n.pantryEmptyMessageNoResults,
      );
    }

    return RefreshIndicator(
      onRefresh: _loadPantryData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // Summary cards
            Container(
              padding: EdgeInsets.all(4.w),
              color: theme.colorScheme.surface,
              child: Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      theme,
                      l10n.pantrySummaryTotal,
                      '${summary['totalItems'] ?? 0}',
                      Icons.inventory_2,
                      theme.colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: _buildSummaryCard(
                      theme,
                      l10n.pantrySummaryFresh,
                      '${summary['freshItems'] ?? 0}',
                      Icons.check_circle,
                      AppTheme.successLight,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: _buildSummaryCard(
                      theme,
                      l10n.pantrySummaryExpiring,
                      '${summary['expiringSoon'] ?? 0}',
                      Icons.warning,
                      AppTheme.warningLight,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: _buildSummaryCard(
                      theme,
                      l10n.pantrySummaryExpired,
                      '${summary['expired'] ?? 0}',
                      Icons.error,
                      theme.colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
            // Categories
            ...filteredCategories.map((category) {
              return PantryCategoryWidget(
                category: category,
                onAddToGroceryList: _handleAddToGroceryList,
                onMarkAsUsed: _handleMarkAsUsed,
              );
            }),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    ThemeData theme,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: 0.5.h),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          SizedBox(height: 0.3.h),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMealSuggestionsTab(ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    if (_mealSuggestions.isEmpty) {
      return EmptyStateWidget(
        iconName: 'restaurant',
        title: l10n.pantryEmptyNoSuggestions,
        message: l10n.pantryEmptyMessageNoSuggestions,
      );
    }

    return RefreshIndicator(
      onRefresh: _loadPantryData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.pantrySuggestionsTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              l10n.pantrySuggestionsSubtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 2.h),
            ..._mealSuggestions.map((meal) {
              return MealSuggestionWidget(meal: meal);
            }),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
/// Menu category enum for merchant menus
enum MenuCategory {
  appetizer,
  mainCourse,
  dessert,
  beverage,
  snack,
  breakfast,
  lunch,
  dinner,
  salad,
  soup,
  seafood,
  vegetarian,
  vegan,
  pasta,
  pizza,
  burger,
  sandwich,
  rice,
  noodle,
  grill;

  /// Converts the enum name to a display-friendly format
  /// e.g., mainCourse -> Main Course
  String get displayName {
    final result = name.replaceAllMapped(
      RegExp("([A-Z])"),
      (match) => " ${match.group(0)}",
    );
    return result.trim().substring(0, 1).toUpperCase() +
        result.trim().substring(1);
  }

  /// Try to find a MenuCategory from a string value
  /// Returns null if no match is found
  static MenuCategory? fromString(String? value) {
    if (value == null) return null;
    final valueLower = value.toLowerCase();
    try {
      return MenuCategory.values.firstWhere(
        (e) => e.name.toLowerCase() == valueLower,
      );
    } catch (_) {
      return null;
    }
  }
}

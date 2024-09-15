class CategoryModel {
  String? id;
  String? categoryName;
  String? restaurantId; // Add restaurantId

  CategoryModel(
      {required this.id,
      required this.categoryName,
      required this.restaurantId});

  factory CategoryModel.fromJson(Map<String, dynamic> jsonData) {
    return CategoryModel(
        id: jsonData['id'] ?? '',
        categoryName: jsonData['category_name'] ?? '',
        restaurantId: jsonData['restaurant_id'] ?? ''); // Parse restaurantId
  }
}

class ProductModel {
  String? id;
  String? productName;
  String? productImage;
  String? price;
  String? categoryId;
  String? restaurantId;

  ProductModel({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.categoryId,
    required this.restaurantId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductModel(
      id: jsonData['id'] ?? '',
      productName: jsonData['product_name'] ?? '',
      productImage: jsonData['logo'] ?? '',
      price: jsonData['price'] ?? '',
      categoryId: jsonData['category_id'] ?? '',
      restaurantId: jsonData['restaurant_id'] ?? '',
    );
  }
}

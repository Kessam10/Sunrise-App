class CustomOptionModel {
  String? custom_option_name;
  String? product_id;
  String? price;
  String? id;
  int quantity;

  CustomOptionModel({
    required this.price,
    required this.custom_option_name,
    required this.product_id,
    this.quantity = 1,
    required this.id,
  });

  factory CustomOptionModel.fromJson(Map<String, dynamic> fromJsom) {
    return CustomOptionModel(
        id: fromJsom['id'] ?? '',
        price: fromJsom['price'] ?? '',
        custom_option_name: fromJsom['custom_option_name'] ?? '',
        product_id: fromJsom['product_id'] ?? '');
  }
}

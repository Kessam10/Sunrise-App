class CartItem {
  String id;
  final String productName;
  final String productImage;
  final String price;
  int quantity;
  String? customProduct;

  CartItem({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.price,
    this.quantity = 1,
    this.customProduct,
  });
}

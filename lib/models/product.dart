class Product {
  final int id;
  final String title;
  final String brand;
  final double price;
  final double discountPercentage;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    required this.discountPercentage,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      brand: json['brand'] ?? "Unknown",
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      image: json['thumbnail'] ?? 'https://via.placeholder.com/150',
    );
  }

  // ✅ Getter for image URL
  String get imageUrl => image;

  // ✅ Getter for final price after discount
  double get finalPrice => price * (1 - discountPercentage / 100);

  // ✅ Getter for original price (before discount)
  double get originalPrice => price;

  // ✅ Getter for discount (rounded to nearest int)
  int get discount => discountPercentage.round();

  // ✅ Added `name` getter (alias for title)
  String get name => title;

  // ✅ Added `oldPrice` getter (same as `originalPrice`)
  double get oldPrice => originalPrice;
}

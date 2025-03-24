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

  String get imageUrl => image;

  double get finalPrice => price * (1 - discountPercentage / 100);

  double get originalPrice => price;

  int get discount => discountPercentage.round();

  String get name => title;

  double get oldPrice => originalPrice;
}

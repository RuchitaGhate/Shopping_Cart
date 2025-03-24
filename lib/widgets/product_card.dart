import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                product.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  product.brand,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      "₹${product.price.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "₹${product.oldPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  "${product.discount}% OFF",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                ref
                    .read(cartProvider.notifier)
                    .addItem(product); // ✅ Add product to cart
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${product.name} added to cart!")),
                );
              },
              child: Text("Add", style: TextStyle(color: Colors.black)),
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}

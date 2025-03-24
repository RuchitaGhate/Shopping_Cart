import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';

class CartItemCard extends ConsumerWidget {
  final Product product;
  final int quantity;

  const CartItemCard({required this.product, required this.quantity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.watch(cartProvider.notifier);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.brand,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "₹${product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "₹${product.originalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "${product.discount}% OFF",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.add, color: Colors.pink),
                  onPressed: () => cartNotifier.addItem(product),
                ),
                Text(
                  quantity.toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.remove, color: Colors.pink),
                  onPressed: () => cartNotifier.removeItem(product),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

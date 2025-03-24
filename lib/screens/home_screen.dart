import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import 'package:shopping_cart/widgets/product_card.dart';
import 'cart_screen.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider);
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: Text(
          "Catalogue",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 5,
                  top: 5,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      cart.length.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: productState.when(
        data:
            (products) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                padding: EdgeInsets.only(top: 8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75, // Adjusted to match UI
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: products.length,
                itemBuilder:
                    (context, index) => ProductCard(product: products[index]),
              ),
            ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Failed to load products")),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final totalPrice = ref.watch(cartProvider.notifier).totalPrice;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:
          cart.isEmpty
              ? Center(child: Text("Your cart is empty!"))
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final entry = cart.entries.elementAt(index);
                        return CartItemCard(
                          product: entry.key,
                          quantity: entry.value,
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Amount Price",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "₹${totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 40,
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Check Out",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 5),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 12,
                                child: Text(
                                  cart.length.toString(),
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}

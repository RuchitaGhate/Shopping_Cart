import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

class CartNotifier extends StateNotifier<Map<Product, int>> {
  CartNotifier() : super({}); // Initialize an empty cart

  // ✅ Add item to cart (Ensures UI rebuild)
  void addItem(Product product) {
    final newState = Map<Product, int>.from(state);
    newState[product] = (newState[product] ?? 0) + 1;
    state = {}; // 🔹 Force UI rebuild
    state = newState; // 🔹 Assign updated cart
  }

  // ✅ Remove item from cart
  void removeItem(Product product) {
    final newState = Map<Product, int>.from(state);
    if (newState.containsKey(product) && newState[product]! > 1) {
      newState[product] = newState[product]! - 1;
    } else {
      newState.remove(product);
    }
    state = {}; // 🔹 Force UI rebuild
    state = newState;
  }

  // ✅ Getter for total price
  double get totalPrice {
    double total = 0.0;
    state.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }
}

// ✅ Provide cart state globally (No changes)
final cartProvider = StateNotifierProvider<CartNotifier, Map<Product, int>>((
  ref,
) {
  return CartNotifier();
});

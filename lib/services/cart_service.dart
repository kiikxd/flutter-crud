import 'package:flutter_project/models/cart_model.dart';
import '../models/product_model.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;

  CartService._internal();

  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Product product) {
    final cartItem = _cartItems.firstWhere(
          (item) => item.product.id == product.id,
      orElse: () => CartItem(id: _cartItems.length + 1, product: product, quantity: 0),
    );

    if (cartItem.quantity == 0) {
      _cartItems.add(cartItem);
    }

    cartItem.quantity++;
  }

  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
  }

  void updateQuantity(CartItem cartItem, int quantity) {
    if (quantity <= 0) {
      removeFromCart(cartItem);
    } else {
      cartItem.quantity = quantity;
    }
  }
}

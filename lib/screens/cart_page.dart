import 'package:flutter/material.dart';
import 'package:flutter_project/services/cart_service.dart';
import 'product_list_page.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartService cartService = CartService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: ListView.builder(
        itemCount: cartService.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartService.cartItems[index];
          return ListTile(
            leading: Image.network(
              cartItem.product.thumbnail,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(cartItem.product.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quantity: ${cartItem.quantity}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      cartService.updateQuantity(cartItem, cartItem.quantity - 1);
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      cartService.updateQuantity(cartItem, cartItem.quantity + 1);
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke ProductListPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductListPage()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Products',
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_project/models/product_model.dart';
import 'package:flutter_project/services/product_service.dart';
import 'package:flutter_project/services/cart_service.dart';
import 'cart_page.dart';

class ProductListPage extends StatelessWidget {
  final CartService cartService = CartService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: FutureBuilder<List<Product>>(
        future: ProductService.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final products = snapshot.data ?? [];
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.network(product.thumbnail), // Menampilkan gambar produk
                    title: Text(product.title),
                    subtitle: Text('\$${product.price}'),
                    trailing: IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          cartService.addToCart(product); // Menambahkan produk ke cart
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(), // Navigasi ke CartPage
                            ),
                          );
                        }
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                loadedProduct.title,
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              background: Hero(
                tag: productId,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  width: 15,
                  height: 15,
                ),
                Text('\$${loadedProduct.price}',
                    style: TextStyle(fontSize: 25, color: Colors.grey),
                    textAlign: TextAlign.center),
                SizedBox(
                  width: 15,
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    '${loadedProduct.description}',
                    style: TextStyle(fontSize: 25, color: Colors.black87),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 1000,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

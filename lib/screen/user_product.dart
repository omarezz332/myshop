import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/products.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/user_prioduct_item.dart';

import 'edit_product.dart';

class UserProduct extends StatelessWidget {
  static const routeName = '/USERproduct';

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    //final productData = Provider.of<Products>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () =>
                  Navigator.pushNamed(context, EditProductScreen.routeName)),
        ],
      ),
      body: FutureBuilder(
        future: _refreshProduct(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () => _refreshProduct(context),
                    child: Consumer<Products>(
                      builder: (ctx,productData,_)=>Padding(
                          padding: EdgeInsets.all(10),
                          child: ListView.builder(
                            itemBuilder: (_, i) => Column(children: [
                              UserProductItem(
                                  productData.items[i].id,
                                  productData.items[i].title,
                                  productData.items[i].imageUrl),
                              Divider(),
                            ]),
                            itemCount: productData.items.length,
                          )),
                    ),
                  ),
      ),
    );
  }
}

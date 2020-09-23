import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/auth.dart';
import 'package:shop/provider/cart.dart';
import 'package:shop/provider/orders.dart';
import 'package:shop/provider/products.dart';
import 'package:shop/screen/auth_screen.dart';
import 'package:shop/screen/cart_screen.dart';
import 'package:shop/screen/edit_product.dart';
import 'package:shop/screen/orders_screen.dart';
import 'package:shop/screen/product_Details_screen.dart';
import 'package:shop/screen/product_overview_screen.dart';
import 'package:shop/screen/splash_screen.dart';
import 'package:shop/screen/user_product.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previous) => Products(auth.userId, auth.token,
                previous == null ? [] : previous.items),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previous) => Orders(auth.userId, auth.token,
                previous == null ? [] : previous.orders),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
            ),
            home: auth.isAuth
                ? ProductOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapShot) =>
                        authResultSnapShot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              AuthScreen.routeName: (ctx) => AuthScreen(),
              ProductOverviewScreen.routeName: (ctx) => ProductOverviewScreen(),
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProduct.routeName: (ctx) => UserProduct(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData.dark(),
          ),
        ));
  }
}

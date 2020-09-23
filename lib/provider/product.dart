import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/http_exeption.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavorite = false,
  });

  void toggleFavoriteStates(String authToken,String userId) async {
    final oldStatus = isFavorite;
    final url = 'https://shop-59f4b.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken';
    try {
      isFavorite = !isFavorite;
      notifyListeners();
      final response = await http.put(url,
          body: json.encode(
       isFavorite,
          ));
      if (response.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
      throw HttpExeption('Check Your Connection!');
    }
  }
}

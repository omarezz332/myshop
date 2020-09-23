import 'package:flutter/material.dart';

class HttpExeption implements Exception{
  final message;
  HttpExeption(this.message);
  @override
  String toString() {
    return message;
  }
}
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // =========================
  // BASE URL
  // =========================

  static String get baseUrl {
    // Flutter Web Chrome

    if (kIsWeb) {
      return "http://localhost:8080";
    }

    // Android Emulator

    return "http://10.0.2.2:8080";
  }

  // =========================
  // LOGIN
  // POST /login
  // =========================

  static Future<Map<String, dynamic>> login(
    String email,

    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"email": email, "password": password}),
    );

    return jsonDecode(response.body);
  }

  // =========================
  // GET ALL ORDERS
  // GET /items
  // =========================

  static Future<List<dynamic>> getOrders() async {
    final response = await http.get(Uri.parse("$baseUrl/items"));

    final data = jsonDecode(response.body);

    return data["data"] ?? [];
  }

  // =========================
  // GET DETAIL ORDER
  // GET /items/:id
  // =========================

  static Future<Map<String, dynamic>> getOrderById(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/items/$id"));

    return jsonDecode(response.body);
  }

  // =========================
  // CREATE ORDER
  // POST /items
  // =========================

  static Future<Map<String, dynamic>> createOrder(
    Map<String, dynamic> data,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/items"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode(data),
    );

    return jsonDecode(response.body);
  }

  // =========================
  // UPDATE ORDER
  // PUT /items/:id
  // =========================

  static Future<Map<String, dynamic>> updateOrder(
    int id,

    Map<String, dynamic> data,
  ) async {
    final response = await http.put(
      Uri.parse("$baseUrl/items/$id"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode(data),
    );

    return jsonDecode(response.body);
  }

  // =========================
  // DELETE ORDER
  // DELETE /items/:id
  // =========================

  static Future<bool> deleteOrder(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/items/$id"));

    return response.statusCode == 200;
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Untuk Flutter Web (Chrome Desktop) atau development lokal
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  // Untuk Android emulator: 'http://10.0.2.2:8000/api'
  // Untuk device fisik: 'http://192.168.x.x:8000/api'

  // ─── TOKEN MANAGEMENT ─────────────────────────────────────────
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // ─── HEADERS ──────────────────────────────────────────────────
  static Future<Map<String, String>> getHeaders({bool withAuth = false}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (withAuth) {
      final token = await getToken();
      if (token != null) headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // ─── AUTH ─────────────────────────────────────────────────────
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: await getHeaders(),
      body: jsonEncode({'email': email, 'password': password}),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: await getHeaders(),
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    return jsonDecode(response.body);
  }

  static Future<void> logout() async {
    await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: await getHeaders(withAuth: true),
    );
    await removeToken();
  }

  // ─── PRODUCTS ─────────────────────────────────────────────────
  static Future<List<dynamic>> getProducts({String? search}) async {
    String url = '$baseUrl/products';
    if (search != null) url += '?search=$search';
    final response = await http.get(
      Uri.parse(url),
      headers: await getHeaders(),
    );
    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> getTopRated() async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/top-rated'),
      headers: await getHeaders(),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getProductDetail(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/$id'),
      headers: await getHeaders(),
    );
    return jsonDecode(response.body);
  }

  // ─── CATEGORIES ───────────────────────────────────────────────
  static Future<List<dynamic>> getCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories'),
      headers: await getHeaders(),
    );
    return jsonDecode(response.body);
  }

  // ─── ORDERS ───────────────────────────────────────────────────
  static Future<List<dynamic>> getMyOrders() async {
    final response = await http.get(
      Uri.parse('$baseUrl/orders'),
      headers: await getHeaders(withAuth: true),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> createOrder(
    List<Map<String, dynamic>> items,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: await getHeaders(withAuth: true),
      body: jsonEncode({'items': items}),
    );
    return jsonDecode(response.body);
  }
}

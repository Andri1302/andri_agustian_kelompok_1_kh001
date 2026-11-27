import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/admin.dart';

class AdminService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/users';

  // Mengambil seluruh data Admin
  Future<List<Admin>> getAdmins() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Admin.fromJson(item)).toList();
    } else {
      throw Exception('Gagal mengambil daftar Admin');
    }
  }

  // Mengambil satu data Admin berdasarkan ID
  Future<Admin> getAdmin(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Admin.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal mengambil detail Admin ID $id');
    }
  }

  // Menghapus data Admin berdasarkan ID
  Future<bool> deleteAdmin(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal menghapus Admin ID $id');
    }
  }
}
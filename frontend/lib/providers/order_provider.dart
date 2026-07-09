import 'package:flutter/material.dart';
import '../services/api_service.dart';

class OrderProvider extends ChangeNotifier {
  // =========================
  // DATA ORDER
  // =========================

  List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get allOrders => _orders;

  // =========================
  // LOADING
  // =========================

  bool _loading = false;

  bool get loading => _loading;

  // =========================
  // FILTER
  // =========================

  String searchQuery = "";

  String selectedStatus = "Semua";

  DateTime? startDate;

  DateTime? endDate;

  // =========================
  // PAGINATION
  // =========================

  int currentPage = 1;

  final int perPage = 5;

  // =================================================
  // GET ALL ORDER
  // GET /items
  // =================================================

  Future<void> fetchOrders() async {
    _loading = true;

    notifyListeners();

    try {
      final data = await ApiService.getOrders();

      _orders = data.map<Map<String, dynamic>>((item) {
        return {
          "id": item["ID"] ?? 0,

          "code": item["Code"] ?? "",

          "customer": item["Customer"] ?? "",

          "service": item["Service"] ?? "",

          "status": item["Status"] ?? "",

          "payment": item["Payment"] ?? "",

          "price": item["Price"] ?? 0,

          "date": item["CreatedAt"] ?? "",

          "estimate": item["Estimate"] ?? "",

          "serviceCount": item["ServiceCount"] ?? "1 Layanan",
        };
      }).toList();
    } catch (e) {
      debugPrint("Gagal mengambil order : $e");

      _orders = [];
    }

    _loading = false;

    notifyListeners();
  }

  // =================================================
  // DETAIL ORDER
  // GET /items/:id
  // =================================================

  Future<Map<String, dynamic>> getOrderDetail(int id) async {
    final response = await ApiService.getOrderById(id);

    final item = response["data"] ?? response;

    return {
      "id": item["ID"] ?? 0,

      "code": item["Code"] ?? "",

      "customer": item["Customer"] ?? "",

      "service": item["Service"] ?? "",

      "status": item["Status"] ?? "",

      "payment": item["Payment"] ?? "",

      "price": item["Price"] ?? 0,

      "date": item["CreatedAt"] ?? "",

      "estimate": item["Estimate"] ?? "",

      "serviceCount": item["ServiceCount"] ?? "1 Layanan",
    };
  }

  // =================================================
  // CREATE
  // POST /items
  // =================================================

  Future<bool> createOrder(Map<String, dynamic> data) async {
    try {
      final response = await ApiService.createOrder(data);

      if (response.isNotEmpty) {
        await fetchOrders();

        return true;
      }
    } catch (e) {
      debugPrint("Tambah order gagal : $e");
    }

    return false;
  }

  Future<bool> addOrder(
    String customer,

    String service,

    int price,

    String status,

    String payment,

    String estimate,

    String serviceCount,
  ) async {
    return createOrder({
      "Customer": customer,

      "Service": service,

      "Price": price,

      "Status": status,

      "Payment": payment,

      "Estimate": estimate,

      "ServiceCount": serviceCount,
    });
  }

  // =================================================
  // UPDATE
  // PUT /items/:id
  // =================================================

  Future<bool> updateOrder(int id, Map<String, dynamic> data) async {
    try {
      final response = await ApiService.updateOrder(id, data);

      if (response.isNotEmpty) {
        await fetchOrders();

        return true;
      }
    } catch (e) {
      debugPrint("Update gagal : $e");
    }

    return false;
  }

  // =================================================
  // DELETE
  // DELETE /items/:id
  // =================================================

  Future<bool> deleteOrder(int id) async {
    try {
      final success = await ApiService.deleteOrder(id);

      if (success) {
        _orders.removeWhere((item) => item["id"] == id);

        notifyListeners();

        return true;
      }
    } catch (e) {
      debugPrint("Delete gagal : $e");
    }

    return false;
  }

  // =================================================
  // FILTER
  // =================================================

  List<Map<String, dynamic>> get filteredOrders {
    return _orders.where((order) {
      final keyword = searchQuery.toLowerCase();

      final customer = order["customer"].toString().toLowerCase();

      final code = order["code"].toString().toLowerCase();

      final matchSearch =
          keyword.isEmpty ||
          customer.contains(keyword) ||
          code.contains(keyword);

      final matchStatus =
          selectedStatus == "Semua" || order["status"] == selectedStatus;

      final matchDate = startDate == null || checkDate(order["date"]);

      return matchSearch && matchStatus && matchDate;
    }).toList();
  }

  bool checkDate(String value) {
    try {
      final date = DateTime.parse(value);

      return date.year == startDate!.year &&
          date.month == startDate!.month &&
          date.day == startDate!.day;
    } catch (e) {
      return false;
    }
  }

  // =================================================
  // PAGINATION
  // =================================================

  List<Map<String, dynamic>> get orders {
    final start = (currentPage - 1) * perPage;

    final end = start + perPage;

    if (start >= filteredOrders.length) {
      return [];
    }

    return filteredOrders.sublist(
      start,

      end > filteredOrders.length ? filteredOrders.length : end,
    );
  }

  int get totalPages {
    if (filteredOrders.isEmpty) {
      return 1;
    }

    return (filteredOrders.length / perPage).ceil();
  }

  // =================================================
  // DASHBOARD
  // =================================================

  int get totalOrder => _orders.length;

  int get totalPendapatan {
    return _orders.fold(
      0,

      (total, item) => total + ((item["price"] ?? 0) as num).toInt(),
    );
  }

  int get totalDiproses =>
      _orders.where((e) => e["status"] == "Diproses").length;

  int get totalSelesai => _orders.where((e) => e["status"] == "Selesai").length;

  // =================================================
  // ACTION FILTER
  // =================================================

  void searchOrder(String value) {
    searchQuery = value;

    currentPage = 1;

    notifyListeners();
  }

  void filterStatus(String value) {
    selectedStatus = value;

    currentPage = 1;

    notifyListeners();
  }

  void filterDate(DateTime start, DateTime end) {
    startDate = start;

    endDate = end;

    currentPage = 1;

    notifyListeners();
  }

  void nextPage() {
    if (currentPage < totalPages) {
      currentPage++;

      notifyListeners();
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;

      notifyListeners();
    }
  }
}

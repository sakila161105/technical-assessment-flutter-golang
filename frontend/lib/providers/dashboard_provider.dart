import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_provider.dart';

class DashboardProvider extends ChangeNotifier {
  // USER LOGIN

  String userName = "Mario Wicaksono";

  String role = "Owner";

  String outletName = "Mewing Laundry";

  // DASHBOARD DATA

  int pendapatanBersih = 0;

  int penjualan = 0;

  int pengeluaran = 0;

  int pendapatanKotor = 0;

  // ==========================
  // LOAD DARI ORDER PROVIDER
  // ==========================

  void loadDashboard(BuildContext context) {
    final order = context.read<OrderProvider>();

    pendapatanBersih = order.totalPendapatan;

    pendapatanKotor = order.totalPendapatan;

    penjualan = order.totalOrder;

    // sementara belum ada tabel pengeluaran
    pengeluaran = 0;

    notifyListeners();
  }

  // UPDATE DATA MANUAL (JIKA DIPERLUKAN)

  void updateDashboard({int? bersih, int? jual, int? keluar, int? kotor}) {
    if (bersih != null) {
      pendapatanBersih = bersih;
    }

    if (jual != null) {
      penjualan = jual;
    }

    if (keluar != null) {
      pengeluaran = keluar;
    }

    if (kotor != null) {
      pendapatanKotor = kotor;
    }

    notifyListeners();
  }

  // UPDATE USER

  void updateUser({String? nama, String? jabatan, String? outlet}) {
    if (nama != null) {
      userName = nama;
    }

    if (jabatan != null) {
      role = jabatan;
    }

    if (outlet != null) {
      outletName = outlet;
    }

    notifyListeners();
  }
}

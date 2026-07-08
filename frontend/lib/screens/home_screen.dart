import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dashboard_provider.dart';
import '../providers/order_provider.dart';

import 'pesanan_screen.dart';
import 'transaksi_screen.dart';
import 'status_screen.dart';
import 'akun_screen.dart';

import 'layanan_screen.dart';
import 'pelanggan_screen.dart';
import 'pengeluaran_screen.dart';
import 'laporan_screen.dart';

import 'history_screen.dart';
import 'topup_screen.dart';
import 'promo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color primaryRed = Color(0xffd50000);

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<OrderProvider>().fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = context.watch<DashboardProvider>();

    final order = context.watch<OrderProvider>();

    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(context, dashboard),

              Transform.translate(
                offset: const Offset(0, -45),

                child: Column(
                  children: [
                    _finance(dashboard, order),

                    const SizedBox(height: 20),

                    _menu(context),

                    const SizedBox(height: 20),

                    _promo(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, DashboardProvider dashboard) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(22, 30, 22, 110),

      decoration: const BoxDecoration(
        color: primaryRed,

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),

          bottomRight: Radius.circular(35),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 26,

                backgroundColor: Colors.white,

                child: Icon(Icons.person, color: primaryRed, size: 32),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      dashboard.userName,

                      style: const TextStyle(
                        color: Colors.white,

                        fontSize: 20,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      dashboard.role,

                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.notifications, color: Colors.white, size: 30),
            ],
          ),

          const SizedBox(height: 28),

          Text(
            "Hai, ${dashboard.outletName}",

            style: const TextStyle(
              color: Colors.white,

              fontSize: 20,

              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            "Semangat tingkatkan omset",

            style: TextStyle(color: Colors.white),
          ),

          const SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              _actionButton(
                context,

                Icons.history,

                "History",

                const HistoryScreen(),
              ),

              const SizedBox(width: 35),

              _actionButton(
                context,

                Icons.account_balance_wallet,

                "Top Up",

                const TopUpScreen(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
    BuildContext context,
    IconData icon,
    String title,
    Widget page,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },

      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 32),

          const SizedBox(height: 5),

          Text(
            title,

            style: const TextStyle(
              color: Colors.white,

              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _finance(DashboardProvider dashboard, OrderProvider order) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(25),

        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),

      child: Column(
        children: [
          Row(
            children: [
              _tab("Keuangan", true),

              _tab("Ringkasan", false),

              _tab("Outlet", false),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              _financeCard(
                "Pendapatan Bersih",

                "Rp ${order.totalPendapatan}",

                Colors.green,

                Icons.account_balance_wallet,
              ),

              _financeCard(
                "Penjualan",

                "${order.totalOrder}",

                Colors.orange,

                Icons.shopping_cart,
              ),
            ],
          ),

          Row(
            children: [
              _financeCard(
                "Pengeluaran",

                "Rp ${dashboard.pengeluaran}",

                Colors.blue,

                Icons.money_off,
              ),

              _financeCard(
                "Pendapatan Kotor",

                "Rp ${dashboard.pendapatanKotor}",

                Colors.pink,

                Icons.bar_chart,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tab(String text, bool active) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),

        padding: const EdgeInsets.symmetric(vertical: 10),

        decoration: BoxDecoration(
          color: active ? Colors.red.shade100 : Colors.transparent,

          borderRadius: BorderRadius.circular(20),
        ),

        child: Text(
          text,

          textAlign: TextAlign.center,

          style: TextStyle(
            color: active ? primaryRed : Colors.black54,

            fontSize: 12,

            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _financeCard(String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Container(
        height: 105,

        margin: const EdgeInsets.all(6),

        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: color.withOpacity(0.15),

          borderRadius: BorderRadius.circular(18),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Icon(icon, color: color, size: 22),

            const SizedBox(height:
            
             5),

            Text(
              title,

              style: const TextStyle(fontSize: 11, color: Colors.black54),
            ),

            Text(
              value,

              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menu(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(25),
      ),

      child: GridView.count(
        shrinkWrap: true,

        physics: const NeverScrollableScrollPhysics(),

        crossAxisCount: 4,

        children: [
          _menuItem(
            context,
            Icons.shopping_bag,
            "Pesanan",
            const PesananScreen(),
          ),

          _menuItem(
            context,
            Icons.receipt_long,
            "Transaksi",
            const TransaksiScreen(),
          ),

          _menuItem(context, Icons.access_time, "Status", const StatusScreen()),

          _menuItem(context, Icons.person, "Akun", const AkunScreen()),

          _menuItem(
            context,
            Icons.local_laundry_service,
            "Layanan",
            const LayananScreen(),
          ),

          _menuItem(
            context,
            Icons.people,
            "Pelanggan",
            const PelangganScreen(),
          ),

          _menuItem(
            context,
            Icons.money_off,
            "Pengeluaran",
            const PengeluaranScreen(),
          ),

          _menuItem(context, Icons.bar_chart, "Laporan", const LaporanScreen()),
        ],
      ),
    );
  }

  Widget _menuItem(
    BuildContext context,
    IconData icon,
    String title,
    Widget page,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),

      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          CircleAvatar(
            radius: 25,

            backgroundColor: Colors.red.shade50,

            child: Icon(icon, color: primaryRed, size: 25),
          ),

          const SizedBox(height: 8),

          Text(
            title,

            textAlign: TextAlign.center,

            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _promo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),

      child: Row(
        children: [
          const Icon(Icons.card_giftcard, color: Colors.orange, size: 35),

          const SizedBox(width: 15),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Lihat Promo",

                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(
                  "Promo menarik untuk pelanggan laundry",

                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryRed,

              foregroundColor: Colors.white,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            onPressed: () {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const PromoScreen()),
              );
            },

            child: const Text("Promo"),
          ),
        ],
      ),
    );
  }
}

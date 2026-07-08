import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';

class FormOrderScreen extends StatefulWidget {
  final Map<String, dynamic>? order;

  const FormOrderScreen({super.key, this.order});

  @override
  State<FormOrderScreen> createState() => _FormOrderScreenState();
}

class _FormOrderScreenState extends State<FormOrderScreen> {
  static const Color primaryRed = Color(0xFFD50000);

  final _formKey = GlobalKey<FormState>();

  late TextEditingController customerController;

  late TextEditingController priceController;

  String status = "Diterima";

  String payment = "Lunas";

  final List<String> serviceOptions = [
    "Cuci Kering",

    "Cuci Setrika",

    "Cuci Lipat",

    "Karpet",

    "Selimut",

    "Sepatu",

    "Express",
  ];

  List<String> selectedServices = [];

  bool get isEdit => widget.order != null;

  String get serviceText => selectedServices.join(", ");

  String get serviceCount => "${selectedServices.length} Layanan";

  String get estimate {
    if (selectedServices.contains("Express")) {
      return "Express 6 Jam";
    }

    if (selectedServices.length <= 1) {
      return "1 Hari";
    }

    if (selectedServices.length == 2) {
      return "2 Hari";
    }

    if (selectedServices.length == 3) {
      return "3 Hari";
    }

    return "4 Hari";
  }

  @override
  void initState() {
    super.initState();

    customerController = TextEditingController(
      text: widget.order?["customer"] ?? "",
    );

    priceController = TextEditingController(
      text: widget.order?["price"]?.toString() ?? "",
    );

    status = widget.order?["status"] ?? "Diterima";

    payment = widget.order?["payment"] ?? "Lunas";

    if (isEdit) {
      final service = widget.order?["service"]?.toString() ?? "";

      selectedServices = service
          .split(",")
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }
  }

  @override
  void dispose() {
    customerController.dispose();

    priceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OrderProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),

      appBar: AppBar(
        backgroundColor: primaryRed,

        foregroundColor: Colors.white,

        title: Text(
          isEdit ? "Edit Pesanan" : "Tambah Pesanan",

          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Form(
          key: _formKey,

          child: Container(
            padding: const EdgeInsets.all(18),

            decoration: _cardDecoration(),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                if (isEdit) _transactionInfo(),

                _input(
                  controller: customerController,

                  label: "Nama Pelanggan",

                  icon: Icons.person,
                ),

                const SizedBox(height: 14),

                _input(
                  controller: priceController,

                  label: "Harga",

                  icon: Icons.payments,

                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 18),

                const Text(
                  "Pilih Layanan",

                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                Wrap(
                  spacing: 8,

                  runSpacing: 8,

                  children: serviceOptions.map((service) {
                    final selected = selectedServices.contains(service);

                    return FilterChip(
                      label: Text(service),

                      selected: selected,

                      onSelected: (value) {
                        setState(() {
                          if (value) {
                            selectedServices.add(service);
                          } else {
                            selectedServices.remove(service);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),
                _estimateBox(),

                const SizedBox(height: 14),

                DropdownButtonFormField<String>(
                  value: status,

                  decoration: _decoration("Status", Icons.timelapse),

                  items: const [
                    DropdownMenuItem(
                      value: "Diterima",

                      child: Text("Diterima"),
                    ),

                    DropdownMenuItem(
                      value: "Diproses",

                      child: Text("Diproses"),
                    ),

                    DropdownMenuItem(value: "Selesai", child: Text("Selesai")),
                  ],

                  onChanged: (value) {
                    setState(() {
                      status = value!;
                    });
                  },
                ),

                const SizedBox(height: 14),

                DropdownButtonFormField<String>(
                  value: payment,

                  decoration: _decoration(
                    "Pembayaran",
                    Icons.account_balance_wallet,
                  ),

                  items: const [
                    DropdownMenuItem(value: "Lunas", child: Text("Lunas")),

                    DropdownMenuItem(
                      value: "Belum Lunas",

                      child: Text("Belum Lunas"),
                    ),
                  ],

                  onChanged: (value) {
                    setState(() {
                      payment = value!;
                    });
                  },
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,

                  height: 50,

                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),

                    label: Text(
                      isEdit ? "Update Pesanan" : "Simpan Pesanan",

                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRed,

                      foregroundColor: Colors.white,

                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),

                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      if (selectedServices.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Pilih minimal 1 layanan"),

                            backgroundColor: Colors.red,
                          ),
                        );

                        return;
                      }

                      final data = {
                        "Customer": customerController.text,

                        "Service": serviceText,

                        "Price": int.parse(priceController.text),

                        "Status": status,

                        "Payment": payment,

                        "Estimate": estimate,

                        "ServiceCount": serviceCount,
                      };

                      bool success;

                      if (isEdit) {
                        success = await provider.updateOrder(
                          widget.order!["id"],

                          data,
                        );
                      } else {
                        success = await provider.createOrder(data);
                      }

                      if (!mounted) {
                        return;
                      }

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isEdit
                                  ? "Pesanan berhasil diperbarui"
                                  : "Pesanan berhasil ditambahkan",
                            ),

                            backgroundColor: Colors.green,
                          ),
                        );

                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Gagal menyimpan pesanan"),

                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _transactionInfo() {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(bottom: 16),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.red.shade50,

        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: primaryRed.withOpacity(0.12),

            child: const Icon(Icons.receipt_long, color: primaryRed),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              widget.order?["code"] ?? "-",

              style: const TextStyle(
                color: primaryRed,

                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Text(
            widget.order?["date"] ?? "-",

            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _estimateBox() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.red.shade50,

        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: Colors.red.shade100),
      ),

      child: Row(
        children: [
          const Icon(Icons.schedule, color: primaryRed),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              selectedServices.isEmpty
                  ? "Estimasi akan muncul setelah memilih layanan"
                  : "Estimasi: $estimate\n$serviceCount",

              style: const TextStyle(
                color: primaryRed,

                fontWeight: FontWeight.bold,

                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _input({
    required TextEditingController controller,

    required String label,

    required IconData icon,

    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,

      keyboardType: keyboardType,

      decoration: _decoration(label, icon),

      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "$label wajib diisi";
        }

        if (label == "Harga") {
          final price = int.tryParse(value);

          if (price == null || price <= 0) {
            return "Harga harus berupa angka lebih dari 0";
          }
        }

        return null;
      },
    );
  }

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,

      prefixIcon: Icon(icon, color: primaryRed),

      filled: true,

      fillColor: const Color(0xFFF7F7F7),

      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),

        borderSide: BorderSide.none,
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,

      borderRadius: BorderRadius.circular(18),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),

          blurRadius: 10,

          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

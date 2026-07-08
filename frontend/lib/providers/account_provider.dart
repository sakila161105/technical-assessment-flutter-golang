import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier {
  String outletName = "Mewing Laundry";
  String ownerName = "Mario Wicaksono";
  String role = "Owner";
  String email = "admin@mewinglaundry.com";
  String phone = "08123456789";
  String address = "Jl. Contoh No. 10";

  void updateProfile({
    required String outlet,
    required String owner,
    required String userRole,
    required String emailAddress,
    required String phoneNumber,
    required String outletAddress,
  }) {
    outletName = outlet;
    ownerName = owner;
    role = userRole;
    email = emailAddress;
    phone = phoneNumber;
    address = outletAddress;

    notifyListeners();
  }
}
import 'package:flutter/material.dart';

/// App bar set in all product forms (src/forms folder).
class FormAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Agregar una transacción",
          style: TextStyle(fontSize: 19, color: Colors.white)),
      centerTitle: true,
      backgroundColor: const Color(0xff073B3A),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}

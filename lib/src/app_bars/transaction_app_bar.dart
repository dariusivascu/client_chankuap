import 'package:flutter/material.dart';

/// App bar set in the Transactions.dart page.
class TransactionAppBar extends StatelessWidget {
  String appBarTitle = "";

  TransactionAppBar(String title) {
    this.appBarTitle = title;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("$appBarTitle",
          style: const TextStyle(fontSize: 19, color: Colors.white)),
      centerTitle: true,
      backgroundColor: const Color(0xff073B3A),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: <Widget>[
        IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () => print("search"))
      ],
    );
  }
}

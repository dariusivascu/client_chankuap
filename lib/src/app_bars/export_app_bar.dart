import 'package:flutter/material.dart';

/// App bar set in the Export.dart page.
class ExportAppBar extends StatelessWidget {
  String appBarTitle = "";

  ExportAppBar(String title) {
    this.appBarTitle = title;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appBarTitle),
      centerTitle: true,
      backgroundColor: const Color(0xff073B3A),
      actions: <Widget>[
        IconButton(
            icon: const Icon(Icons.search), onPressed: () => print("search"))
      ],
    );
  }
}

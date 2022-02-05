import 'package:client_chankuap/src/buttons/add_button.dart';
import 'package:flutter/material.dart';

class AddBar extends StatefulWidget {
  final Icon icon;
  final String title;
  final int page;

  AddBar({Key? key, required this.icon, required this.title, required this.page}) : super(key: key);

  _AddBarState createState() => _AddBarState();
}

class _AddBarState extends State<AddBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Row(children: <Widget>[
          Expanded(
            flex: 2,
            child: widget.icon,
          ),
          Expanded(
            flex: 5,
            child: Text(widget.title,
                style: const TextStyle(color: Color(0xff073B3A), fontSize: 16)),
          ),
          Expanded(flex: 3, child: AddButton(page: widget.page))
        ]));
  }
}

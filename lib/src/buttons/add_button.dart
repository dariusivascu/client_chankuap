import 'package:flutter/material.dart';

import '../forms/entradas/add_entrada_form.dart';
import '../forms/salidas/add_salida_form.dart';

/// Set in the "add_bar.dart" component.
/// When pressed, it will push the appropriate formula to the navigator.
///
class AddButton extends StatefulWidget {
  const AddButton({Key? key, required this.page}) : super(key: key);

  /// Value sets which transaction page is currently on the navigator (Entrada or Salida).
  final int page;

  @override
  State<StatefulWidget> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  final AddSalidaForm _addSalidaForm = AddSalidaForm();
  final AddEntradaForm _addEntradaForm = AddEntradaForm();

  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.white,
      onPressed: () => {
        /// 1 --> Entrada.
        if (widget.page == 1)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _addEntradaForm),
          ),

        /// 2 --> Salida
        if (widget.page == 2)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _addSalidaForm),
          ),
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: Color(0xff073B3A))),
      child: Row(
        children: const <Widget>[
          Expanded(
              flex: 6,
              child:
                  Text("Anadir", style: TextStyle(color: Color(0xff073B3A)))),
          Icon(Icons.add, color: Color(0xff073B3A)),
        ],
      ),
    );
  }
}

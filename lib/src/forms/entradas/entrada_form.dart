import 'dart:async';
import 'dart:convert';

import 'package:client_chankuap/src/Widgets/data_object.dart';
import 'package:client_chankuap/src/Widgets/selectMaterial.dart';
import 'package:client_chankuap/src/app_bars/form_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../globals.dart';
import '../product_list_form.dart';
import '../../globals.dart' as globals;

class EntradaForm extends StatefulWidget {
  // final int id;
  final EntradaOverview trans;
  final EntradaTrans entradaTrans;

  EntradaForm({Key? key, required this.trans, required this.entradaTrans}) : super(key: key);

  @override
  _EntradaFormState createState() => _EntradaFormState();
}

Future<EntradaTrans> _getEntrada(int id) async {
  var client = http.Client();
  var url = 'https://wakerakka.herokuapp.com/';
  var endpoint = 'transactions/in/${id}';

  try {
    var uriResponse = await client.get(Uri.parse(url + endpoint));

    if (uriResponse.statusCode == 200) {
      Map<String, dynamic> body = json.decode(uriResponse.body);
      print(body);
      return EntradaTrans.fromJson(body);
    } else {
      throw Exception('Failed to load album');
    }
  } finally {
    client.close();
  }
}

_intToName(int usario) {
  switch (usario) {
    case 0:
      return 'Isaac';
    case 1:
      return 'Yollanda';
    case 2:
      return 'Nube';
    case 3:
      return 'Veronica';
    case 4:
      return 'Anita';
    case 5:
      return 'Ernesto';
  }
}

class _EntradaFormState extends State<EntradaForm> {
  final _fKey = GlobalKey<FormState>();

  final clienteFocusNode = FocusNode();
  final IdFocusNode = FocusNode();
  final CodigoFocusNode = FocusNode();
  final DondeFocusNode = FocusNode();
  final ComunidadFocusNode = FocusNode();
  final stepperPage = StepperPage();
  final productList = ProductListForm();
  late globals.MateriasProvider materiasProv;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    materiasProv = Provider.of<MateriasProvider>(context);

    return Scaffold(
      appBar: FormAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height - 110,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Form(
            key: _fKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                const SizedBox(height: 10),
                Container(
                  child: Text(
                    "Entrada De Mercaderia - Ficha n°" +
                        widget.trans.trans_id.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(color: Color(0xff073B3A)),
                  decoration: const InputDecoration(labelText: 'Fecha 1'),
                  initialValue: widget.entradaTrans.fecha_uno,
                  enabled: false,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(color: Color(0xff073B3A)),
                  decoration: const InputDecoration(labelText: 'Fecha 2'),
                  initialValue: widget.entradaTrans.fecha_dos,
                  enabled: false,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(color: Color(0xff073B3A)),
                  decoration: const InputDecoration(labelText: 'Empleado/a'),
                  initialValue: _intToName(widget.entradaTrans.quien),
                  enabled: false,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(color: Color(0xff073B3A)),
                  decoration:
                      const InputDecoration(labelText: 'Nombre del Productor'),
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  initialValue: widget.entradaTrans.productor,
                  enabled: false,
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Necesitas el nombre del productor';
                    }
                    return null;
                  },
                  autofocus: true,
                  focusNode: clienteFocusNode,
                  textInputAction: TextInputAction.next,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    FocusScope.of(context).requestFocus(clienteFocusNode);
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Codigo de Productor',
                  ),
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  initialValue: widget.entradaTrans.p_code,
                  enabled: false,
                  autofocus: true,
                  validator: (codigo) {
                    if (codigo!.isEmpty) {
                      return 'Necesitas un codigo';
                    }
                    return null;
                  },
                  focusNode: CodigoFocusNode,
                  textInputAction: TextInputAction.next,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    FocusScope.of(context).requestFocus(CodigoFocusNode);
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: widget.entradaTrans.ID,
                  enabled: false,
                  //name given according to id
                  decoration: const InputDecoration(
                    labelText: 'Cedula',
                  ),
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  autofocus: true,
                  focusNode: IdFocusNode,
                  textInputAction: TextInputAction.next,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    FocusScope.of(context).requestFocus(IdFocusNode);
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(color: Color(0xff073B3A)),
                  decoration: const InputDecoration(labelText: 'Zona'),
                  initialValue: widget.entradaTrans.zona,
                  enabled: false,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  enabled: false,
                  initialValue: widget.entradaTrans.comunidad,
                  decoration: const InputDecoration(
                    labelText: 'Comunidad',
                  ),
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  autofocus: true,
                  focusNode: ComunidadFocusNode,
                  textInputAction: TextInputAction.next,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    FocusScope.of(context).requestFocus(ComunidadFocusNode);
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Expanded(
                      flex: 8,
                      child: Text("Materias Primas",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
                Container(
                  height: 300,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                      child: productList),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

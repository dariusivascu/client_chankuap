import 'package:client_chankuap/src/Widgets/CustomAlertDialog.dart';
import 'package:client_chankuap/src/Widgets/data_object.dart';
import 'package:client_chankuap/src/Widgets/selectMaterial.dart';
import 'package:client_chankuap/src/app_bars/form_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../product_list_form.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class AddEntradaForm extends StatefulWidget {
  @override
  _AddEntradaFormState createState() => _AddEntradaFormState();
}

class _AddEntradaFormState extends State<AddEntradaForm> {
  final _formKey = GlobalKey<FormState>();

  String _usario = "Isaac";
  String _fechaUno = "";
  String _fechaDos = "";
  String _productorName = "";
  String _codigoProductor = "";
  String _cedula = "";
  String _comunidad = "";
  String _zona = "Shuar";

  List<Producto> productos = [];

  final clienteFocusNode = FocusNode();
  final IdFocusNode = FocusNode();
  final CodigoFocusNode = FocusNode();
  final ComunidadFocusNode = FocusNode();
  final stepperPage = StepperPage();
  final productList = ProductListForm();

  // late MateriasProvider materiasProv;

  @override
  void initState() {
    super.initState();
    // stepperPage.productos = productos;
    // productList.materiasPrimas = productos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FormAppBar(),
      body: Container(
          height: MediaQuery.of(context).size.height - 110,
          child: SafeArea(
              top: false,
              bottom: false,
              child: Form(
                  key: _formKey,
                  child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      children: <Widget>[
                        const SizedBox(height: 10),
                        Container(
                          child: const Text(
                            "Entrada De Mercaderia", //request numero latest ficha
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, color: Color(0xff073B3A)),
                          ),
                        ),
                        const SizedBox(height: 15),
                        InputDatePickerFormField(
                            onDateSaved: (value) => {
                                  _fechaUno = DateFormat('yyyy-MM-dd')
                                      .format(value)
                                      .toString()
                                },
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021, 1, 1),
                            lastDate: DateTime(2060, 1, 1)),
                        const SizedBox(height: 10),
                        InputDatePickerFormField(
                            onDateSaved: (value) => {
                                  _fechaDos = DateFormat('yyyy-MM-dd')
                                      .format(value)
                                      .toString()
                                },
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021, 1, 1),
                            lastDate: DateTime(2060, 1, 1)),
                        const SizedBox(height: 10),
                        FormBuilderDropdown(
                          onSaved: (value) => _usario = value as String,
                          decoration: const InputDecoration(labelText: 'Empleado/a'),
                          initialValue: _usario,
                          items: [
                            'Isaac',
                            'Yollanda',
                            'Nube',
                            'Veronica',
                            'Anita',
                            'Ernesto'
                          ]
                              .map((quien) => DropdownMenuItem(
                                  value: quien,
                                  child: Text(quien,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Color(0xff073B3A)))))
                              .toList(),
                          name: 'quien',
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          style: const TextStyle(color: Color(0xff073B3A)),
                          decoration: const InputDecoration(
                              labelText: 'Nombre del Productor'),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30)
                          ],
                          onSaved: (name) {
                            _productorName = name!;
                          },
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
                            FocusScope.of(context)
                                .requestFocus(clienteFocusNode);
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          style: const TextStyle(color: Color(0xff073B3A)),
                          decoration: const InputDecoration(
                            labelText: 'Codigo de Productor',
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30)
                          ],
                          onSaved: (codigo) {
                            _codigoProductor = codigo!;
                          },
                          validator: (codigo) {
                            if (codigo!.isEmpty) {
                              return 'Necesitas un codigo';
                            }
                            return null;
                          },
                          autofocus: true,
                          focusNode: CodigoFocusNode,
                          textInputAction: TextInputAction.next,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            FocusScope.of(context)
                                .requestFocus(CodigoFocusNode);
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(
                            fillColor: Color(0xff073B3A),
                            labelText: 'Cedula',
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30)
                          ],
                          keyboardType: TextInputType.number,
                          onSaved: (id) {
                            _cedula = id!;
                          },
                          validator: (id) {
                            if (id!.isEmpty) {
                              return 'Necesitas un cedula';
                            }
                            return null;
                          },
                          autofocus: true,
                          focusNode: IdFocusNode,
                          textInputAction: TextInputAction.next,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            FocusScope.of(context).requestFocus(IdFocusNode);
                          },
                        ),
                        const SizedBox(height: 10),
                        FormBuilderDropdown(
                          decoration: const InputDecoration(labelText: 'Zona'),
                          initialValue: "Shuar",
                          onSaved: (value) => {
                            _zona = value as String,
                          },
                          items: ['Shuar', 'Achuar']
                              .map((comu) => DropdownMenuItem(
                                  value: comu,
                                  child: Text(
                                    comu,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        color: Color(0xff073B3A)),
                                  )))
                              .toList(),
                          name: 'zona',
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(
                            fillColor: Color(0xff073B3A),
                            labelText: 'Comunidad',
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30)
                          ],
                          onSaved: (value) {
                            _comunidad = value!;
                          },
                          validator: (id) {
                            if (id!.isEmpty) {
                              return 'Necesitas un comunidad';
                            }
                            return null;
                          },
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
                          children: [
                            const Expanded(
                              flex: 8,
                              child: Text("Materias Primas",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18)),
                            ),
                            Expanded(
                                flex: 2,
                                child: IconButton(
                                  iconSize: 20,
                                  icon: const Icon(Icons.add),
                                  onPressed: () => setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => stepperPage),
                                    );
                                  }),
                                ))
                          ],
                        ),
                        Container(
                            height: 300,
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 15),
                                child: productList)),
                      ])))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var dialog = CustomAlertDialog(
            title: "Registrar la transacción",
            message: "Estas seguro?",
            onPositivePressed: () {
              _validateInputs();
            },
            positiveBtnText: 'Si',
            negativeBtnText: 'No',
          );
          // var dialog = new Container();
          showDialog(
              context: context, builder: (BuildContext context) => dialog);
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xff073B3A),
      ),
    );
  }

  void _validateInputs() {
    if (_formKey.currentState!.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState!.save();
      _sendEntrada();
    }
  }

  Future _sendEntrada() async {
    var client = http.Client();
    var url = 'https://wakerakka.herokuapp.com/';
    var endpoint = 'transactions/in/';

    EntradaTrans trans = EntradaTrans(
        _fechaUno,
        _fechaDos,
        _nameToInt(_usario),
        _productorName,
        _codigoProductor,
        _cedula,
        _comunidad,
        _zona,
        productos);

    try {
      var uriResponse = await client.post(Uri.parse(url + endpoint),
          body: json.encode(trans.toJson()));
      print(json.encode(trans));

      if (await uriResponse.statusCode == 201)
        Navigator.pop(context);
      else
        print(await uriResponse.statusCode);
    } finally {
      client.close();
    }
  }



  _nameToInt(String usario) {
    switch (usario) {
      case 'Isaac':
        return 0;
      case 'Yollanda':
        return 1;
      case 'Nube':
        return 2;
      case 'Veronica':
        return 3;
      case 'Anita':
        return 4;
      case 'Ernesto':
        return 5;
    }
  }
}

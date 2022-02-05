import 'package:client_chankuap/src/Widgets/CustomAlertDialog.dart';
import 'package:client_chankuap/src/Widgets/data_object.dart';
import 'package:client_chankuap/src/Widgets/selectMaterial.dart';
import 'package:client_chankuap/src/app_bars/form_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../../forms/product_list_form.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class AddSalidaForm extends StatefulWidget {
  AddSalidaForm({Key? key}) : super(key: key);

  @override
  _AddSalidaFormState createState() => _AddSalidaFormState();
}

class _AddSalidaFormState extends State<AddSalidaForm> {
  final GlobalKey<FormState> _fbkey = GlobalKey<FormState>();

  String _usario = "Isaac";
  String _fechaUno = "";
  String _fechaDos = "";
  String _cliente = "";
  String _ciudad = "";

  List<Producto> productos = [];

  final nameFocusNode = FocusNode();
  final ciudadFocusNode = FocusNode();
  final stepperPage = StepperPage();
  late ProductListForm productList;

  @override
  void initState() {
    super.initState();
    productList = ProductListForm();
    stepperPage.productos = productos;
    productList.materiasPrimas = productos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FormAppBar(),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _fbkey,
          child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
          const SizedBox(height: 10),
          Container(
            child: const Text(
              "Salida De Mercaderia", //get latest id
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 10),
          InputDatePickerFormField(
              onDateSaved: (value) =>
              {
                _fechaUno =
                    DateFormat('yyyy-MM-dd').format(value).toString()
              },
              initialDate: DateTime.now(),
              firstDate: DateTime(2021, 1, 1),
              lastDate: DateTime(2060, 1, 1)),
          const SizedBox(height: 10),
          InputDatePickerFormField(
              onDateSaved: (value) =>
              {
                _fechaDos =
                    DateFormat('yyyy-MM-dd').format(value).toString()
              },
              initialDate: DateTime.now(),
              firstDate: DateTime(2021, 1, 1),
              lastDate: DateTime(2060, 1, 1)),
          const SizedBox(height: 10),
          FormBuilderDropdown(
            onSaved: (value) => _usario = value as String,
            decoration: const InputDecoration(labelText: 'Quien'),
            initialValue: _usario,
            items: ['Isaac', 'Yollanda', 'Nube', 'Veronica', 'Anita']
                .map((quien) =>
                DropdownMenuItem(
                    value: quien,
                    child: Text("$quien", textAlign: TextAlign.center)))
                .toList(),
            name: 'quien',
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Cliente',
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(30)],
            onSaved: (cliente) {
              _cliente = cliente!;
            },
            autofocus: true,
            validator: (cliente) {
              if (cliente!.isEmpty) {
                return 'El nombre del cliente es obligatorio';
              }
              return null;
            },
            focusNode: nameFocusNode,
            textInputAction: TextInputAction.next,
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusScope.of(context).requestFocus(nameFocusNode);
            },
          ),
          // SizedBox(height: 10),
          // FormBuilderDropdown(
          //   initialValue: 'Carro',
          //   onSaved: (value) => _transporte = value as String,
          //   decoration: const InputDecoration(
          //     labelText: 'Medio de Transporte',
          //   ),
          //   items: ['Carro', 'Avion']
          //       .map((medio) => DropdownMenuItem(
          //           value: medio,
          //           child: Text("$medio", textAlign: TextAlign.center)))
          //       .toList(),
          //   name: 'medio',
          // ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Ciudad',
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(30)],
            onSaved: (ciudad) {
              _ciudad = ciudad!;
            },
            autofocus: true,
            validator: (ciudad) {
              if (ciudad!.isEmpty) {
                return 'El nombre de la ciudad es obligatorio';
              }
              return null;
            },
            focusNode: ciudadFocusNode,
            textInputAction: TextInputAction.next,
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusScope.of(context).requestFocus(ciudadFocusNode);
            }),
            const SizedBox(height: 10),
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
                      onPressed: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => stepperPage),
                          )),
                )
              ],
            ),
            Container(
                height: 300,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                    child: productList)),
            ],
          ),
        ),
      ),
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
          // var dialog = Container();
          showDialog(
              context: context, builder: (BuildContext context) => dialog);
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xff073B3A),
      ),
    );
  }

  void _validateInputs() {
    if (_fbkey.currentState!.validate()) {
//    If all data are correct then save data to out variables
      _fbkey.currentState!.save();
      _sendSalida();
    }
  }

  Future _sendSalida() async {
    var client = http.Client();
    var url = 'https://wakerakka.herokuapp.com/';
    var endpoint = 'transactions/out/';

    SalidaTrans trans = SalidaTrans(_cliente, _nameToInt(_usario), _fechaUno,
        _fechaDos, _ciudad, productos);

    try {
      var uriResponse = await client.post(Uri.parse(url + endpoint),
          body: json.encode(trans));
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

// refresh() {
//   setState(() {});
// }
}

/**
    TypeAheadField(
    textFieldConfiguration: TextFieldConfiguration(
    autofocus: true,
    decoration: const InputDecoration(
    labelText: 'Product name',
    hintText: 'Enter product name',
    ),
    ),
    // ignore: missing_return
    suggestionsCallback: (pattern) async {
    //return await BackendService.getSuggestions(pattern);
    },
    itemBuilder: (context, suggestion) {
    return ListTile(
    title: Text(suggestion),
    );
    },
    onSuggestionSelected: (suggestion) {
    this._typeAheadController.text = suggestion;
    },
    ),**/

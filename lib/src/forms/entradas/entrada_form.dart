import 'dart:async';

import 'package:client_chankuap/src/Widgets/data_object.dart';
import 'package:client_chankuap/src/Widgets/selectMaterial.dart';
import 'package:client_chankuap/src/app_bars/form_app_bar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../product_list_form.dart';

class EntradaForm extends StatefulWidget {

  // final int id;
  final EntradaOverview trans;

  EntradaForm({Key? key, required this.trans}) : super(key: key);

  @override
  _EntradaFormState createState() => _EntradaFormState();
}

class _EntradaFormState extends State<EntradaForm> {

  final _fKey = GlobalKey<FormState>();

  String _usario = "Isaac";
  String _fechaUno = "";
  String _fechaDos = "";
  String _productorName = "";
  String _codigoProductor = "";
  String _cedula = "";
  String _comunidad = "Shuar";
  String _transporte = "Carro";

  final clienteFocusNode = FocusNode();
  final IdFocusNode = FocusNode();
  final CodigoFocusNode = FocusNode();
  final DondeFocusNode = FocusNode();
  final stepperPage = StepperPage();
  final productList = ProductListForm();

  List<Producto> productos = [];

  @override
  void initState() {
    print(widget.trans.date);
    stepperPage.productos = productos;
    productList.productos = productos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: FormAppBar(),
      body: Container(
          height: MediaQuery.of(context).size.height - 110,
          child: SafeArea(
              top: false,
              bottom: false,
              child: new Form(
                  key: _fKey,
                  child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      children: <Widget>[
                        SizedBox(height: 10),
                        Container(
                          child: Text(
                            "Entrada De Mercaderia - Ficha n°" +
                                widget.trans.trans_id.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 10),
                        InputDatePickerFormField(
                            onDateSaved: (value) => {
                              _fechaUno = value.toString()
                            },
                            initialDate: DateTime.parse(widget.trans.date),
                            firstDate: DateTime(2020, 1, 1),
                            lastDate:  DateTime(2060, 1, 01)
                        ),
                        SizedBox(height: 10),
                        FormBuilderDropdown(
                            onChanged: (value) => {
                              _usario = value as String
                            },
                            decoration: const InputDecoration(labelText: 'Quien'),
                            initialValue: 'Isaac', //username given based on int
                            onSaved: (value) => {
                              _usario = value as String
                            },
                            items: [
                              'Isaac',
                              'Yollanda',
                              'Nube',
                              'Veronica',
                              'Anita'
                            ].map((quien) => DropdownMenuItem(
                                value: quien,
                                child: Text("$quien",
                                    textAlign: TextAlign.left)
                            )).toList(), name: 'quien',),
                        SizedBox(height: 10),
                        DropdownSearch(
                          items: [
                            'Yollanda',
                            'Nube',
                            'Veronica',
                            'Anita'
                          ].map((quien) => DropdownMenuItem(
                              value: quien,
                              child: Row(
                                children: [
                                  Text("$quien",
                                      textAlign: TextAlign.left),
                                  Expanded(flex: 1, child: Container()),
                                  Text("Productor Limit",
                                      textAlign: TextAlign.right)
                                ],
                              )))
                              .toList(),
                          label: 'Yollanda', //usario de int a p_name
                          hint: "Select one",
                          onChanged: (value) {
                            _productorName = value as String;
                          },
                          // isExpanded: true,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Codigo de Productor',
                          ),
                          inputFormatters: [LengthLimitingTextInputFormatter(30)],
                          onSaved: (value) {
                            _codigoProductor = value!;
                          },
                          initialValue: _codigoProductor,
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
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: widget.trans.provider_id.toString(), //name given according to id
                          decoration: const InputDecoration(
                            labelText: 'Cedula',
                          ),
                          inputFormatters: [LengthLimitingTextInputFormatter(30)],
                          onSaved: (value) {
                            _cedula = value!;
                          },
                          autofocus: true,
                          focusNode: IdFocusNode,
                          textInputAction: TextInputAction.next,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            FocusScope.of(context).requestFocus(DondeFocusNode);
                          },
                        ),
                        SizedBox(height: 10),
                        FormBuilderDropdown(
                            decoration: const InputDecoration(labelText: 'Comunidad'),
                            initialValue: _comunidad,
                            onSaved: (value) => {
                              _comunidad = value as String,
                            },
                            items: [
                              'Shuar',
                              'Achuar'
                            ].map((comu) => DropdownMenuItem(
                                value: comu,
                                child: Text("$comu",
                                    textAlign: TextAlign.left)
                            )).toList(), name: 'comunidad',),
                        SizedBox(height: 10),
                        FormBuilderDropdown(
                            initialValue: "Carro",
                            onSaved: (value) {
                              _transporte = value as String;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Medio de Transporte',
                            ),
                            items: ['Carro', 'Avion'].map((medio) => DropdownMenuItem(
                                value: medio,
                                child: Text("$medio", textAlign: TextAlign.center)))
                                .toList(), name: 'mala',),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Text("Materias Primas",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18)),
                            ),
                            Expanded(
                                flex: 2,
                                child: IconButton(
                                  iconSize: 20,
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    Route route = MaterialPageRoute(
                                        builder: (context) => stepperPage);
                                    Navigator.push(context, route).then(onGoBack);
                                  },
                                ))
                          ],
                        ),
                        Container(
                            height: 300,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                                child: productList)),
                      ])))
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // confirmationDialog(context, "Estas seguro ?",
          //     title: "Confirmacion",
          //     positiveText: "Registrar", positiveAction: () {
          //       //push entrada
          //       _validateInputs();
          //     });
          Container();
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff073B3A),
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    print(stepperPage.productos.length);
    setState((){
      productList.productos = stepperPage.productos;
      print("when");
    });
  }

  void _validateInputs() {
    _fKey.currentState!.save();
  }
}
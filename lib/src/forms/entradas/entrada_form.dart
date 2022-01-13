import 'dart:async';

import 'package:client_chankuap/src/Widgets/data_object.dart';
import 'package:client_chankuap/src/Widgets/selectMaterial.dart';
import 'package:client_chankuap/src/app_bars/form_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../../globals.dart';
import '../product_list_form.dart';
import '../../globals.dart' as globals;

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
  String _comunidad = "";
  String _zona = "Shuar";
  // String _transporte = "Carro";

  final clienteFocusNode = FocusNode();
  final IdFocusNode = FocusNode();
  final CodigoFocusNode = FocusNode();
  final DondeFocusNode = FocusNode();
  final ComunidadFocusNode = FocusNode();
  final stepperPage = StepperPage();
  final productList = ProductListForm();
  late globals.MateriasProvider materiasProv;

  // List<Producto> productos = [];

  @override
  void initState() {
    print(widget.trans.date);
    // stepperPage.productos = productos;
    // productList.materiasPrimas = materiasProv.materiasPrimas;
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
                    onDateSaved: (value) => {_fechaUno = value.toString()},
                    initialDate: DateTime.parse(widget.trans.date),
                    firstDate: DateTime(2020, 1, 1),
                    lastDate: DateTime(2060, 1, 01)),
                SizedBox(height: 10),
                FormBuilderDropdown(
                  onChanged: (value) => {_usario = value as String},
                  decoration: const InputDecoration(labelText: 'Empleado/a'),
                  initialValue: 'Isaac',
                  //username given based on int
                  onSaved: (value) => {_usario = value as String},
                  items: ['Isaac', 'Yollanda', 'Nube', 'Veronica', 'Anita', 'Ernesto']
                      .map((quien) => DropdownMenuItem(
                          value: quien,
                          child: Text("$quien", textAlign: TextAlign.left)))
                      .toList(),
                  name: 'quien',
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
                  initialValue: widget.trans.provider_id.toString(),
                  //name given according to id
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
                  decoration: const InputDecoration(labelText: 'Zona'),
                  initialValue: _zona,
                  onSaved: (value) => {
                    _zona = value as String,
                  },
                  items: ['Shuar', 'Achuar']
                      .map((zona) => DropdownMenuItem(
                          value: zona,
                          child: Text("$zona", textAlign: TextAlign.left)))
                      .toList(),
                  name: 'zona',
                ),
                SizedBox(height: 10),
                TextFormField(
                  //name given according to id
                  decoration: const InputDecoration(
                    labelText: 'Comunidad',
                  ),
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  onSaved: (value) {
                    _comunidad = value!;
                  },
                  autofocus: true,
                  focusNode: ComunidadFocusNode,
                  textInputAction: TextInputAction.next,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    FocusScope.of(context).requestFocus(ComunidadFocusNode);
                  },
                ),
                // SizedBox(height: 10),
                // FormBuilderDropdown(
                //   initialValue: "Carro",
                //   onSaved: (value) {
                //     _transporte = value as String;
                //   },
                //   decoration: const InputDecoration(
                //     labelText: 'Medio de Transporte',
                //   ),
                //   items: ['Carro', 'Avion']
                //       .map((medio) => DropdownMenuItem(
                //           value: medio,
                //           child: Text("$medio", textAlign: TextAlign.center)))
                //       .toList(),
                //   name: 'mala',
                // ),
                SizedBox(height: 20),
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
                        onPressed: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => stepperPage);
                          Navigator.push(context, route);
                        },
                      ),
                    )
                  ],
                ),
                Container(
                    height: 300,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                        child: productList),),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // confirmationDialog(context, "Estas seguro ?",
          //     title: "Confirmacion",
          //     positiveText: "Registrar", positiveAction: () {
          //       //push entrada
          //       _validateInputs();
          //     });
          // Container();
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff073B3A),
      ),
    );
  }

  // Widget _showMaterias() {
  //   return ListView.separated(
  //     padding: const EdgeInsets.all(8),
  //     itemCount: materiasProv.materiasPrimas.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return Container(
  //         height: 60,
  //         color: Color(0xffEFEFEF),
  //         child: _buildProductBox(context, index),
  //       );
  //     },
  //     separatorBuilder: (BuildContext context, int index) => const Divider(),
  //   );
  // }
  //
  // Widget _buildProductBox(BuildContext context, int index) {
  //   return Container(
  //       height: 60,
  //       decoration: BoxDecoration(
  //           color: Colors.white, border: Border.all(color: Color(0xff073B3A))),
  //       child: Form(
  //           child: Stack(
  //             children: [
  //               Align(
  //                   alignment: Alignment(-0.8, -0.5),
  //                   child: Container(
  //                       child: Text(
  //                         materiasProv.materiasPrimas[index].name,
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(fontSize: 16),
  //                       ))),
  //               Align(
  //                   alignment: Alignment(-0.8, 0.5),
  //                   child: Container(
  //                       child: Text(
  //                         materiasProv.materiasPrimas[index].getNumeroLote(),
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(fontStyle: FontStyle.italic),
  //                       ))),
  //               Align(
  //                   alignment: Alignment(0.5, -0.5),
  //                   child: Container(
  //                       child: Text(
  //                         '${materiasProv.materiasPrimas[index].cantidad}' +
  //                             '${materiasProv.materiasPrimas[index].unidad}',
  //                         textAlign: TextAlign.right,
  //                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  //                       ))),
  //               Align(
  //                   alignment: Alignment(0.5, 0.5),
  //                   child: Container(
  //                       child: Text(
  //                         '${materiasProv.materiasPrimas[index].precio}\$',
  //                         textAlign: TextAlign.right,
  //                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  //                       ))),
  //               Align(
  //                   alignment: Alignment(1, 0),
  //                   child: IconButton(
  //                       iconSize: 20,
  //                       icon: Icon(Icons.do_disturb_on_outlined),
  //                       onPressed: () => () {
  //                         context.read<MateriasProvider>().materiasPrimas.removeAt(index);
  //                         print("te fut");
  //                       }
  //                   ))
  //             ],
  //           )
  //       )
  //   );
  // }

  FutureOr onGoBack(dynamic value) {
    print(materiasProv.materiasPrimas.length);
    setState(() {
      productList.materiasPrimas = materiasProv.materiasPrimas;
      print("when");
    });
  }

  void _validateInputs() {
    _fKey.currentState!.save();
  }
}

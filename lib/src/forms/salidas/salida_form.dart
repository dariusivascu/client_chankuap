import 'package:client_chankuap/src/Widgets/data_object.dart';
import 'package:client_chankuap/src/Widgets/selectMaterial.dart';
import 'package:client_chankuap/src/app_bars/form_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../product_list_form.dart';

class SalidaForm extends StatefulWidget {
  SalidaForm({Key? key, required this.trans}) : super(key: key);

  final SalidaOverview trans;

  // final int id;

  @override
  _SalidaFormState createState() => _SalidaFormState();
}

class _SalidaFormState extends State<SalidaForm> {
  final _fbkey = GlobalKey<FormState>();

  String _usario = "Isaac";
  String _fechaUno = "";
  String _fechaDos = "";
  String _cliente = "";
  String _ciudad = "";
  String _transporte = "Carro";

  final nameFocusNode = FocusNode();
  final ciudadFocusNode = FocusNode();
  final stepperPage = StepperPage();
  final productList = ProductListForm();
  late SalidaOverview trans;

  final List<Producto> productos = [];

  @override
  void initState() {
    this.trans = widget.trans;
    stepperPage.productos = productos;
    productList.materiasPrimas = productos;
    super.initState();
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
                child: Text(
                  "Salida De Mercaderia - Ficha n°" +
                      widget.trans.trans_id.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              InputDatePickerFormField(
                  fieldLabelText: 'Fecha 1',
                  initialDate: DateTime.now(),
                  onDateSaved: (value) => {_fechaUno = value.toString()},
                  firstDate: DateTime(2021, 1, 1),
                  lastDate: DateTime(2060, 1, 01)),
              const SizedBox(height: 10),
              InputDatePickerFormField(
                  fieldLabelText: 'Fecha 2',
                  initialDate: DateTime.now(),
                  onDateSaved: (value) => {_fechaDos = value.toString()},
                  firstDate: DateTime(2021, 1, 1),
                  lastDate: DateTime(2060, 1, 01)),
              const SizedBox(height: 10),
              FormBuilderDropdown(
                onSaved: (value) => _usario = value as String,
                decoration: const InputDecoration(labelText: 'Empleado/a'),
                initialValue: 'Isaac',
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
                        child: Text("$quien", textAlign: TextAlign.center)))
                    .toList(),
                name: 'quien',
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: this.widget.trans.cliente,
                decoration: const InputDecoration(
                  labelText: 'Cliente',
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                validator: (userName) {
                  if (userName!.isEmpty) {
                    return 'El nombre del cliente es obligatorio';
                  }
                  return null;
                },
                onSaved: (cliente) {
                  _cliente = cliente!;
                },
                autofocus: true,
                focusNode: nameFocusNode,
                textInputAction: TextInputAction.next,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(nameFocusNode);
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Ciudad',
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                validator: (city) {
                  if (city!.isEmpty) {
                    return 'El nombre de la ciudad es obligatorio';
                  }
                  return null;
                },
                onSaved: (ciudad) {
                  _ciudad = ciudad!;
                },
                autofocus: true,
                focusNode: ciudadFocusNode,
                textInputAction: TextInputAction.next,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(ciudadFocusNode);
                },
              ),
              const SizedBox(height: 10),
              FormBuilderDropdown(
                initialValue: "Carro",
                onSaved: (value) => _transporte = value as String,
                decoration: const InputDecoration(
                  labelText: 'Medio de Transporte',
                ),
                items: ['Carro', 'Avion']
                    .map((medio) => DropdownMenuItem(
                        value: medio,
                        child: Text("$medio", textAlign: TextAlign.center)))
                    .toList(),
                name: 'medio',
              ),
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
                        onPressed: () => Navigator.push(
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
          // confirmationDialog(context, "Estas seguro ?",
          //     title: "Confirmacion",
          //     // confirmationText: "Click here to confirmar",
          //     positiveText: "Registrar", positiveAction: () {
          //       _validateInputs();
          //     });
          Container();
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
      Navigator.pop(context);
    }
  }
}

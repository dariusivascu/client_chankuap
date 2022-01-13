import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/src/provider.dart';

import '../data_lists/Products.dart';
import '../Widgets/data_object.dart';

import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../globals.dart';

class StepperPage extends StatefulWidget {
  StepperPage({Key? key, productos}) : super(key: key);

  List<Producto> productos = [];

  @override
  _StepperPageState createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  final _formKey = GlobalKey<FormState>();
  int currentStep = 0;

  final LoteFocusNode = FocusNode();
  final CantidadFocusNode = FocusNode();
  final PrecioFocusNode = FocusNode();
  final TextEditingController _typeAheadController = TextEditingController();

  late int id;
  String name = "";
  late double cantidad;
  int unidad = 0;
  String precio = "";
  String organico = "";
  String comunidad = "";
  late List<Step> steps;

  @override
  void initState() {
    _buildSteps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            backgroundColor: Color(0xff073B3A),
            middle: Text('Anadir Materia Prima',
                style: TextStyle(color: Color(0xff073B3A))),
          ),
          child: SafeArea(
            child: OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                switch (orientation) {
                  case Orientation.portrait:
                    return _buildStepper(StepperType.vertical);
                  case Orientation.landscape:
                    return _buildStepper(StepperType.horizontal);
                  default:
                    throw UnimplementedError(orientation.toString());
                }
              },
            ),
          ),
        ));
  }

  CupertinoStepper _buildStepper(StepperType type) {
    final canCancel = currentStep > 0;
    return CupertinoStepper(
        type: type,
        steps: _buildSteps(),
        currentStep: currentStep,
        onStepTapped: (step) => setState(() => currentStep = step),
        onStepCancel: canCancel ? () => setState(() => --currentStep) : null,
        onStepContinue: () {
          setState(() {
            if (currentStep < 0)
              currentStep++;
            else
              _registerMateria();
          });
        });
  }

  Widget _buildStep() {
    return Scaffold(
        body: SafeArea(
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TypeAheadFormField(
                    onSaved: (value) => this.name = value ?? "",
                    validator: (val) {
                      if (val!.isEmpty)
                        return 'El nombre de producto no '
                            'es bueno';
                      return null;
                    },
                    textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      controller: this._typeAheadController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre de Producto',
                      ),
                    ),
                    // ignore: missing_return
                    suggestionsCallback: (pattern) async {
                      return await Products.getSuggestions(pattern);
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion as String),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController.text = suggestion as String;
                    },
                  ),
                  FormBuilderDropdown(
                    decoration: const InputDecoration(
                        labelText: 'Organico / Convencional'),
                    initialValue: "Organico",
                    onSaved: (value) => {
                      if (value == 'Organico') organico = "O",
                      if (value == 'Convencional') organico = "C"
                    },
                    items: ['Organico', 'Convencional']
                        .map((quien) => DropdownMenuItem(
                            value: quien,
                            child: Text("$quien", textAlign: TextAlign.left)))
                        .toList(),
                    name: 'quien',
                  ),
                  // FormBuilderDropdown(
                  //   decoration: const InputDecoration(labelText: 'Comunidad'),
                  //   initialValue: "Shuar",
                  //   onSaved: (value) => {
                  //     if (value == 'Shuar') comunidad = "SH",
                  //     if (value == 'Achuar') comunidad = "ACH"
                  //   },
                  //   items: ['Shuar', 'Achuar']
                  //       .map((comu) => DropdownMenuItem(
                  //           value: comu,
                  //           child: Text("$comu", textAlign: TextAlign.left)))
                  //       .toList(),
                  //   name: 'comunidad',
                  // ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Cantidad',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(15)],
                    onSaved: (canti) {
                      cantidad = double.parse(canti.toString());
                    },
                    // ignore: missing_return
                    validator: (val) {
                      if (val!.isEmpty) return 'Pone una cantidad';
                      return null;
                    },
                    autofocus: true,
                    focusNode: CantidadFocusNode,
                    textInputAction: TextInputAction.next,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(CantidadFocusNode);
                    },
                  ),
                  FormBuilderDropdown(
                    onSaved: (uni) => unidad = _unidadToInt(uni as String),
                    decoration: const InputDecoration(labelText: 'Unidad'),
                    initialValue: 'g',
                    //initialValue: 1,
                    items: ['g', 'kg', 'lb', 'ml', 'L', 'u']
                        //items: [1,2,3]
                        .map((unidad) => DropdownMenuItem(
                            value: unidad,
                            child:
                                Text("$unidad", textAlign: TextAlign.center)))
                        .toList(),
                    name: 'unidad',
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Precio',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(15)],
                    onSaved: (price) {
                      precio = price!;
                    },
                    validator: (val) {
                      if (val!.isEmpty) return 'Necesitas un precio';
                      return null;
                    },
                    initialValue: '${this.precio}',
                    autofocus: true,
                    focusNode: PrecioFocusNode,
                    textInputAction: TextInputAction.next,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(PrecioFocusNode);
                    },
                  ),
                ]))));
  }

  _buildSteps() {
    return <Step>[
      Step(
          title: Text("Producto", style: TextStyle(color: Color(0xff073B3A))),
          subtitle: Text('Selecionar nombre y codigo'),
          content:
              LimitedBox(maxWidth: 300, maxHeight: 500, child: _buildStep())),
    ];
  }

  _registerMateria() {
    if (_formKey.currentState!.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState!.save();

      try {
        var price = int.parse(precio);

        /// todo schimba id aici sa nu fie FAKE

        List<Producto> materias =
            context.read<MateriasProvider>().materiasPrimas;
        materias.add(
            Producto(1, name, cantidad, unidad, price, organico, comunidad));

        context.read<MateriasProvider>().materiasPrimas = materias;

        Navigator.pop(context);
      } on FormatException {
        print('Format error!');
      }
    }
  }

  _unidadToInt(String uni) {
    switch (uni) {
      case 'g':
        return 0;
      case 'kg':
        return 1;
      case 'lb':
        return 2;
      case 'ml':
        return 3;
      case 'L':
        return 4;
      case 'u':
        return 5;
    }
  }
}

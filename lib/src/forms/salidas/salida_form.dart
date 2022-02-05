import 'package:client_chankuap/src/Widgets/data_object.dart';
import 'package:client_chankuap/src/Widgets/selectMaterial.dart';
import 'package:client_chankuap/src/app_bars/form_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../product_list_form.dart';

class SalidaForm extends StatefulWidget {
  SalidaForm({Key? key, required this.trans, required this.salidaTrans})
      : super(key: key);

  final SalidaOverview trans;
  final SalidaTrans salidaTrans;

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
              TextFormField(
                style: const TextStyle(color: Color(0xff073B3A)),
                decoration: const InputDecoration(labelText: 'Fecha 1'),
                initialValue: widget.salidaTrans.fecha_uno,
                enabled: false,
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: Color(0xff073B3A)),
                decoration: const InputDecoration(labelText: 'Fecha 2'),
                initialValue: widget.salidaTrans.fecha_dos,
                enabled: false,
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: Color(0xff073B3A)),
                decoration: const InputDecoration(labelText: 'Empleado/a'),
                initialValue: _intToName(widget.salidaTrans.quien),
                enabled: false,
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: Color(0xff073B3A)),
                decoration: const InputDecoration(labelText: 'Cliente'),
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                initialValue: widget.salidaTrans.cliente,
                enabled: false,
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: Color(0xff073B3A)),
                decoration: const InputDecoration(labelText: 'Ciudad'),
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                initialValue: widget.salidaTrans.ciudad,
                enabled: false,
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Expanded(
                    flex: 8,
                    child: Text("Materias Primas",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18)),
                  ),
                  // Expanded(
                  //   flex: 2,
                  //   child: IconButton(
                  //       iconSize: 20,
                  //       icon: const Icon(Icons.add),
                  //       onPressed: () => Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => stepperPage),
                  //           )),
                  // )
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // confirmationDialog(context, "Estas seguro ?",
      //     //     title: "Confirmacion",
      //     //     // confirmationText: "Click here to confirmar",
      //     //     positiveText: "Registrar", positiveAction: () {
      //     //       _validateInputs();
      //     //     });
      //     Container();
      //   },
      //   child: const Icon(Icons.add),
      //   backgroundColor: const Color(0xff073B3A),
      // ),
    );
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
//   void _validateInputs() {
//     if (_fbkey.currentState!.validate()) {
// //    If all data are correct then save data to out variables
//       _fbkey.currentState!.save();
//       Navigator.pop(context);
//     }
//   }
}

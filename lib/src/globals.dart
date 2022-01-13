library my_prj.globals;

import 'package:client_chankuap/src/Widgets/data_object.dart';
import 'package:flutter/cupertino.dart';

List<Producto> materias = [];

class MateriasProvider with ChangeNotifier {
  List<Producto> _materiasPrimas = [];

  List<Producto> get materiasPrimas => _materiasPrimas;

  set materiasPrimas(List<Producto> value) {
    _materiasPrimas = value;
    notifyListeners();
  }
}
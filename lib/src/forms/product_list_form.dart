import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/data_object.dart';
import '../globals.dart';

class ProductListForm extends StatefulWidget {
  List<Producto> materiasPrimas = [];

  ProductListForm({Key? key, materiasPrimas}) : super(key: key);

  @override
  _ProductListFormState createState() => _ProductListFormState();
}

class _ProductListFormState extends State<ProductListForm> {
  late MateriasProvider materiasProvider;

  late Producto product;
  String name = "Me";
  String lote = "Loe";
  int can = 10;
  int uni = 1;
  double precio = 15;

  @override
  void initState() {
    super.initState();
  }

  int k = 1;

  // updateMaterias(){
  //   widget.materiasPrimas = materiasProvider.materiasPrimas;
  //   setState(() {
  //     k = 0;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // materiasProvider = Provider.of<MateriasProvider>(context);
    //
    // if(k!= 0) updateMaterias();

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: context.watch<MateriasProvider>().materiasPrimas.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 60,
          color: const Color(0xffEFEFEF),
          child: _buildProductBox(context, index),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  _intToUnidad(int value) {
    switch (value) {
      case 0:
        return 'g';
      case 1:
        return 'kg';
      case 2:
        return 'lb';
      case 3:
        return 'ml';
      case 4:
        return 'L';
      case 5:
        return 'u';
    }
  }

  Widget _buildProductBox(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: const Color(0xff073B3A))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context
                          .watch<MateriasProvider>()
                          .materiasPrimas[index]
                          .name,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      context
                          .watch<MateriasProvider>()
                          .materiasPrimas[index].organico,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' ${context.watch<MateriasProvider>().materiasPrimas[index].cantidad} ' +
                          ' ${_intToUnidad(context.watch<MateriasProvider>().materiasPrimas[index].unidad)}',
                      textAlign: TextAlign.right,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      'Precio: ${context.watch<MateriasProvider>().materiasPrimas[index].precio}\$',
                      textAlign: TextAlign.right,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: IconButton(
                  iconSize: 20,
                  icon: const Icon(Icons.do_not_disturb_on_outlined),
                  onPressed: () {
                    setState(() {
                      context
                          .read<MateriasProvider>()
                          .materiasPrimas
                          .removeAt(index);
                    });
                  },
                ),
              ),
            ]),
      ),
    );
  }
}

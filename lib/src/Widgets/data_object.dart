import 'package:client_chankuap/src/Widgets/TransactionType.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class EntradaTrans {
  final String fecha_uno;
  final String fecha_dos;
  final int quien;
  final String productor;
  final String p_code;
  final String ID;
  final String comunidad;
  final String zona;
  final List<Producto> lotes;



  EntradaTrans(this.fecha_uno, this.fecha_dos, this.quien, this.productor,
      this.p_code, this.ID, this.comunidad, this.zona, this.lotes);

  EntradaTrans.fromJson(Map<String, dynamic> json)
      : fecha_uno = json['date'],
        fecha_dos = json['fecha2'],
        quien = json['quien'],
        ID = json['PROVIDER_ID'],
        comunidad = json['comunidad'],
        productor = json['productor'],
        p_code = json['p_code'],
        zona = json['zona'],
        lotes = json['products'].map((e) => Producto.fromJson(e)).toList().cast<Producto>();

  Map<String, dynamic> toJson() => {
    "date": fecha_uno,
    "fecha2": fecha_dos,
    "quien": quien,
    "PROVIDER_ID": ID,
    "products": lotes.map((e) => e.toJson()).toList(),
    "comunidad": comunidad,
    "productor": productor,
    "p_code": p_code,
    "zona": zona,
  };
}

@JsonSerializable()
class SalidaTrans {
  final String cliente;
  final int quien;
  final String fecha_uno;
  final String fecha_dos;
  final String ciudad;
  final List<Producto> lotes;

  SalidaTrans(this.cliente, this.quien, this.fecha_uno, this.fecha_dos, this.ciudad, this.lotes);

  SalidaTrans.fromJson(Map<String, dynamic> json)
      : fecha_uno = json['date'],
        fecha_dos = json['fecha2'],
        quien = json['quien'],
        cliente = json['cliente'],
        ciudad = json['ciudad'],
        lotes = json['products'].map((e) => Producto.fromJson(e)).toList().cast<Producto>();

  Map<String, dynamic> toJson() => {
    "date": fecha_uno,
    "fecha2": fecha_dos,
    "quien": quien,
    "cliente": cliente,
    "ciudad": ciudad,
    "products": lotes.map((e) => e.toJson()).toList(),
  };
}

class Producto {
  final int id;
  final double cantidad;
  final int unidad;
  final double precio;
  final String organico;
  final String comb_id;
  final String name;

  List<Map<String, dynamic>> ListProducts = [];

  Producto(this.id, this.name,
      this.cantidad, this.unidad, this.precio, this.organico):
        this.comb_id = 'M';

  Producto.fromJson(Map<String, dynamic> json) :
        id = json['PRODUCT_ID'],
        comb_id = json['COMB_ID'],
        name = json['Name'],
        cantidad = double.parse(json['quantity'].toString()),
        unidad = json['unit'],
        precio = double.parse(json['price'].toString()),
        organico = json['organico'];


  Map<String, dynamic> toJson() => {
    "PRODUCT_ID": id,
    "COMB_ID": 'M',
    "quantity": cantidad,
    "Name": name,
    "unit": unidad,
    "price": precio,
    "organico": organico,
  };

  dynamic toJsonList(List<Producto> listToParse){
    ListProducts = [];

    for(Producto product in listToParse){
      ListProducts.add(product.toJson());
    }
    return ListProducts;
  }

  // getNumeroLote() {
  //   return name + comunidad + organico + '$id' + DateFormat(
  //       'ddMMyyyy').format(DateTime.now());
  // }
}

@JsonSerializable()
class ListEntradaOverviews {

  final List<EntradaOverview> ListEntradas;

  ListEntradaOverviews.fromJson(Map<String, dynamic> json) :
        ListEntradas = json['overviews'].toJsonList;

  Map<String, dynamic> toJson() => {
    "overviews": ListEntradas.map((e) => e.toJson()).toList(),
  };

  ListEntradaOverviews(this.ListEntradas);
}

@JsonSerializable()
class EntradaOverview extends TransactionType {

  final int trans_id;
  final String date;
  // final int username;
  final String provider_id;
  final String nombre_cliente;

  List<Map<String, dynamic>> ListEntradas = [];

  EntradaOverview.fromJson(Map<String, dynamic> json) :
        trans_id = json['TRANS_ID'],
        date = json['date'],
        provider_id = json['PROVIDER_ID'],
        nombre_cliente = json['productor'];

  Map<String, dynamic> toJson() => {
    "TRANS_ID": trans_id,
    "date": date,
    "PROVIDER_ID": provider_id,
    "productor": nombre_cliente
  };

  dynamic toJsonList(List<EntradaOverview> listToParse){
    ListEntradas = [];
    for(EntradaOverview entrada in listToParse){
      ListEntradas.add(entrada.toJson());
    }
    return ListEntradas;

  }

  EntradaOverview(this.trans_id, this.date, this.provider_id, this.nombre_cliente);
}


@JsonSerializable()
class ListSalidaOverviews {

  final List<SalidaOverview> ListSalidas;

  ListSalidaOverviews.fromJson(Map<String, dynamic> json) :
        ListSalidas = json['overviews'];

  Map<String, dynamic> toJson() => {
    "overviews": ListSalidas.map((e) => e.toJson()).toList(),
  };

  ListSalidaOverviews(this.ListSalidas);
}

class SalidaOverview extends TransactionType {

  final int trans_id;
  final String cliente;
  final String date;

  List<Map<String, dynamic>> ListSalidas = [];

  SalidaOverview.fromJson(Map<String, dynamic> json) :
        trans_id = json['TRANS_OUT_ID'],
        date = json['date'],
        cliente = json['cliente'];

  Map<String, dynamic> toJson() => {
    "TRANS_OUT_ID": trans_id,
    "date": date,
    "PROVIDER_ID": cliente
  };

  getId() {
    return this.trans_id;
  }

  dynamic toJsonList(List<SalidaOverview> listToParse){
    ListSalidas = [];

    for(SalidaOverview salida in listToParse){
      ListSalidas.add(salida.toJson());
    }
    return ListSalidas;
  }

  SalidaOverview(this.trans_id, this.cliente, this.date);
}


class SendEntrada {
  final String fecha;
  final String name;
  final String ID;
  final List<Producto> productos;

  SendEntrada(this.fecha, this.name, this.ID, this.productos);
}
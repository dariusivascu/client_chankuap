import 'package:client_chankuap/src/Widgets/app_icons.dart';
import 'package:client_chankuap/src/globals.dart';
import 'package:client_chankuap/src/pages/Export.dart';
import 'package:client_chankuap/src/pages/login.dart';
import 'package:client_chankuap/src/pages/profile.dart';
import 'package:client_chankuap/src/pages/transactions.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MateriasProvider>(
            create: (_) => MateriasProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wakerakka',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title, this.username}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;
  final String? username;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pageIndex = 0;
  final Transactions tran = Transactions();
  final Export exp = Export();
  late Profile prof = Profile(
    name: widget.username,
  );

  Widget _showPage = Transactions();

  // Widget _pageChooser(int page) {
  //   switch (page) {
  //     case 0:
  //       return tran;
  //       break;
  //   // case 1:
  //   //   return exp;
  //   //   break;
  //     case 2:
  //       return prof;
  //       break;
  //     default:
  //       return tran;
  //   }
  // }

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return tran;
      case 1:
        return exp;
      case 2:
        return prof;
      default:
        return tran;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: _showPage,
      )),
      bottomNavigationBar: CurvedNavigationBar(
        index: _pageIndex,
        color: const Color(0xff073B3A),
        backgroundColor: const Color(0xffEFEFEF),
        buttonBackgroundColor: const Color(0xff073B3A),
        height: 50,
        items: const <Widget>[
          Icon(AppIcons.transaction, size: 25, color: Colors.white),
          Icon(AppIcons.storage, size: 25, color: Colors.white),
          Icon(AppIcons.entry, size: 25, color: Colors.white),
        ],
        animationDuration: const Duration(milliseconds: 200),
        onTap: (int tappedIndex) {
          _pageIndex = tappedIndex;
          setState(() {
            _showPage = _pageChooser(tappedIndex);
          });
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class Profile extends StatelessWidget {
  final String? name;
  Profile({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            title: const Text("Profile"),
            centerTitle: true,
            backgroundColor: const Color(0xff073B3A),
          ),
        ),
        body: Container(
          color: const Color(0xffEFEFEF),
          child: Stack(
            children: [
              const Align(
                  alignment: Alignment(0, -0.6),
                  child: const Icon(
                    Icons.person,
                    size: 96,
                    color: Color(0xff0F956A),
                  )
              ),
              Align(
                alignment: const Alignment(0, -0.3),
                child: Container(
                  child: Text(name == null ? "no user connected" : name!,
                    textScaleFactor: 2,
                  ),
                ),
              ),
              Align(
                  alignment: const Alignment(0, 0.4),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        side: const BorderSide(color: const Color(0xff073B3A))
                    ),
                    onPressed: () => _logout(context),
                    splashColor: Colors.grey,
                    child: Container(
                      height:  MediaQuery.of(context).size.height / 12,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Stack(
                        children: const <Widget>[
                          Align(
                            alignment: Alignment(-0.2, 0),
                            child: Text("Log Out",
                                style: TextStyle(color: Color(0xff073B3A))),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.add, color: Color(0xff073B3A)),
                          )
                        ],
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  _logout(context) {
    Route route = MaterialPageRoute(builder: (context) => LoginScreen());
    Navigator.pushReplacement(context, route);
  }
}

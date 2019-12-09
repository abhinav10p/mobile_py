import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_py/src/controller.dart' show Page2;
import 'package:mobile_py/localization/localizations.dart';


var page = new Page2();

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    final userField = TextField(
      obscureText: false,
      style:  TextStyle(
          fontFamily: 'Montserrat',
          backgroundColor: Colors.white24,
          fontSize: 15.0,
          color: Colors.white),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      obscureText: true,
      style: TextStyle(
          fontFamily: 'Montserrat',
          backgroundColor: Colors.white24,
          fontSize: 15.0,
          color: Colors.white),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        //padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          page.loginNavigate(context);
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
    );
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("./assets/dgg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 200.0,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                /* Image.asset(
                              "./assets/gtmslg1.png",
                              height: 133,
                              fit: BoxFit.fitHeight,
                            ),*/
                                Text("Dex Chat",
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 50,
                                        fontStyle: FontStyle.normal,
                                        backgroundColor: Colors.transparent,
                                        color: Colors.white.withOpacity(0.8))),
                              ])),
                      SizedBox(
                        height: 45.0,
                      ),
                      userField,
                      SizedBox(
                        height: 25.0,
                      ),
                      passwordField,
                      SizedBox(
                        height: 35.0,
                      ),
                      loginButon,
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

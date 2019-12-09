import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:mobile_py/src/model/API.dart';
import 'package:mobile_py/src/model/User.dart' show User;
import 'package:data_tables/data_tables.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mobile_py/src/model/desert.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;
import 'package:toast/toast.dart';
import 'package:mobile_py/src/model/DB/ClientModel.dart' show Client;
import 'package:mobile_py/src/model/DB/Database.dart';
import 'package:mobile_py/src/view/home/widgets/contacts_list.dart' show MyListScreen;
import 'package:mobile_py/src/view/home/widgets/recent_chats.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SecondPage extends StatelessWidget {
  final String data;

  SecondPage(
      {Key key, @required this.data, this.text, this.animationController})
      : super(key: key);
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          //backgroundColor: Colors.blueGrey,
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.chat_bubble_outline)),
                Tab(icon: Icon(Icons.contacts)),
              ],
            ),
            centerTitle: false,
            title: Text('Dex Chat'),
          ),
          body: TabBarView(
            children: [
              Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          //FavoriteContacts(),
                          RecentChats(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              MyListScreen(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
            },
            child: Icon(Icons.chat),
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    dialogContent(BuildContext context) {
      return Stack(
        children: <Widget>[
          //...bottom card part,
          //...top circlular image part,
        ],
      );
    }

    var Consts;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

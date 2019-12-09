import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_py/src/model/API.dart';
import 'package:mobile_py/src/model/DB/ClientModel.dart';
import 'package:mobile_py/src/model/DB/Database.dart';
import 'package:toast/toast.dart';
import 'package:async_loader/async_loader.dart';

final GlobalKey<AsyncLoaderState> asyncLoaderState =
new GlobalKey<AsyncLoaderState>();

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

var users = new List<Client>();

class _MyListScreenState extends State {
  _getUsers() async {
    var oUsers = await API.getUsers();
    var clients = await json.decode(oUsers.body);
    Iterable list = clients;
    users = list.map((model) => Client.fromJson(model)).toList();
    setState(() {});
    /*
    var allClients = await DBProvider.db.getAllClients();
    if (allClients.length > 0) {
      await DBProvider.db.deleteAll();
      await insertDb(clients);
      Iterable allClient = await DBProvider.db.getAllClients();
      users = allClient.map((model) => Client.fromJson(model)).toList();
    } else {
      await insertDb(clients);
      Iterable allClient = await DBProvider.db.getAllClients();
      users = allClient.map((model) => Client.fromJson(model)).toList();
    }*/
  }

  insertDb(clients) async {
    for (var i = 0; i < clients.length; i++) {
      var oClients = new Client();
      oClients.firstName = clients[i]['FirstName'];
      oClients.phone = clients[i]['Phone'];
      oClients.lastName = clients[i]['LastName'];
      oClients.country = clients[i]['Country']['Img'];
      oClients.avatar = clients[i]['Avatar'];
      oClients.description = clients[i]['Description'];
      await DBProvider.db.newClient(oClients);
    }
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  Widget getListView(){
    return new ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${users[index].firstName} ${users[index].lastName}'),
          leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              DetailApi.getDetails('${users[index].id}').then((response) {
                var oJson = json.decode(response.body);
                Toast.show('${oJson.id}', context,
                    backgroundColor: Colors.deepOrange,
                    duration: Toast.LENGTH_SHORT,
                    gravity: Toast.BOTTOM);
              });
            },
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  '${users[index].avatar}'), // no matter how big it is, it won't overflow
            ),
          ),
          subtitle: Text(
            '${users[index].description}',
            style: TextStyle(
                backgroundColor: Colors.blue,
                color: Colors.white.withOpacity(0.8)),
          ),
          trailing: CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(
                '${users[index].country}'), // no matter how big it is, it won't overflow
          ),
          isThreeLine: false,
          onTap: () {
            Toast.show('${users[index].id}', context,
                backgroundColor: Colors.deepOrange,
                duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM);
          },
          onLongPress: () async {
            var details = await DetailApi.getDetails('${users[index].id}');

            Toast.show(details.body, context,
                backgroundColor: Colors.deepOrange,
                duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM);
          },
        );
      },
    );
  }

  @override
  Widget build(context) {

    var _asyncLoader = new AsyncLoader(
      key: asyncLoaderState,
      initState: () async => await users,
      renderLoad: () => Center(child: new CircularProgressIndicator()),
      renderError: ([error]) => null,
      renderSuccess: ({data}) => getListView(),
    );

    return Scaffold(
        body:
        new Center(child: _asyncLoader));
        /* ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${users[index].firstName} ${users[index].lastName}'),
          leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              DetailApi.getDetails('${users[index].id}').then((response) {
                var oJson = json.decode(response.body);
                Toast.show('${oJson.id}', context,
                    backgroundColor: Colors.deepOrange,
                    duration: Toast.LENGTH_SHORT,
                    gravity: Toast.BOTTOM);
              });
            },
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  '${users[index].avatar}'), // no matter how big it is, it won't overflow
            ),
          ),
          subtitle: Text(
            '${users[index].description}',
            style: TextStyle(
                backgroundColor: Colors.blue,
                color: Colors.white.withOpacity(0.8)),
          ),
          trailing: CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(
                '${users[index].country}'), // no matter how big it is, it won't overflow
          ),
          isThreeLine: false,
          onTap: () {
            Toast.show('${users[index].id}', context,
                backgroundColor: Colors.deepOrange,
                duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM);
          },
          onLongPress: () async {
            var details = await DetailApi.getDetails('${users[index].id}');

            Toast.show(details.body, context,
                backgroundColor: Colors.deepOrange,
                duration: Toast.LENGTH_SHORT,
                gravity: Toast.BOTTOM);
          },
        );
      },
    ));*/
  }
}

/* build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Flutter SQLite")),
      body: FutureBuilder<List<Client>>(
        future: DBProvider.db.getAllClients(),
        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Client item = snapshot.data[index];
                return ListTile(
                  title: Text(item.firstName),
                  leading: Text(item.lastName),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }*/

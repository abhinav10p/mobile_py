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
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.contacts),
                ),
                Tab(icon: Icon(Icons.chat)),
              ],
            ),
            centerTitle: true,
            title: Text('Dex Chat'),
          ),
          body: TabBarView(
            children: [
              MyListScreen(),
              Text("Hellow"),
//              TableWidget(),
//              MyListScreen1(),
              // TableWidget(),
            ],
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

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State {
  var users = new List<Client>();

  _getUsers() async {
    var oUsers = await API.getUsers();

    var clients = await json.decode(oUsers.body);

    //var allClients = await DBProvider.db.getAllClients();
    Iterable list = clients;
    users = list.map((model) => Client.fromJson(model)).toList();

    /*if (allClients.length > 0) {
      await DBProvider.db.deleteAll();
      await insertDb(clients);
      Iterable allClient = await DBProvider.db.getAllClients();
      users = allClient.map((model) => Client.fromJson(model)).toList();
    } else {
      await insertDb(clients);
      Iterable allClient = await DBProvider.db.getAllClients();
      users = allClient.map((model) => Client.fromJson(model)).toList();
    }*/

    setState(() {});
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

  @override
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

  build(context) {
    return Scaffold(
        body: ListView.builder(
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
                    /*       showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('${oJson['Avatar']}'),
                        backgroundColor: Colors.transparent,
                        content: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              '${oJson['Avatar']}'), // no matter how big it is, it won't overflow
                        ),
                      );
                    });*/
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
        ));
  }
}

/*class MyListScreen1 extends StatefulWidget {
  @override
  createState() => _MyAppState();
}

class _MyAppState extends State {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    _items = _desserts;
    super.initState();
  }

  void _sort<T>(
      Comparable<T> getField(Dessert d), int columnIndex, bool ascending) {
    _items.sort((Dessert a, Dessert b) {
      if (!ascending) {
        final Dessert c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  List<Dessert> _items = [];
  int _rowsOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NativeDataTable.builder(
        rowsPerPage: _rowsPerPage,
        itemCount: _items?.length ?? 0,
        firstRowIndex: _rowsOffset,
        */ /* handleNext: () async {
            setState(() {
              _rowsOffset += _rowsPerPage;
            });

            await new Future.delayed(new Duration(seconds: 3));
            setState(() {
              _items += [
                Dessert('New Item 4', 159, 6.0, 24, 4.0, 87, 14, 1),
              ];
            });
          },
          handlePrevious: () {
            setState(() {
              _rowsOffset -= _rowsPerPage;
            });
          },*/ /*
        itemBuilder: (int index) {
          final Dessert dessert = _items[index];
          return DataRow.byIndex(
              index: index,
              selected: dessert.selected,
              onSelectChanged: (bool value) {
                if (dessert.selected != value) {
                  setState(() {
                    dessert.selected = value;
                  });
                }
              },
              cells: <DataCell>[
                DataCell(Text('${dessert.name}')),
                DataCell(Text('${dessert.calories}')),
                DataCell(Text('${dessert.fat.toStringAsFixed(1)}')),
                DataCell(Text('${dessert.carbs}')),
                DataCell(Text('${dessert.protein.toStringAsFixed(1)}')),
                DataCell(Text('${dessert.sodium}')),
                DataCell(Text('${dessert.calcium}%')),
                DataCell(Text('${dessert.iron}%')),
                DataCell(ButtonBar(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _items.remove(dessert);
                        });
                      },
                    ),
                  ],
                )),
              ]);
        },
        header: const Text('Data Management'),
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        onRefresh: () async {
          await new Future.delayed(new Duration(seconds: 3));
          setState(() {
            _items = _desserts;
          });
          return null;
        },
        onRowsPerPageChanged: (int value) {
          setState(() {
            _rowsPerPage = value;
          });
          print("New Rows: $value");
        },
        */ /*  mobileItemBuilder: (BuildContext context, int index) {
            final i = _desserts[index];
            return ListTile(
              title: Text(i?.name),
            );
          },*/ /*
        onSelectAll: (bool value) {
          for (var row in _items) {
            setState(() {
              row.selected = value;
            });
          }
        },
        rowCountApproximate: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {},
          ),
        ],
        selectedActions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                for (var item in _items
                    ?.where((d) => d?.selected ?? false)
                    ?.toSet()
                    ?.toList()) {
                  _items.remove(item);
                }
              });
            },
          ),
        ],
        mobileIsLoading: CircularProgressIndicator(),
        noItems: Text("No Items Found"),
        columns: <DataColumn>[
          DataColumn(
              label: const Text('Dessert (100g serving)'),
              onSort: (int columnIndex, bool ascending) =>
                  _sort<String>((Dessert d) => d.name, columnIndex, ascending)),
          DataColumn(
              label: const Text('Calories'),
              tooltip:
                  'The total amount of food energy in the given serving size.',
              numeric: true,
              onSort: (int columnIndex, bool ascending) => _sort<num>(
                  (Dessert d) => d.calories, columnIndex, ascending)),
          DataColumn(
              label: const Text('Fat (g)'),
              numeric: true,
              onSort: (int columnIndex, bool ascending) =>
                  _sort<num>((Dessert d) => d.fat, columnIndex, ascending)),
          DataColumn(
              label: const Text('Carbs (g)'),
              numeric: true,
              onSort: (int columnIndex, bool ascending) =>
                  _sort<num>((Dessert d) => d.carbs, columnIndex, ascending)),
          DataColumn(
              label: const Text('Protein (g)'),
              numeric: true,
              onSort: (int columnIndex, bool ascending) =>
                  _sort<num>((Dessert d) => d.protein, columnIndex, ascending)),
          DataColumn(
              label: const Text('Sodium (mg)'),
              numeric: true,
              onSort: (int columnIndex, bool ascending) =>
                  _sort<num>((Dessert d) => d.sodium, columnIndex, ascending)),
          DataColumn(
              label: const Text('Calcium (%)'),
              tooltip:
                  'The amount of calcium as a percentage of the recommended daily amount.',
              numeric: true,
              onSort: (int columnIndex, bool ascending) =>
                  _sort<num>((Dessert d) => d.calcium, columnIndex, ascending)),
          DataColumn(
              label: const Text('Iron (%)'),
              numeric: true,
              onSort: (int columnIndex, bool ascending) =>
                  _sort<num>((Dessert d) => d.iron, columnIndex, ascending)),
          DataColumn(
            label: const Text('Actions'),
          ),
        ],
      ),
    );
  }

  final List<Dessert> _desserts = <Dessert>[
    Dessert('Frozen yogurt', 159, 6.0, 24, 4.0, 87, 14, 1),
    Dessert('Ice cream sandwich', 237, 9.0, 37, 4.3, 129, 8, 1),
  ];
}

class TableWidget extends StatefulWidget {
  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  bool _isBorderEnabled = false;
  var _actionIcon = Icons.border_all;

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          child: Text(
            'Table Widget',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(_actionIcon),
            onPressed: () => setState(() {
              _isBorderEnabled == false
                  ? _isBorderEnabled = true
                  : _isBorderEnabled = false;

              _isBorderEnabled
                  ? _actionIcon = Icons.sort_by_alpha
                  : _actionIcon = Icons.sort_by_alpha;
            }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 9),
        child: Table(
          border: _isBorderEnabled ? TableBorder.all() : null,
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          columnWidths: {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(6), //- ok as well
            2: FlexColumnWidth(2),
          },
          children: <TableRow>[
            ///First table row with 3 children
            TableRow(children: <Widget>[
              TableCell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 38,
                      backgroundImage: NetworkImage(
                          ""), // no matter how big it is, it won't overflow
                    )
                  ],
                ),
              ),
              TableCell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text("Name"),
                      subtitle: Text("Description"),
                    )
                  ],
                ),
              ),
              TableCell(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        heightFactor: 1,
                        child: CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(
                              "assets/gtmslg1.png"), // no matter how big it is, it won't overflow
                        )),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}*/

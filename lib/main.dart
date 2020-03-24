import 'package:flutter/material.dart';
import 'package:flutterappwithtests/models/record_model.dart';
import 'package:flutterappwithtests/screen/new_record_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'WishList Store'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Record> _records = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.whatshot, color: Colors.orange,),
            onPressed: (){},
          )
        ],
      ),
      body: Container(
        child: _records.length > 0
        ? _buildListView()
        : _buildPlaceholder(),
      ),
      floatingActionButton: FloatingActionButton(
        key: ValueKey('add_button'),
        child: Icon(Icons.add),
        onPressed: () async{
          final record = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewRecordScreen("New Record")));
          setState(() {
            _records.add(record);
          });
        },
      ),
    );
  }

  _buildListView() {
    return ListView.builder(
      itemCount: _records.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          direction: DismissDirection.endToStart,
          background: Container(
            width: double.infinity,
            color: Colors.red,
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.delete)
              ],
            ),
          ),
          key: ValueKey("dismissible_item_$index"),
          onDismissed: (direction) {
            setState(() {
              _records.removeAt(index);
            });
          },
          child: Card(
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.star, color: _records[index].isFavourite ? Colors.yellow : Colors.blueGrey,),
                onPressed: (){
                  setState(() {
                    _records[index].changeFavouriteState();
                  });
                },
              ),
              title: Text(_records[index].title),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {
                  final updatedRecord = await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => NewRecordScreen("New Record", record: _records[index])));
                  setState(() {
                    _records[index] = updatedRecord;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }

  _buildPlaceholder() {
    return Center(
      child: Text("You don't have records yet"),
    );
  }
}

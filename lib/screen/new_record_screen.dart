import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterappwithtests/models/record_model.dart';
import 'package:provider/provider.dart';

class NewRecordScreen extends StatelessWidget {
  final String title;
  final Record record;
  final TextEditingController _controller = TextEditingController();

  NewRecordScreen(this.title, {this.record});

  @override
  Widget build(BuildContext context) {
    if (this.record != null) {
      _controller.text = this.record.title;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => _navigateToPreviousScreen(context,null),
        ),
      ),
      body: Container(
          child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Record title",
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            DropdownButton(
              isDense: true,
              items: <DropdownMenuItem>[
                DropdownMenuItem(
                  child: Row(
                    children: <Widget>[
                      Text("Hight"),
                    ],
                  ),
                  value: "Height",
                ),
                DropdownMenuItem(
                  child: Text("Medium"),
                  value: "Medium",
                ),
                DropdownMenuItem(
                  child: Text("Low"),
                  value: "Low",
                )
              ],
              onChanged: (value) {

              },
              hint: Text("Priority"),
            ),
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              child: Container(
                width: double.infinity,
                child: Center(
                  child: Text('Save Records'),
                ),
              ),
              onPressed: () {
                if (_controller.text != "") {
                  // TODO
                }
                _navigateToPreviousScreen(context, Record(title: _controller.text));
              },
            )
          ],
        ),
      )),
    );
  }

  _navigateToPreviousScreen(BuildContext context, Record record) {
    Navigator.of(context).pop(record);
  }
}

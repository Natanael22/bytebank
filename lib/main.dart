import 'package:flutter/material.dart';

void main() =>  runApp(MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('100,00'),
              subtitle: Text('1234'),
            )
          ),Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('200,00'),
              subtitle: Text('1234'),
            )
          ),
        ],
      ),
      appBar: AppBar(title: Text('Transferencias'),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:  null,
      ),
      ),
    ),
  );




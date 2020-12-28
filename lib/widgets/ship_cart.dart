import 'package:flutter/material.dart';

class ShipCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text('Calcular Frete'),
        leading: Icon(Icons.local_shipping),
        children: [
          Padding(padding: EdgeInsets.all(8.0), child: Card()),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Digite seu CEP',
            ),
            initialValue: '',
            onFieldSubmitted: (text){

            },
          )
        ],
      ),
    );
  }
}

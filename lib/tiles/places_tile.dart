import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlacesTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  PlacesTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100.0,
            child: Image.network(
              snapshot.get('image'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot.get('title'),
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                Text(
                  snapshot.get('address'),
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                onPressed: (){
                  launch("https://www.google.com/maps/search/?api=1&query=${snapshot.get('lat')},"
                      "${snapshot.get('long')}");
                },
                child: Text('Ver no mapa'),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
              ),
              FlatButton(
                onPressed: (){
                  launch("tel:${snapshot.get('phone')}");
                },
                child: Text('Ligar'),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
              )
            ],
          )
        ],
      ),
    );
  }
}

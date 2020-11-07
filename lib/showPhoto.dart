import 'package:flutter/material.dart';
import 'package:flutterstreambuilder/class/photo.dart';

class ShowPhoto extends StatelessWidget {
  Photo photo;
  ShowPhoto({@required this.photo});
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
//            new Container(
//              child: new Image.network(photo.thumbnailUrl),
//            )
            new Container(
              width: 300,
              height: 300,
              child: new Hero( tag: photo.id,child: new CircleAvatar(
                backgroundColor: Colors.grey[600],
                backgroundImage: NetworkImage(photo.thumbnailUrl),
              ),),
            )
          ],
        ),
      ),
    );
  }
}

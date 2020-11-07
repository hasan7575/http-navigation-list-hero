import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstreambuilder/class/photo.dart';
import 'package:flutterstreambuilder/showPhoto.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ShowPhotos extends StatefulWidget {
  @override
  _ShowPhotosState createState() => _ShowPhotosState();
}

class _ShowPhotosState extends State<ShowPhotos> {
  List<Photo> photos = new List();
  bool _loading = true;
  bool internetError=false;

  List myList = [10, 20, 30, 40, 50, 60, 70];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setData();
  }

  @override
  Widget build(BuildContext context) {

    // after setState
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }

    else if(internetError){
      return new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Text('check the internet connection',style: new TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.w700
            ),),
            new MaterialButton(onPressed: (){
              _setData();
            },color: Colors.indigo,child: new Text('try again',style: new TextStyle(color: Colors.white),),)
          ],
        ),
      );
    }
    return new Container(
      child: ListView.builder(
          itemCount: photos.length,
          itemBuilder: (BuildContext context, int index) {
            var photo = photos[index];
            return new Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
              child: new ListTile(
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context){
                    return new ShowPhoto(photo: photo);
                  }));
                },
                title: new Text(
                  photo.title,
                  style: new TextStyle(fontSize: 14),
                ),
                subtitle: new Text(photo.id.toString()),
                leading: new Hero( tag: photo.id,child: new CircleAvatar(
                  backgroundColor: Colors.grey[600],
                  backgroundImage: NetworkImage(photo.thumbnailUrl),
                ),),
              ),
            );
          }),
    );
  }

  void _setData() async {
    setState(() {
      _loading=true;
      internetError=false;
    });
    try{
      var url = 'https://jsonplaceholder.typicode.com/photos';
      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        jsonResponse.forEach((element) {
          photos.add(Photo(data: element));
        });
        setState(() {
          _loading = false;
//          photos=jsonResponse;
        });
      }
    }catch(e){
      setState(() {
        _loading=false;
        internetError=true;
      });
    }




  }
}

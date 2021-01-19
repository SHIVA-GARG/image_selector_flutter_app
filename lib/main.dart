import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "uploader",
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  File imageFile;

  _openGallery (BuildContext context) async{
    // ignore: deprecated_member_use
    imageFile= await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
          // imageFile = picture;
        });

    Navigator.of(context).pop();

  }

  _openCamera(BuildContext context) async{
    // ignore: deprecated_member_use
    imageFile  = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
          // imageFile  = picture;
        });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text("make a choice!"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              new GestureDetector(
                child: Text("Gallery"),
                onTap: (){
                  _openGallery(context);
                },
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                ),
              new GestureDetector(
                child: Text("Camera"),
                onTap: (){
                  _openCamera(context);
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _decideImageView(){
    if(imageFile == null){
      return Text("No selected image");
    }else{
      return Image.file(imageFile,width: 600,height: 600);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               _decideImageView(),
              new RaisedButton(
                child: Text("select image"),
                onPressed: ()=>{
                  _showChoiceDialog(context),
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
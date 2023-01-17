
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyUploadPage extends StatefulWidget {
  const MyUploadPage({Key? key}) : super(key: key);

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {

  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload"),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.upload),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              (_image == null) ?
              GestureDetector(
                onTap: _showPicker,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width,
                  color: Colors.grey.withOpacity(.4),
                  child: Center(
                    child: Icon(Icons.add_a_photo, size: 45),
                  ),
                ),
              ) :
              Stack(
                children: [
                  Image.file(
                    _image!,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: (){
                        setState(() {
                          _image = null;
                        });
                      },
                      icon: Icon(Icons.highlight_remove, color: Colors.black,),
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(){
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Pick Photo"),
                onTap: (){
                  _imgFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text("Take Photo"),
                onTap: (){},
              ),
            ],
          ),
        );
      },
    );
  }

  void _imgFromGallery() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery, imageQuality: 50
    );
    setState(() {
      _image = File(image!.path);
    });
  }

}

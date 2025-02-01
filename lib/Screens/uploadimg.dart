import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
File ? image;
  Future imagePik()async{
  final returnedImage= await ImagePicker().pickImage(source: ImageSource.gallery);
  if (returnedImage==null) return;
  setState(() {
      image =File(returnedImage.path);
  });

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title:const Text('Upload Image'),
        centerTitle: true,
      ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: (){
                imagePik();
              },
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all()
                ),
                child:image != null ? Image.file(image!.absolute) : const Center(child: Icon(Icons.image),),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
        onTap: () {
      // Your action
        },
        borderRadius: BorderRadius.circular(50),
        child: Container(
         // width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      //  shape: BoxShape.circle, // Makes it circular
        gradient:const LinearGradient(
          colors: [Colors.blue, Colors.purple], // Two colors for gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset:const Offset(2, 4), // Adds depth
          ),
        ],
      ),
      child:const Center(
        child: Text("Upload Image", style:TextStyle(color:Colors.white, fontSize: 20) ),
      ),
        ),
      ),
      
        ],
      ),
    ),
    );
  }
}
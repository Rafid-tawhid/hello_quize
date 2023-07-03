import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPicked});
  final void Function(File file) onPicked;


  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  File? _pickedImage;

  Future<void> _pickImage() async {
   final pickedImage= await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 50,maxWidth: 150);
   if(pickedImage==null){
     return;
   }
   setState(() {
     _pickedImage=File(pickedImage.path);
   });

   widget.onPicked(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: _pickedImage!=null?FileImage(_pickedImage!):null,
        ),
        TextButton.icon(onPressed: _pickImage, icon: Icon(Icons.image), label: Text('Add Image'))
      ],
    );
  }
}

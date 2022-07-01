
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text))
  );
}

Future<List<File>> pickImages()async{
  List<File> images = [];

  try {
    var result = await FilePicker.platform.pickFiles(
      // type: FileType.image,
      allowMultiple: true
    );

    if(result != null && result.files.isNotEmpty){
      for(int i=0;i<result.files.length; i++){
        images.add(File(result.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return images;

  
}
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class CompressImage {
  CompressImage._();

  static Future<File> compressImage(File file) async {
    XFile? result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      _reNameFile(file.absolute.path,"jpg"),
      quality: 80, // Set the image quality (0 to 100)
      minHeight: 1024, // Set the minimum height of the compressed image
      minWidth: 1024, // Set the minimum width of the compressed image
      format: CompressFormat.jpeg,
    );
    File newFile = result == null ? file : File(result.path);
    print("file size :    ${file.lengthSync()}");
    print("newFile size : ${newFile.lengthSync()}, lose : ${(100 -(newFile.lengthSync() / file.lengthSync() * 100)).toStringAsFixed(1)}%");
    return newFile;
  }

  static String _reNameFile(String name,String format){
    String basename = name.split('/').last;
    String newName = '${basename.split('.').first}_2' ;
    String path = name.split("/").take(name.split("/").length -1).join("/");

    return "$path/$newName.$format" ;
  }
}


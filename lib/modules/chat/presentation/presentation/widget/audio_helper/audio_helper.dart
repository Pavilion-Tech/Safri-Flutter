import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioHelper
{
  AudioHelper._();
  static AudioHelper audioHelper = AudioHelper._();
 late  FlutterSoundRecorder record ;
  String path = "";
  Future<void> recordVoice()
  async
  {
    record = FlutterSoundRecorder();
     path = "";
     final status = await Permission.microphone.request();
    if (status.isGranted)
    {
      print("granted");
    await  record.openRecorder();
      // Start recording
      var dir = await getApplicationSupportDirectory();
      path = "${dir.path}/audio${DateTime.now()}.aac";
      print("path ================> $path");
      await record.startRecorder(
         toFile: path ,
        codec: Codec.aacADTS,
      ); // by default);

    }else if (status.isDenied) {
      print("noooooootttt");
      // Microphone permission denied
    } else if (status.isPermanentlyDenied) {
      print("openAppSettings");
      await Permission.microphone.request();
      await  record.openRecorder();
      // Start recording
      var dir = await getApplicationSupportDirectory();
      path = "${dir.path}/audio${DateTime.now()}.aac";
      print("path ================> $path");
      await record.startRecorder(
        toFile: path ,
        codec: Codec.aacADTS,
      );
      // Microphone permission permanently denied
      // Open app settings to enable permission manually
      // openAppSettings();
    }
  }


}
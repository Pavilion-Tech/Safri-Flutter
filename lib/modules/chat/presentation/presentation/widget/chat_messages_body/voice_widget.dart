// import 'package:audioplayers/audioplayers.dart';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';


import 'package:flutter/material.dart';

import '../../../../../../shared/styles/colors.dart';
import '../audio_helper/voice_viewer.dart';

class VoiceWidget extends StatefulWidget {
  final String audio;

  final bool isMe;
  bool isPlaying;
  bool isLoading;
  bool isPause;
  VoiceWidget({
    super.key,
    required this.audio,
    required this.isMe,

    this.isPlaying = false,
    this.isLoading = false,
    this.isPause = false,
  });

  @override
  State<VoiceWidget> createState() => _VoiceWidgetState();
}

class _VoiceWidgetState extends State<VoiceWidget> {
  final AudioPlayer player = AudioPlayer();
  Duration position = const Duration();

  // double currentTime = 0.0;

  Duration maxDuration =   Duration.zero;
  @override
  void initState() {
    super.initState();
    print("initStateeeeeeeeeeeeeeeeee ${widget.audio}");

    getMaxDurationFromUrl(widget.audio);

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        widget.isPlaying =state== PlayerState.playing;

      });
    });
    player.onDurationChanged.listen((event) {
      setState(() {
        maxDuration = event ;


      });
    });
    player.onPositionChanged.listen((newPosition) {
      setState(() {

        position = newPosition ;


      });
    });


  }


  @override
  void didUpdateWidget(VoiceWidget  oldWidget) {
    print("oldWidget.audio ${oldWidget.audio}");
    bool update = oldWidget.audio != widget.audio;
    print("update $update");
    if(update)     getMaxDurationFromUrl(widget.audio);

    super.didUpdateWidget(oldWidget);


  }

  Future<Duration?> getMaxDurationFromUrl(String url) async {
   print("getMaxDurationFromUrl");
   try {



      if (widget.audio.contains('http')) {

        await player.setSourceUrl(widget.audio);
      } else {

        // await player.play(DeviceFileSource(widget.audio));
        var file = File(widget.audio);
        Uint8List bytes = file.readAsBytesSync();
        await player.setSourceBytes(bytes);
      }
    }catch(e,s){
      print("$e $s");
   }

    // Get the maximum duration of the audio file.
    maxDuration = (await player.getDuration())!;
     print("duration000");
     print(maxDuration);
     setState(() {

     });


    return maxDuration;
  }


  @override
  Widget build(BuildContext context) {

    return VoiceViewer(

      color:widget.isMe?Theme.of(context).primaryColor:  Colors.blueGrey,

      textStyle:   TextStyle(color: widget.isMe? defaultColor:Color(0xff3B3B3B),fontSize: 9),

      position: position.inSeconds.toDouble(),
      duration: maxDuration.inSeconds.toDouble(),
      isPlaying: widget.isPlaying,
      isLoading: widget.isLoading,
      isPause: widget.isPause,

      onSeekChanged: (value) async {
        // currentTime = value;

        position = Duration(seconds: value.toInt());
        await player.seek(position);
        setState(() {});
      }, //_changeSeek
      onPlayPauseButtonClick: () async {
        // cubit.changeAudioState();

        if (!widget.isPlaying) {
          // cubit.changeAudioState();

          setState(() {
            widget.isPlaying = true;
            widget.isPause = false;
          });

          if (widget.audio.contains('http')) {

            await player.play(UrlSource(widget.audio));
          } else {

            // await player.play(DeviceFileSource(widget.audio));
            var file = File(widget.audio);
            Uint8List bytes = file.readAsBytesSync();
            await player.play(BytesSource(bytes));
          }
          // await player.resume();
          player.onPositionChanged.listen((event) {
            position = event;
            // currentTime = position.inSeconds.toDouble();
            setState(() {});
          });
          player.onPlayerComplete.listen((event) {
            position = const Duration(seconds: 0);
            widget.isPlaying = false;
            widget.isPause = false;
            setState(() {});
          });
        } else {
          setState(() {
            widget.isPause = true;
            widget.isPlaying = false;
          });
          await player.pause();
        }
        // setState(() {});
      },
      isSender: widget.isMe,
    );
  }

  @override
  void dispose() {
    player.dispose();

    super.dispose();
  }
}

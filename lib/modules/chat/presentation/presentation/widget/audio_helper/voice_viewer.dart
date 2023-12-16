
import 'package:flutter/material.dart';
import 'package:safri/shared/styles/colors.dart';


const double BUBBLE_RADIUS_AUDIO = 16;

///basic chat bubble type audio message widget
///
/// [onSeekChanged] double pass function to take actions on seek changes
/// [onPlayPauseButtonClick] void function to handle play pause button click
/// [isPlaying],[isPause] parameters to handle playing state
///[duration] is the duration of the audio message in seconds
///[position is the current position of the audio message playing in seconds
///[isLoading] is the loading state of the audio
///ex:- fetching from internet or loading from local storage
///chat bubble [BorderRadius] can be customized using [bubbleRadius]
///chat bubble color can be customized using [color]
///chat bubble tail can be customized  using [tail]
///message sender can be changed using [isSender]
///[sent],[delivered] and [seen] can be used to display the message state
///chat bubble [TextStyle] can be customized using [textStyle]

class  VoiceViewer extends StatelessWidget {
  final void Function(double value) onSeekChanged;
  final void Function() onPlayPauseButtonClick;
  final bool isPlaying;
  final bool isPause;
  final double? duration;
  final double? position;
  final bool isLoading;
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final bool tail;
  final bool sent;
  final bool delivered;
  final bool seen;

  final TextStyle textStyle;
  final BoxConstraints? constraints;

   VoiceViewer({
    Key? key,
    required this.onSeekChanged,
    required this.onPlayPauseButtonClick,
    this.isPlaying = false,
    this.constraints,

    this.isPause = false,
    this.duration,
    this.position,
    this.isLoading = true,
    this.bubbleRadius = BUBBLE_RADIUS_AUDIO,
    this.isSender = true,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.textStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 12,
    ),
  }) : super(key: key);

  ///chat bubble builder method
  @override
  Widget build(BuildContext context) {




    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: onPlayPauseButtonClick,
          child:CircleAvatar(
            radius: 15,
            backgroundColor: isSender? defaultColor:Color(0xff3B3B3B),
          child:  !isPlaying
              ? const Icon(
            Icons.play_arrow,
            size: 20.0,
            color: Colors.white,
          )
              : isLoading
              ? const CircularProgressIndicator()
              : isPause
              ? const Icon(
            Icons.play_arrow,
            size: 20.0,
            color: Colors.white,
          )
              : const Icon(
            Icons.pause,
            size: 20.0,
            color: Colors.white,
          ),)


        ),
        Expanded(
          child: Slider(
            min: 0.0,
            max: duration ?? 0.0,
            value: position ?? 0.0,
            activeColor:isSender? defaultColor:Color(0xff3B3B3B),
            inactiveColor: Colors.grey.shade300,
            onChanged: onSeekChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: 1,
            height: 15,
            color: isSender? defaultColor:Color(0xff3B3B3B),
          ),
        ),
        Text(
          audioTimer(duration ?? 0.0, position ?? 0.0),
          style: textStyle,
        )
      ],
    );
  }

  String audioTimer(double duration, double position) {
    return '${(duration ~/ 60).toInt()}:${(duration % 60).toInt().toString().padLeft(2, '0')}/${position ~/ 60}:${(position % 60).toInt().toString().padLeft(2, '0')}';
  }
}

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatefulWidget {
  final AudioPlayer audioPlayer;

  const AudioPlayerWidget({
    Key? key,
    required this.audioPlayer,
  }) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late Duration _duration = const Duration();
  late Duration _position = const Duration();

  final String audioSource =
      'https://www.harlancoben.com/audio/CaughtSample.mp3';

  bool isPlaying = false;
  bool isResume = false;
  bool isLoop = false;

  List<IconData> icons = [
    Icons.play_circle_filled,
    Icons.pause_circle_filled,
  ];

  @override
  void initState() {
    super.initState();
    widget.audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    widget.audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });

    widget.audioPlayer.setSourceUrl(audioSource);
  }

  buttonStart() {
    return IconButton(
      onPressed: () async {
        if (isPlaying) {
          setState(() {
            isPlaying = false;
          });
          await widget.audioPlayer.pause();
        } else {
          setState(() {
            isPlaying = true;
          });
          await widget.audioPlayer.play(DeviceFileSource(audioSource));
        }
      },
      icon: Icon(
        isPlaying ? icons[1] : icons[0],
      ),
    );
  }

  loadAssets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buttonStart(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
          ),
          loadAssets(),
        ],
      ),
    );
  }
}

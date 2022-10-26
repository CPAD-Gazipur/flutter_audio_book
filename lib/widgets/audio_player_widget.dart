import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final String audioSource;

  const AudioPlayerWidget({
    Key? key,
    required this.audioPlayer,
    required this.audioSource,
  }) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late Duration _duration = const Duration();
  late Duration _position = const Duration();

  bool isPlaying = false;
  bool isResume = false;
  bool isRepeat = false;

  List<IconData> icons = [
    Icons.play_circle_filled,
    Icons.pause_circle_filled,
  ];

  @override
  void dispose() {
    super.dispose();
    widget.audioPlayer.dispose();
  }

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

    widget.audioPlayer.setSourceUrl(widget.audioSource);

    widget.audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _position = const Duration(seconds: 0);
        if (isRepeat) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
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
          await widget.audioPlayer.play(DeviceFileSource(widget.audioSource));
        }
      },
      icon: Icon(
        isPlaying ? icons[1] : icons[0],
        size: 35,
        color: Colors.blue,
      ),
    );
  }

  buttonFast() {
    return IconButton(
      onPressed: () {
        widget.audioPlayer.setPlaybackRate(1.5);
        setState(() {
          isPlaying = true;
        });
      },
      icon: const Icon(
        Icons.skip_next_rounded,
        size: 30,
      ),
    );
  }

  buttonSlow() {
    return IconButton(
      onPressed: () {
        widget.audioPlayer.setPlaybackRate(0.5);
        setState(() {
          isPlaying = true;
        });
      },
      icon: const Icon(
        Icons.skip_previous_rounded,
        size: 30,
      ),
    );
  }

  buttonShuffle() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.shuffle_rounded,
        size: 20,
      ),
    );
  }

  buttonRepeat() {
    return IconButton(
      onPressed: () {
        if (isRepeat) {
          widget.audioPlayer.setReleaseMode(ReleaseMode.release);
          setState(() {
            isRepeat = false;
          });
        } else {
          widget.audioPlayer.setReleaseMode(ReleaseMode.loop);
          setState(() {
            isRepeat = true;
          });
        }
      },
      icon: Icon(
        isRepeat ? Icons.repeat_one_rounded : Icons.repeat_rounded,
        size: 20,
        color: isRepeat ? Colors.blue : null,
      ),
    );
  }

  loadAssets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buttonRepeat(),
        buttonSlow(),
        buttonStart(),
        buttonFast(),
        buttonShuffle(),
      ],
    );
  }

  slider() {
    return SizedBox(
      height: 30,
      child: Slider(
        label: _position.toString().split('.')[0],
        autofocus: true,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        },
      ),
    );
  }

  changeToSecond(int value) {
    Duration newPosition = Duration(seconds: value);
    widget.audioPlayer.seek(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _position.toString().split('.')[0],
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                _duration.toString().split('.')[0],
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        slider(),
        loadAssets(),
      ],
    );
  }
}

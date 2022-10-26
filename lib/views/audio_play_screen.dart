import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_book/widgets/audio_player_widget.dart';

import '../utils/utils.dart';

class AudioPlayScreen extends StatefulWidget {
  final String imageLink;
  final String audioTitle;
  final String author;
  final String audioSource;
  const AudioPlayScreen({
    Key? key,
    required this.audioTitle,
    required this.author,
    required this.imageLink,
    required this.audioSource,
  }) : super(key: key);

  @override
  State<AudioPlayScreen> createState() => _AudioPlayScreenState();
}

class _AudioPlayScreenState extends State<AudioPlayScreen> {
  late AudioPlayer audioPlayer;

  num number = 10;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.audioBluishBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight / 3,
            child: Container(
              color: AppColors.audioBlueBackgroundColor,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                  audioPlayer.dispose();
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                )
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.2,
            height: screenHeight * 0.36,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  Text(
                    widget.audioTitle.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Avenir',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.author,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Avenir',
                    ),
                  ),
                  AudioPlayerWidget(
                    audioPlayer: audioPlayer,
                    audioSource: widget.audioSource,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.12,
            left: (screenWidth - 115) / 2,
            right: (screenWidth - 115) / 2,
            height: screenHeight * 0.16,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.audioGreyBackgroundColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(widget.imageLink),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

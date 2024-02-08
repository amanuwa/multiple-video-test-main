import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

void main() {
  runApp(const MaterialApp(
    home: VideoPlayerList(),
  ));
}

class VideoPlayerList extends StatefulWidget {
  const VideoPlayerList({Key? key}) : super(key: key);

  @override
  _VideoPlayerListState createState() => _VideoPlayerListState();
}

class _VideoPlayerListState extends State<VideoPlayerList> {
  late List<ChewieController> _chewieControllers;

  @override
  void initState() {
    super.initState();

    List<String> videoPaths = [
      'assets/espresso.mp4',
      'assets/coffe.mp4',
      'assets/hotchcolet.mp4',
      'assets/tea.mp4',
      'assets/godentibs.mp4',
      'assets/tiresiga.mp4',
      'assets/kitfo.mp4',
    ];

    _chewieControllers = videoPaths.map((path) {
      final VideoPlayerController videoPlayerController =
          VideoPlayerController.asset(path);
      final chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true, // Start playing the video automatically
        looping: true, // Enable looping for continuous playback
        
      );
      return chewieController;
    }).toList();
  }

  @override
  void dispose() {
    for (var chewieController in _chewieControllers) {
      chewieController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            height: 50,
            width: 50,
            child: const Center(child: Text('Lunch')),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            height: 1000,
            width: 500,
            child: ListView.builder(
              itemCount: _chewieControllers.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  height: 300,
                  width: 500,
                  child: Chewie(controller: _chewieControllers[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

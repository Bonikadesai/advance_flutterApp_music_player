import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({Key? key}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = VideoPlayerController.asset(
        "lib/video/WhatsApp_Video_2023-06-06_at_8.01.35_PM.mp4")
      ..initialize().then((value) => setState(() {}));

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     ElevatedButton(
      //       onPressed: () {
      //         videoPlayerController.play();
      //       },
      //       child: Icon(Icons.play_arrow),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         videoPlayerController.pause();
      //       },
      //       child: Icon(Icons.pause),
      //     ),
      //   ],
      // ),
      body: Center(
        child: AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: Chewie(
            controller: chewieController,
          ),
        ),
      ),
    );
  }
}

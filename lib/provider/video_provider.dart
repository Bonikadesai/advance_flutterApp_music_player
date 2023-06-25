import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

import '../modals/video_modals.dart';
import '../utis/video_utils.dart';

class VideoProvider extends ChangeNotifier {
  VideoModel videoModel;

  VideoProvider({required this.videoModel});

  videoInitialization() {
    videoModel.videoPlayerController =
        VideoPlayerController.asset(video[videoIndex]['video'])..initialize();
    notifyListeners();

    videoModel.chewieController = ChewieController(
      videoPlayerController: videoModel.videoPlayerController!,
      autoPlay: false,
      fullScreenByDefault: true,
      allowFullScreen: true,
    );
    notifyListeners();
  }

  videoDeactivate() async {
    await videoModel.videoPlayerController!.pause();
    await videoModel.chewieController!.pause();
    notifyListeners();
  }
}

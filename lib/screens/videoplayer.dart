import 'package:flutter/cupertino.dart';
import 'package:media_booster_music_app/utis/video_utils.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({Key? key}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: video
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    videoIndex = video.indexOf(e);
                    Navigator.pushNamed(context, 'VideoControlsPage');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              e['thumbnail'],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        e['title'],
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/audio_provider.dart';
import '../utis/audio_utils.dart';

class AudioControlPage extends StatefulWidget {
  const AudioControlPage({Key? key}) : super(key: key);

  @override
  State<AudioControlPage> createState() => _AudioControlPageState();
}

class _AudioControlPageState extends State<AudioControlPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SongProvider>(context, listen: false).autoPlaySong();
      Provider.of<SongProvider>(context, listen: false)
          .songInitialization(songIndex);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 340,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(songs[songIndex]['img']),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      songs[songIndex]['songName'],
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  StreamBuilder(
                    stream: Provider.of<SongProvider>(context)
                        .songModel
                        .assetsAudioPlayer
                        .currentPosition,
                    builder: (context, snapshot) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Provider.of<SongProvider>(context, listen: false)
                            .currentSliderValue(snapshot);
                        Provider.of<SongProvider>(context, listen: false)
                            .totalDuration();
                      });

                      return Column(
                        children: [
                          Slider(
                            min: 0,
                            max: Provider.of<SongProvider>(context,
                                    listen: false)
                                .songModel
                                .totalDuration
                                .inSeconds
                                .toDouble(),
                            value: Provider.of<SongProvider>(context)
                                .songModel
                                .currentSliderValue
                                .inSeconds
                                .toDouble(),
                            onChanged: (val) {
                              Provider.of<SongProvider>(context, listen: false)
                                  .songModel
                                  .assetsAudioPlayer
                                  .seek(
                                    Duration(seconds: val.toInt()),
                                  );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(Provider.of<SongProvider>(context)
                                    .songModel
                                    .currentSliderValue
                                    .toString()
                                    .split('.')[0]),
                                Text(Provider.of<SongProvider>(context,
                                        listen: false)
                                    .songModel
                                    .totalDuration
                                    .toString()
                                    .split('.')[0]),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          Provider.of<SongProvider>(context, listen: false)
                              .previousSong();
                        },
                        icon: const Icon(
                          Icons.skip_previous,
                          size: 34,
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: null,
                        onPressed: () async {
                          Provider.of<SongProvider>(context, listen: false)
                              .playButton();
                        },
                        child: Provider.of<SongProvider>(context)
                            .playAndPauseIcon(),
                      ),
                      IconButton(
                        onPressed: () {
                          Provider.of<SongProvider>(context, listen: false)
                              .nextSong();
                        },
                        icon: const Icon(
                          Icons.skip_next,
                          size: 34,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    Provider.of<SongProvider>(context, listen: false).songDeactivate();
  }
}

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:media_booster_music_app/provider/audio_provider.dart';
import 'package:media_booster_music_app/screens/audio.dart';
import 'package:media_booster_music_app/screens/audio_controlpage.dart';
import 'package:media_booster_music_app/screens/video.dart';
import 'package:provider/provider.dart';

import 'modals/audio_modals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SongProvider(
            songModel: SongModel(
              isSongPlay: false,
              isMute: false,
              volume: 0.6,
              assetsAudioPlayer: AssetsAudioPlayer(),
              currentSliderValue: const Duration(seconds: 0),
              totalDuration: const Duration(seconds: 0),
              songIndex: 0,
            ),
          ),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => VideoProvider(
        //     videoModel: VideoModel(),
        //   ),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        routes: {
          '/': (context) => const HomePage(),
          'AudioControlsPage': (context) => const AudioControlPage(),
          // 'VideoControlsPage': (context) => const VideoControlsPage(),
        },
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Music App",
          ),
          bottom: TabBar(
            controller: tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            tabs: [
              Tab(
                child: Text(
                  "Music",
                ),
              ),
              Tab(
                child: Text(
                  "Video",
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AudioPlayer(),
            VideoPlayer(),
          ],
        ),
      ),
    );
  }
}

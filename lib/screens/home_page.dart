import 'package:flutter/material.dart';
import 'package:media_booster_music_app/screens/audio.dart';
import 'package:media_booster_music_app/screens/videoplayer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //late TabController tabController;

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   tabController = TabController(length: 2, vsync: this);
  // }

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
            //controller: tabController,
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

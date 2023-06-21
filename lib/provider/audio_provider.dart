import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import '../modals/audio_modals.dart';
import '../utis/audio_utils.dart';

class SongProvider extends ChangeNotifier {
  SongModel songModel;

  SongProvider({required this.songModel});

  autoPlaySong() {
    songModel.isSongPlay = true;
    notifyListeners();
  }

  playSong() {
    songModel.isSongPlay = !songModel.isSongPlay;
    notifyListeners();
  }

  playButton() async {
    playSong();
    await songModel.assetsAudioPlayer.playOrPause();
    notifyListeners();
  }

  Widget playAndPauseIcon() {
    if (songModel.isSongPlay) {
      return const Icon(
        Icons.pause,
        size: 38,
      );
    } else {
      return const Icon(
        Icons.play_arrow,
        size: 38,
      );
    }
  }

  songDeactivate() async {
    songModel.isSongPlay = false;
    await songModel.assetsAudioPlayer.stop();
    notifyListeners();
  }

  currentSliderValue(AsyncSnapshot snapshot) {
    songModel.currentSliderValue =
        (snapshot.data != null) ? snapshot.data : const Duration(seconds: 0);
    notifyListeners();
  }

  totalDuration() {
    try {
      songModel.totalDuration =
          songModel.assetsAudioPlayer.current.value!.audio.duration;
      notifyListeners();
    } catch (e) {
      songModel.totalDuration = const Duration(seconds: 0);
      notifyListeners();
    }
  }

  previousSong() async {
    if (songModel.isSongPlay == false) {
      playSong();
    }
    if (songModel.currentSliderValue < const Duration(seconds: 5) &&
        songIndex > 0) {
      songIndex--;
      await songModel.assetsAudioPlayer.previous();
    } else if (songIndex > 0) {
      songIndex--;
      await songModel.assetsAudioPlayer.previous();
      await songModel.assetsAudioPlayer.previous();
    }
    notifyListeners();
  }

  nextSong() async {
    if (songModel.isSongPlay == false) {
      playSong();
    }
    if (((songs.length) - 1) > songIndex) {
      songIndex++;
      await songModel.assetsAudioPlayer.next();
    }
    notifyListeners();
  }

  songInitialization(int index) {
    songModel.assetsAudioPlayer.open(
      Playlist(
        startIndex: index,
        audios: [
          ...songs.map(
            (e) => Audio(e['audio']),
          ),
        ],
      ),
      autoStart: songModel.isSongPlay,
      loopMode: LoopMode.single,
    );
    notifyListeners();
  }
}

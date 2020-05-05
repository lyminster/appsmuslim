import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioData extends ChangeNotifier{

  String urlAudio = "https://cdn.islamic.network/quran/audio/128/ar.alafasy/";
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlay = false;
  String noAyat = '1';

  AudioData(){
    initPlayer();
  }

  changeNoAyat(value){
    noAyat = value;
    isPlay = !isPlay;
    notifyListeners();
  }

  void initPlayer() {
    audioPlayer.onPlayerCompletion.listen((event) {
      print('audio sudah selesai');
      setIsStop();
    });
  }


  setIsStop(){
    isPlay = false;
    notifyListeners();
  }


  stop() async {
    int resultstop = await audioPlayer.stop();
    if (resultstop == 1) {
      setIsStop();
    }
  }

  play(value) async {
    int resultstop = await audioPlayer.stop();
    if (resultstop == 1) {
      setIsStop();
      int result = await audioPlayer.play(urlAudio + value + '.mp3');
      if (result == 1) {
        changeNoAyat(value);
      }
    }
  }

}
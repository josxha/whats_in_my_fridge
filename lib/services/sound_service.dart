import 'package:audioplayers/audioplayers.dart';

class SoundService {
  // https://www.soundjay.com/beep-sounds-1.html
  final AssetSource beepSource = AssetSource("beep-07a.mp3");
  final AudioPlayer _player;

  SoundService([String? playerId]) : _player = AudioPlayer(playerId: playerId);

  Future<void> beep() async => await _player.play(beepSource);
}

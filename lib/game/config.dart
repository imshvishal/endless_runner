class GameConfig {
  static String gameName = "Hurdle Escape";
  static double gameSpeed = 300;
  static double groundheight = 100;
}

class AudioAsset {
  static const String coinReceived = "coin.mp3";
  static const String plane = "plane.mp3";
  static const String hurdleCollision = "hurdle_collision.mp3";
  static const String buttonPress = "button_press.mp3";
  static const String powerUp = "power_up.mp3";
  static const String gameOver = "game_over.mp3";
  static const String gameMusic = "game_music.mp3";

  static List<String> getAllAudioAssets() {
    return [
      coinReceived,
      plane,
      hurdleCollision,
      buttonPress,
      powerUp,
      gameOver,
      gameMusic
    ];
  }
}

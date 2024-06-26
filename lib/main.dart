import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_demo/game/Player/spaceGameScreen.dart';
import 'package:flame_demo/game_rules_page.dart';
import 'package:flame_demo/game_start_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  runApp(
    const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SpaceShooter Game",
      home: gameStartScreen(),
      // GameWidget(
      //    game: SpaceGameScreen(),
      //  ),
    ),
  );
  WidgetsBinding.instance.addObserver(new _Handler());
}

class _Handler extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FlameAudio.bgm.resume(); // Audio player is a custom class with resume and pause static methods
    } else {
      FlameAudio.bgm.stop();
      FlameAudio.audioCache.clearAll();
    }
  }
}


import 'dart:developer';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_demo/game/Enemy/enemy.dart';
import 'package:flame_demo/game/Player/spaceGamePlayer.dart';
import 'package:flame_demo/game/game_screen_size.dart';
import 'package:flutter/material.dart';

class FireFlash extends SpriteComponent with HasGameRef, CollisionCallbacks {
  double speed = 300;
  Vector2 firePosition ;

  FireFlash({
    Sprite? sprite,
    required Vector2 this.firePosition,
    Vector2? size,
  }) : super(sprite: sprite, position: firePosition, size: size,);

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    this.position += Vector2(0, -1) * speed * dt;
    this.position = firePosition;
    // this.position = Vector2(x, y)

    if (this.position.x < 0) {
      removeFromParent();
    }
  }


}

import 'dart:developer';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_demo/game/Enemy/enemy.dart';
import 'package:flame_demo/game/game_screen_size.dart';
import 'package:flutter/material.dart';

class Bullet extends SpriteComponent with HasGameRef,CollisionCallbacks{

  double speed = 200;

  Bullet({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    this.position += Vector2(0, -1) * speed * dt;

    if(this.position.y < 0){
      removeFromParent();
    }

    // this.position.clamp(Vector2.random()  - this.size ,gameRef.size - this.size );
  }

}


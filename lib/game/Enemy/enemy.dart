
import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame_demo/game/game_screen_size.dart';

class Enemy extends SpriteComponent with HasGameRef {
  double speed;

  Enemy({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
    required this.speed,
    int? priority,
  }) : super(sprite: sprite, position: position, size: size,priority: priority);


  @override
  void update(double dt) {
    super.update(dt);

    this.position += Vector2(0, 1) * speed * dt;

    if (this.position.y > this.gameRef.size.y) {
      removeFromParent();
    }

    // this.position.clamp(Vector2.zero() - this.size / 2,gameSize - this.size / 2);
  } //Use For Updating Position

}

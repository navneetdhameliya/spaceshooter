import 'dart:math';
import 'dart:developer' as dev;

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_demo/game/Enemy/enemy.dart';

class EnemyManager extends Component with HasGameRef {
  late Timer timer;
  SpriteSheet spriteSheet;
  double speed;
  double second;

  Random random = Random();

  EnemyManager(
      {required this.spriteSheet, required this.speed, required this.second})
      : super() {
    timer = Timer(second, onTick: _spawnEnemy, repeat: true,autoStart: true);// every 1 second enemy is come
  }

  void _spawnEnemy() {
    // final gameScreenSize = gameRef.size;

    Vector2 initialSize = Vector2(80, 80);
    Vector2 position = Vector2(random.nextDouble() * gameRef.size.x, 0);

    position.clamp(
        Vector2.zero() + initialSize / 2, gameRef.size - initialSize / 2);

    Enemy enemy = Enemy(
        sprite:
            spriteSheet.getSpriteById(0) /*for choose character from image*/,
        size: Vector2(100, 100), // for character Size
        position: position,
        speed: speed,
        //for enemy position in the game
        );
    dev.log("Enemy speed in enemy manger $speed");
    dev.log("Enemy second in enemy manger $second");
    // enemy.anchor = Anchor.center;
    add(enemy);
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    timer.start();
  }

  @override
  void onRemove() {
    // TODO: implement onRemove
    super.onRemove();
    timer.stop();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    timer.update(dt);
  }
}

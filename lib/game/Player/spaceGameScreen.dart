import 'dart:math' as math;
import 'dart:developer';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/layers.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_demo/game/Enemy/enemy.dart';
import 'package:flame_demo/game/Enemy/enemy_manager.dart';
import 'package:flame_demo/game/bullet/bullet.dart';
import 'package:flame_demo/game/Player/spaceGamePlayer.dart';
import 'package:flame_demo/game/fire_flash.dart';
import 'package:flame_demo/game_over_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flame/parallax.dart';

class SpaceGameScreen extends FlameGame
    with
        PanDetector,
        TapDetector,
        HasGameRef,
        MouseMovementDetector,
        ScrollDetector,
        DoubleTapDetector {
  late Sprite player;
  late SpaceGamePlayer spaceGamePlayer;
  late EnemyManager enemyManager;
  late FireFlash fireFlash;
  late FireFlash destroyFlash;
  late FireFlash gameOverFlash;
  TextComponent playerScore = TextComponent();
  TextComponent playerHealth = TextComponent();
  TextComponent playerHealthAlert = TextComponent();
  TextComponent gameName = TextComponent();
  int score = 0;
  int health = 100;

  // late AudioComponent audioComponent;
  final renderText = TextPaint(
    style: const TextStyle(color: Colors.white, fontSize: 20),
  );
  final gamenameText = TextPaint(
    style: const TextStyle(color: Colors.white, fontSize: 35),
  ); //this textStyle use in for playerScore and playerHealth

  final alertText = TextPaint(
    style: const TextStyle(color: Colors.red, fontSize: 35),
  );
  Offset? _startPosition; //this define player starting position
  Offset? _currentPosition; //this define player current position
  late SpriteSheet _playerSpriteSheet;
  late SpriteSheet _bulletSpriteSheet;
  late SpriteSheet _enemySpriteSheet;
  late SpriteSheet _flashimg;
  late SpriteSheet _playerDestroyFlashImg;
  late SpriteSheet _gameOverFlashImg;
  late Layer colorLayer;

  late ParallaxComponent background;
  late ParallaxComponent lowHealthBackground;
  late ParallaxComponent highScoreBg;
  late int currentHealth;
  late SpriteSheet _onTapBulletSpriteSheet;
  double enemySpeed = 100;
  double second = 1;

  @override
  Future<void> onLoad() async {
    //use for add background image in Game

    FlameAudio.bgm.play("bgSound.mp3");

    await images.loadAll([
      "Player_1.png",
      "Bullet_1-1.png",
      "enemy.png",
      "Bullet_2.png",
      "main_bg.png",
      "stars1.png",
      "ship_A.png",
      "ship_H.png",
      "fire_flash.png",
      "playerdestroy_fire.png",
      "space.jpg",
      "game_over.png",
    ]);

    highScoreBg =  await ParallaxComponent.load(
          [
            ParallaxImageData("main_bg_2.png"),
            ParallaxImageData("stars1.png"),
          ],
          repeat: ImageRepeat.repeat,
          size: gameRef.size,
          fill: LayerFill.width,
          baseVelocity: Vector2(0, -30),
          priority: -1,
          velocityMultiplierDelta: Vector2(0, 5),
        );

    add(highScoreBg);
    //
    // highScoreBg = SpriteComponent()
    //   ..sprite = await loadSprite("space.jpg")
    //   ..size = gameRef.size..priority = -10; //use for add background image in Game

    background = await ParallaxComponent.load(
      [
        ParallaxImageData("main_bg_2.png"),
        // ParallaxImageData("stars1.png"),
      ],
      repeat: ImageRepeat.repeat,
      size: gameRef.size,
      fill: LayerFill.width,
      baseVelocity: Vector2(0, -30),
      // priority: -1,
      velocityMultiplierDelta: Vector2(0, 5),
    );

    // add(background);

    // await images.load();
    // await images.load("ship_B.png");

    _playerSpriteSheet =
        setSpriteSheetImage(image: "Player_1.png"); //loadPlayerImages

    _bulletSpriteSheet =
        setSpriteSheetImage(image: "Bullet_1-1.png"); //loadBulletImages

    _enemySpriteSheet =
        setSpriteSheetImage(image: "enemy.png"); //loadSpriteImages

    _onTapBulletSpriteSheet = setSpriteSheetImage(image: 'Bullet_2.png');

    _flashimg = setSpriteSheetImage(image: "fire_flash.png");

    _playerDestroyFlashImg =
        setSpriteSheetImage(image: "playerdestroy_fire.png");

    _gameOverFlashImg = setSpriteSheetImage(image: "game_over.png");

    spaceGamePlayer = SpaceGamePlayer(
        sprite: _playerSpriteSheet.getSpriteById(0),
        //for choose player from image
        size: Vector2(110, 110),
        // for player Size
        positions: Vector2(200, 450) //for character position in the screen
        );

    add(spaceGamePlayer);
    // overlays.add("commonLogo");


    enemyManager = EnemyManager(
      spriteSheet: _enemySpriteSheet,
      speed: enemySpeed,
      second: second,
    );
    add(enemyManager);

    ///for adding Text in the Screen
    playerScores();
    add(playerScore);

    ///for adding Text in the Screen
    playerHealths();
    add(playerHealth);

    gameName
      ..text = "SpaceShooter Game"
      ..textRenderer = gamenameText
      ..x = gameRef.size.x*0.1
      ..y = gameRef.size.y *0.07;
    add(gameName);
    // playerHealth.anchor = Anchor.topRight;

    colorLayer = ColorLayer();

    fireFlash = FireFlash(
      sprite: _flashimg.getSpriteById(0),
      //for choose player from image
      size: Vector2(110, 110),
      // for player Size
      firePosition: Vector2(-100, -100),
    );

    destroyFlash = FireFlash(
      sprite: _playerDestroyFlashImg.getSpriteById(0),
      //for choose player from image
      size: Vector2(110, 110),
      // for player Size
      firePosition:
      Vector2(-100, -100),
    );
  }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   // if (_startPosition != null) {
  //   //   canvas.drawCircle(
  //   //     _startPosition!,
  //   //     60,
  //   //     Paint()..color = Colors.grey.withAlpha(200),
  //   //   );
  //   // }
  //   //
  //   // if (_currentPosition != null) {
  //   //   var delta = _currentPosition! - _startPosition!;
  //   //   if (delta.distance < 60) {
  //   //     delta = _currentPosition! +
  //   //         (Vector2(delta.dx, delta.dy).normalized() * 60).toOffset();
  //   //   } else {
  //   //     delta = _startPosition!;
  //   //   }
  //   //   canvas.drawCircle(
  //   //     delta,
  //   //     20,
  //   //     Paint()..color = Colors.grey.withAlpha(500),
  //   //   );
  //   // }
  //
  //   // canvas.drawRect(Rect.fromLTWH(gameRef.size.x - 65, gameRef.size.y - 50, health.toDouble() - 50, 20), Paint()..color = Colors.blue.withOpacity(0.5),);
  // } //for draw circle around the character
  // @override
  // void render(Canvas canvas) async{
  //   // TODO: implement render
  //   super.render(canvas);
  //   // if (health <= 50) {
  //   //
  //   //   // lowHealthBackground = await ParallaxComponent.load(
  //   //   //   [
  //   //   //     ParallaxImageData("main_bg_2.png"),      ],
  //   //   //   repeat: ImageRepeat.repeat,
  //   //   //   size: gameRef.size,
  //   //   //   fill: LayerFill.width,
  //   //   //   baseVelocity: Vector2(0, -30),
  //   //   //   velocityMultiplierDelta: Vector2(0, 5),
  //   //   // );
  //   //
  //   //   add(lowHealthBg);
  //   // }
  //
  // }
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (health <= 25) {
      colorLayer.render(canvas);
      FlameAudio.play("alarm.mp3");
    }


    // if(score == 5){
    //   background.removeFromParent();
    //   add(highScoreBg);
    // }
    // if(score <= 5){
    //   Future.delayed(const Duration(milliseconds: 1000),() => highScoreBg.removeFromParent(),);
    // }
    // switch(score){
    //   case 5:
    //   // colorLayer.render(canvas);
    //
    //   background.removeFromParent();
    //   add(highScoreBg);
    //   break;
    // }
  }

  @override
  void onPanStart(DragStartInfo info) {
    _startPosition = info.raw.globalPosition;
    _currentPosition = info.raw.globalPosition;
    log("Pan Start");
  } //touch the screen

  @override
  void onPanUpdate(DragUpdateInfo info) {
    _currentPosition = info.raw.globalPosition;

    var delta = _currentPosition! - _startPosition!;
    if (delta.distance > 10) {
      spaceGamePlayer.setMoveDirectional(Vector2(delta.dx, delta.dy));
    } else {
      spaceGamePlayer.setMoveDirectional(Vector2.zero());
    }
    // log("Pan Update");
  } //where to move

  @override
  void onPanEnd(DragEndInfo info) {
    _startPosition = null;
    _currentPosition = null;
    spaceGamePlayer.setMoveDirectional(Vector2.zero());
    log("Pan End");
  } //end the screen touching

  @override
  void onPanCancel() {
    _startPosition = null;
    _currentPosition = null;
    log("Pan Cancel");
  }

  @override
  void onTapDown(TapDownInfo info) async {
    // TODO: implement onTapDown
    FlameAudio.play("shoot_bullet.mp3", volume: 50);
    super.onTapDown(info);
    Bullet bulletLeftSide = shootBullet(x: 0, y: 0.30);

    Bullet bulletInMiddle = shootBullet(
      x: 0.30,
      y: -0.1,
    );

    Bullet bulletRightSide = shootBullet(x: 0.55, y: 0.3);

    if (score <= 100 || score > 200) {
      add(bulletInMiddle);
    }

    if (score > 100 || score > 200) {
      add(bulletLeftSide);
      add(bulletRightSide);
    }

    log("enemy speed=====> $enemySpeed");
    log("second ===> $second");

    // fireFlash.removeFromParent();

  }

  @override
  void update(double dt) async {
    // TODO: implement update
    //this update method using of the HasGameRef
    super.update(dt);

    final bullets = children.whereType<Bullet>();

    for (final enemy in enemyManager.children.whereType<Enemy>()) {
      for (final bullet in bullets) {

        //bullet touch to enemy and enemy was destroy
        if (enemy.containsPoint(bullet.absoluteCenter)) {
          fireFlash = FireFlash(
            sprite: _flashimg.getSpriteById(0),
            //for choose player from image
            size: Vector2(110, 110),
            // for player Size
            firePosition: enemy.absolutePositionOfAnchor(const Anchor(0, 0)),
          );
          if(!fireFlash.isLoaded || fireFlash.isRemoved){
            add(fireFlash);
          }
            Future.delayed(
              const Duration(milliseconds: 50),
                  () {
                fireFlash.removeFromParent();
              },
            );

          // flashDestroy.setToStart();

          enemy.removeFromParent(); //destroy enemy
          bullet.removeFromParent(); // destroy enemy touch bullet

          // fireFlash.removeFromParent();
          score++;
          if (score % 5 == 0) {
            //whenever we are destroy 5 enemy so health increase by 05%
            health += 5;
            if (health >= 100) {
              health = 100;
              playerHealths();
            }
          }

          //update score section
          playerScores();

          //update health section
          playerHealths();

          // FlameAudio.play("enemy_destroy.mp3",volume: 100);
          log("======> $score");
          break;
        }
      }

      //when enemy touch player and health was <0 so player was destroy and Game Over
      if (spaceGamePlayer.containsPoint(enemy.absoluteCenter)) {
        gameRef.camera.shake(intensity: 20);
        log("Destroy the Player");
        health -= 10; //when touch enemy with player so less 10% health
        if (health <= 0) {
          //when player health is 0 so player was destroy and over the game
          healthOver();
          FlameAudio.play("blast.mp3");
        }
        if (health <= 25) {
          // Future.delayed(const Duration(seconds: 1),() {
          //
          // },);
          if(!playerHealthAlert.isLoaded || playerHealthAlert.isRemoved){
            alertForPlayer();
          }
          Future.delayed(const Duration(seconds: 1),() {
            playerHealthAlert.removeFromParent();
          },);
        }
        //update health section
        playerHealths();
        destroyFlash = FireFlash(
          sprite: _playerDestroyFlashImg.getSpriteById(0),
          //for choose player from image
          size: Vector2(110, 110),
          // for player Size
          firePosition:
              spaceGamePlayer.absolutePositionOfAnchor(const Anchor(0, 0)),
        );

        if(!destroyFlash.isLoaded || destroyFlash.isRemoved){
          add(destroyFlash);
        }
        Future.delayed(
          const Duration(milliseconds: 100),
          () {
            destroyFlash.removeFromParent();
          },
        );

        log("======>health $health");
        enemy.removeFromParent();

        // spaceGamePlayer.removeFromParent();
        FlameAudio.play("enemy_destroy.mp3");

        //if player touch to enemy so player will distroy
        break;
      }

      //whenever enemy out of screen without destroy so less 5% health
      if (enemy.position.y > gameRef.size.y) {
        gameRef.camera.shake(intensity: 5);
        health -= 5;
        if (health <= 0) {
          healthOver();
        } //update health section

        if (health <= 25) {
          // Future.delayed(const Duration(seconds: 1),() {
          //
          // },);
          if(!playerHealthAlert.isLoaded || playerHealthAlert.isRemoved){
            alertForPlayer();
          }
          Future.delayed(const Duration(seconds: 1),() {
            playerHealthAlert.removeFromParent();
          },);
        }

        playerHealths();
        enemy.removeFromParent(); //destroy enemy
        playerHealthAlert.removeFromParent();
        break;
      }

      if (score > 5 && score <= 15) {
        enemySpeed = 100;
        second = 1 / 100;
        enemyManager.second = second;
        enemyManager.speed = enemySpeed;
      } else if (score > 15 && score <= 20) {
        enemySpeed = 115;
        second = 1 / 150;
        enemyManager.second = second;
        enemyManager.speed = enemySpeed;
      } else if (score > 30 && score <= 40) {
        enemySpeed = 130;
        second = 1 / 200;
        enemyManager.speed = enemySpeed;
        enemyManager.second = second;
      } else if (score > 40) {
        enemySpeed = 140;
        second = 1 / 250;
        enemyManager.speed = enemySpeed;
        enemyManager.second = second;
      }
    }
  }

  void healthOver() {
    health = 0;
    gameOverFlash = FireFlash(
      sprite: _gameOverFlashImg.getSpriteById(0),
      //for choose player from image
      size: Vector2(110, 110),
      // for player Size
      firePosition:
      spaceGamePlayer.absolutePositionOfAnchor(const Anchor(0, 0)),
    );
    add(gameOverFlash);
    spaceGamePlayer.removeFromParent();
    Future.delayed(
      const Duration(
        milliseconds: 300,
      ),
      () {
        Get.off(
          () => GameOverScreen(
            finalScore: score,
          ),
        );
      },
    );
  }

  Bullet shootBullet({required double x, required double y}) {
    return Bullet(
      sprite: _bulletSpriteSheet.getSpriteById(0),
      // sprite: _spriteSheet.getSpriteById(30), //for choose character from image
      size: Vector2(50, 50),
      // for character Size
      position: spaceGamePlayer.absolutePositionOfAnchor(Anchor(x, y)),
    );
  }

  void playerScores() {
    playerScore
      ..text = "Your Score : $score"
      ..textRenderer = renderText
      ..x = 10
      ..y = gameRef.size.y - 50;
  } //this function create for player score

  void playerHealths() {
    playerHealth
      ..text = "Your Health : $health%"
      ..textRenderer = renderText
      ..x = gameRef.size.x - 15
      ..y = gameRef.size.y - 50;
    playerHealth.anchor = Anchor.topRight;
  } //this function create for player health

  void alertForPlayer() {
    // playerHealthAlert.removeFromParent();

    playerHealthAlert
      ..text = "Your Health Very Low"
      ..textRenderer = alertText
      ..x = gameRef.size.x*0.1
      ..y = gameRef.size.y - 500
      ..onRemove;
    add(playerHealthAlert);
  }

  SpriteSheet setSpriteSheetImage({required String image}) {
    return SpriteSheet.fromColumnsAndRows(
      image: images.fromCache(image),
      columns: 1,
      rows: 1,
    );
  } // this function use for set bullet,enemy,player images
}

class ColorLayer extends PreRenderedLayer {
  @override
  void drawLayer() {
    canvas.drawColor(Colors.brown, BlendMode.screen);
  }
}

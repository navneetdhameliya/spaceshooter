import 'package:flame/game.dart';
import 'package:flame_demo/game/Player/spaceGameScreen.dart';
import 'package:flame_demo/game/common_logo.dart';
import 'package:flame_demo/game/setting_page.dart';
import 'package:flame_demo/game_rules_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class gameStartScreen extends StatelessWidget {
  const gameStartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage("assets/images/stars1.png"),
        //         fit: BoxFit.fill)),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: const Alignment(0.9,0),
                child: IconButton(
                  onPressed: () {
                    Get.to(const GameSettingPage());
                  },
                  icon: const Icon(
                    Icons.settings,
                    size: 50,
                    color: Colors.black45,
                  ),
                ),
              ),
              const SizedBox(
                height: 250,
              ),
              const Icon(
                Icons.gamepad_outlined,
                color: Colors.black54,
                size: 100,
              ),
              const Text(
                "Play Game",
                style: TextStyle(color: Colors.black54, fontSize: 50),
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black54),
                  shadowColor: MaterialStatePropertyAll(Colors.black54),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameWidget(
                        game: SpaceGameScreen(),
                        mouseCursor: SystemMouseCursors.move,
                          // overlayBuilderMap: {
                          //   'commonLogo': (
                          //       BuildContext context,
                          //       game) {
                          //     return CommonLogo(context,true);
                          //   },
                          // }
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Play",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white12),
                    shadowColor: MaterialStatePropertyAll(Colors.black54),
                  ),
                  onPressed: () {
                    Get.to(const RulesPage());
                  },
                  child: const Text(
                    "Please read game rules before playing",
                    style: TextStyle(fontSize: 20, color: Colors.black45),
                  )),
              const SizedBox(
                height: 20,
              ),
              // CommonLogo(context, false),
            ],
          ),
        ),
      ),
    );
  }
}

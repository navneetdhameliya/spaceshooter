import 'package:flame/game.dart';
import 'package:flame_demo/game/Player/spaceGameScreen.dart';
import 'package:flame_demo/game/common_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameOverScreen extends StatelessWidget {
  int finalScore;

  GameOverScreen({Key? key, required this.finalScore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/main_bg.png"),
                fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.gamepad_outlined,
              color: Colors.deepPurpleAccent,
              size: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "Your Final Score :- $finalScore",
                  style: const TextStyle(
                      fontSize: 35, color: Colors.deepPurpleAccent),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Game Over",
              style: TextStyle(color: Colors.red, fontSize: 60),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white30),
                fixedSize: MaterialStatePropertyAll(Size(150, 50)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameWidget(
                      game: SpaceGameScreen(),
                    ),
                  ),
                );
              },
              child: const Text(
                "Restart ",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white30),
                fixedSize: MaterialStatePropertyAll(Size(150, 50)),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    elevation: 50,
                    shape: Border.all(
                        color: Colors.deepPurpleAccent,
                        style: BorderStyle.solid,
                        width: 2),
                    shadowColor: Colors.deepPurpleAccent,
                    backgroundColor: Colors.deepPurpleAccent.withOpacity(0.5),
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.red,
                      size: 30,
                    ),
                    title: const Center(
                        child: Text(
                      "Confirm to Exit",
                      style: TextStyle(color: Colors.white54, fontSize: 30),
                    )),
                    actions: [
                      ButtonBar(
                        children: [
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white30),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "No",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white30),
                            ),
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
                // SystemNavigator.pop();
              },
              child: const Text(
                "Exit ",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            //   child: CommonLogo(context, true),
            // )
          ],
        ),
      ),
    );
  }
}

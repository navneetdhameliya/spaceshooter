import 'package:flutter/material.dart';

class GameSettingPage extends StatelessWidget {
  const GameSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
        backgroundColor: Colors.black38,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black38),
                shadowColor: MaterialStatePropertyAll(Colors.black54),
                elevation: MaterialStatePropertyAll(5),
              ),
              onPressed: () {},
              child: const Text(
                "Music Off",
                style: TextStyle(fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black38),
                shadowColor: MaterialStatePropertyAll(Colors.black54),
                elevation: MaterialStatePropertyAll(5),
              ),
              onPressed: () {},
              child: const Text(
                "Sound Off",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

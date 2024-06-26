import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Rules for Playing"),backgroundColor: Colors.deepPurpleAccent),
      backgroundColor: Colors.deepPurpleAccent.withOpacity(0.7),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Center(child: Text("***** Rules *****",style: TextStyle(fontSize: 30,color: Colors.white),)),
            SizedBox(height: 30,),
            Text(" [ 1 ] Move the player to begin playing.",style: TextStyle(fontSize: 20,color: Colors.white),),
            SizedBox(height: 15,),
            Text(" [ 2 ] When a bullet is fired from the screen and contacts an enemy, the enemy is destroyed.",style: TextStyle(fontSize: 20,color: Colors.white),),
            SizedBox(height: 15,),
            Text(" [ 3 ] When the enemy destroys, the score is raised by one point. ",style: TextStyle(fontSize: 20,color: Colors.white),),
            SizedBox(height: 15,),
            Text(" [ 4 ] When an enemy touches a player, their health is reduced by 10%.",style: TextStyle(fontSize: 20,color: Colors.white),),
            SizedBox(height: 15,),
            Text(" [ 5 ] When 5 enemies are destroyed, the health increases by 5%, and the health decreases by 5% if the enemy leaves the screen.",style: TextStyle(fontSize: 20,color: Colors.white),),
            SizedBox(height: 15,),
            Text(" [ 7 ] If your score is greater than 100, fire two bullets, and if it is greater than 200, fire three bullets."
                ""
                "",style: TextStyle(fontSize: 20,color: Colors.white),),
            // CommonLogo(context, false),

          ],
        ),
      ),
    );
  }
}

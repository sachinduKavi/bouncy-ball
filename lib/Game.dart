import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}


class _GameState extends State<Game> {
  // Initialize variables
  double ballY = 0, time = 0, barrierPosition = -0.3;
  bool status = true;
  double initialDis = 0, gap = 250, barrierH = 400, barrierSpeed = 0.005;
  late Timer timer;
  bool startVisibility = true;
  late double screenHeight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void checkCollisions() {

  }


  void startGame() {
    try{
      timer.cancel();
      initialDis = ballY;
    }catch(e){
      startVisibility = false;
    }
    time = 0; // Reset time
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        time += 0.1;
        barrierPosition -= barrierSpeed;
        // Reset barrier
        if(barrierPosition < -1.5) {
          barrierPosition = 1.5;
          barrierH = Random().nextDouble()*450;
        }
        // Check for collisions ball with the -0.25
        if(double.parse(barrierPosition.toStringAsFixed(2)) <= 0.28 && double.parse(barrierPosition.toStringAsFixed(2)) > -0.25) {
          timer.cancel();
        }
        ballY = initialDis + (-12 * time + 0.8 * pow(time, 2)) / 100;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: startGame,
      child: Scaffold(
        body: Stack(
          children: [
            // Barrier objects
            Container(
              alignment: Alignment(barrierPosition, 0),
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover)
              ),
              child: Container(
                height: double.infinity,
                width: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Upper barrier
                    Container(
                      height: barrierH,
                      decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/brickWall.jpg"), fit: BoxFit.fitWidth, repeat: ImageRepeat.repeatY)
                      ),
                    ),

                    // Bottom barrier
                    Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/brickWall.jpg"), fit: BoxFit.fitWidth, repeat: ImageRepeat.repeatY)
                      ),
                      height: screenHeight - (barrierH + gap),
                    )
                  ],
                ),
              ),
            ),



            // Bouncing ball
            Container(
              alignment: Alignment(0, ballY),
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  gradient: LinearGradient(colors: [
                    Colors.amber,
                    Colors.red,
                    Colors.red,
                    Colors.red,
                  ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topRight
                  ),
                  shape: BoxShape.circle
                ),
              ),

            ),

             Visibility(
               visible: startVisibility,
               child: Container(
                 padding: const EdgeInsets.all(10),
                   color: Colors.black38,
                   height: double.infinity,
                   width: double.infinity,
                   child: const Center(child: Text("Tap to Play", style: TextStyle(color: Colors.white, fontSize: 25),))),
             ),




          ],
        )

      ),
    );
  }
}

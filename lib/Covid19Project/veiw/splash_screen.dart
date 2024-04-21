import 'dart:async';

import 'package:api/Covid19Project/veiw/world_state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const WorldStateScreen())));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [

            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  width: MediaQuery.of(context).size.width*.3,
                  height: MediaQuery.of(context).size.width*.4,
                  child: const Center(
                    child: Image(image: AssetImage("assets/image/img.png"))
                  ),
                ),
                builder: (BuildContext context, Widget? child){
                  return Transform.rotate(
                      angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
                }
            ),
            SizedBox(height:MediaQuery.of(context).size.height * .08 ,),
            Text("Covid-19 Tracker",style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),)

          ],
        ),
      ),
    );
  }
}
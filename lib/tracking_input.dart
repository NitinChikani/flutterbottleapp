import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:condition/condition.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'flare_controller.dart';

class TrackingInput extends StatefulWidget {
  @override
  TrackingState createState() => TrackingState();
}

class TrackingState extends State<TrackingInput> {
  ///these get set when we build the widget
  double screenWidth = 10.0;
  double screenHeight = 10.0;

  bool isEmpty = true;
  int count = 0;
  bool disable = false;
  bool mini = false;

  ///this is the animation controller for the water and iceBoy
  AnimationControls _flareController;

  ///an example of how to set up individual controllers
  final FlareControls plusWaterControls = FlareControls();
  final FlareControls minusWaterControls = FlareControls();

  ///the current number of glasses drunk
  int currentWaterCount = 0;

  ///this will come from the selectedGlasses times ouncesPerGlass
  /// we'll use this to calculate the transform of the water fill animation
  int maxWaterCount = 0;

  ///we'll default at 8, but this will change based on user input
  int selectedGlasses = 8;

  ///this doesn't change, hence the 'static const', we always count 8 ounces
  ///per glass (it's assuming)
  static const int ouncePerGlass = 8;

  @override
  void initState() {
    _flareController = AnimationControls();

    super.initState();
  }

  void _incrementWater() {
    setState(() {
      isEmpty = false;
      count = count + 1;

      (count == 8) ? disable = true : null;
      (count == 8) ? mini = true : null;
      // (count == 8) ? disable = true : null;
      (count == 9) ? count = 0 : null;

      debugPrint("Increment Called :-> ${count} ");
      if (currentWaterCount < selectedGlasses) {
        currentWaterCount = currentWaterCount + 1;

        double diff = currentWaterCount / selectedGlasses;

        plusWaterControls.play("plus press");

        _flareController.playAnimation("ripple");

        _flareController.updateWaterPercent(diff);
      }
    });
  }

  ///we'll use this to decrease our user's water intake, hooked to a button
  void _decrementWater() {
    (mini == true)
        ? setState(() {
            count = 8;
            disable = false;
            if (currentWaterCount > 0) {
              count = count - 1;
              debugPrint("DeIncrement Called  :-> ${count} ");

              currentWaterCount = currentWaterCount - 1;
              double diff = currentWaterCount / selectedGlasses;

              _flareController.updateWaterPercent(diff);

              _flareController.playAnimation("ripple");
            } else {
              currentWaterCount = 0;
            }
            minusWaterControls.play("minus press");
          })
        : setState(() {
            if (currentWaterCount > 0) {
              count = count - 1;
              debugPrint("DeIncrement Called  :-> ${count} ");

              currentWaterCount = currentWaterCount - 1;
              double diff = currentWaterCount / selectedGlasses;

              _flareController.updateWaterPercent(diff);

              _flareController.playAnimation("ripple");
            } else {
              currentWaterCount = 0;
            }
            minusWaterControls.play("minus press");
          });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width / 3.0;
    screenHeight = MediaQuery.of(context).size.height / 4.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bottel "),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: (isEmpty)
                ? AssetImage("asset/Empty.png")
                : (count == 4)
                    ? AssetImage("asset/overflow.png")
                    : (count == 8)
                        ? AssetImage("asset/yellowbottle.png")
                        : AssetImage("asset/overflow.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              child: Row(
                children: <Widget>[
                  addWaterBtn(),
                  subWaterBtn(),
                ],
              ),
            ),
            (count == 8)
                ? Container(
                    height: MediaQuery.of(context).size.height / 1.27,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: MediaQuery.of(context).size.height / 5.5,
                          left: MediaQuery.of(context).size.width / 3.25,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.54,
                            width: MediaQuery.of(context).size.width / 2.6,
                            child: FlareActor(
                              "asset/WaterArtboards.flr",
                              controller: _flareController,
                              fit: BoxFit.fill,
                              artboard: "Artboard",
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 1.27,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: MediaQuery.of(context).size.height / 4.0,
                          left: MediaQuery.of(context).size.width / 3.25,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 1.6,
                            width: MediaQuery.of(context).size.width / 2.6,
                            child: FlareActor(
                              "asset/WaterArtboards.flr",
                              controller: _flareController,
                              fit: BoxFit.fill,
                              artboard: "Artboard",
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget addWaterBtn() {
    debugPrint("Water Up Called");
    return Container(
      height: 30,
      width: 30,
      child: Center(
        child: RawMaterialButton(
          constraints: BoxConstraints.tight(const Size(50, 50)),
          onPressed: (disable == true) ? null : _incrementWater,
          shape: Border(),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          elevation: 0.0,
          child: Text(
            "+",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget subWaterBtn() {
    debugPrint("Water Down Called");
    return Container(
      height: 30,
      width: 30,
      child: Center(
        child: RawMaterialButton(
          constraints: BoxConstraints.tight(const Size(50, 50)),
          onPressed: _decrementWater,
          shape: Border(),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          elevation: 0.0,
          child: Text(
            "-",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

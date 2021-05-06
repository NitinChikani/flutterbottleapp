import 'package:bottle_app/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './flare_controller.dart';
import 'package:flare_flutter/asset_provider.dart';
import 'package:flare_flutter/cache.dart';
import 'package:flare_flutter/cache_asset.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/flare_cache_asset.dart';
import 'package:flare_flutter/flare_cache_builder.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flare_flutter/flare_render_box.dart';
import 'package:flare_flutter/flare_testing.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flare_flutter/provider/memory_flare.dart';
import 'package:flare_flutter/trim_path.dart';

class Bottal extends StatefulWidget {
  @override
  _BottalState createState() => _BottalState();
}

class _BottalState extends State<Bottal> {
  double screenWidth = 0.0;
  double screenHeight = 0.0;

  // ignore: unused_field
  // AnimationContros _flareController;
  AnimationControls _flareController;

  final FlareControls plusWaterControls = FlareControls();
  final FlareControls minusWaterControls = FlareControls();

  int currentWaterCount = 0;

  int maxWaterCount = 0;

  int selectedGlasses = 8;

  static const int ouncePerGlass = 8;

  @override
  void initState() {
    // _flareController = AnimationControls();
    // _flareController = AnimationContros();

    super.initState();
  }

  void _decrementWater() {
    setState(() {
      if (currentWaterCount > 0) {
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

  void _incrementWater() {
    setState(() {
      if (currentWaterCount < selectedGlasses) {
        currentWaterCount = currentWaterCount + 1;

        double diff = currentWaterCount / selectedGlasses;

        plusWaterControls.play("plus press");

        _flareController.playAnimation("ripple");

        _flareController.updateWaterPercent(diff);
      }

      if (currentWaterCount == selectedGlasses) {
        _flareController.playAnimation("iceboy_win");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottal App"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset("asset/water_2.jpg"),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  MaterialButton(
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      debugPrint("Add BUtton Click");
                      setState(() {
                        if (currentWaterCount < selectedGlasses) {
                          currentWaterCount = currentWaterCount + 1;

                          double diff = currentWaterCount / selectedGlasses;

                          plusWaterControls.play("plus press");

                          _flareController.playAnimation("ripple");

                          _flareController.updateWaterPercent(diff);
                        }

                        if (currentWaterCount == selectedGlasses) {
                          _flareController.playAnimation("iceboy_win");
                        }
                      });
                    },
                    child: Icon(
                      Icons.add,
                      size: 24,
                    ),
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(15.0),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  MaterialButton(
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      debugPrint("remove BUtton Click");
                      setState(() {
                        if (currentWaterCount > 0) {
                          currentWaterCount = currentWaterCount - 1;
                          double diff = currentWaterCount / selectedGlasses;

                          _flareController.updateWaterPercent(diff);

                          _flareController.playAnimation("ripple");
                        } else {
                          currentWaterCount = 0;
                        }
                        minusWaterControls.play("minus press");
                      });
                    },
                    child: Icon(
                      Icons.remove,
                      size: 24,
                    ),
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(15.0),
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
    return RawMaterialButton(
      constraints: BoxConstraints.tight(const Size(5, 5)),
      onPressed: _incrementWater,
      shape: Border(),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      elevation: 0.0,
      child: FlareActor("asset/WaterArtboards.flr",
          controller: plusWaterControls,
          fit: BoxFit.contain,
          animation: "plus press",
          sizeFromArtboard: false,
          artboard: "UI plus"),
    );
  }

  Widget subWaterBtn() {
    return RawMaterialButton(
      constraints: BoxConstraints.tight(const Size(5, 5)),
      onPressed: _decrementWater,
      shape: Border(),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      elevation: 0.0,
      child: FlareActor("asset/WaterArtboards.flr",
          controller: minusWaterControls,
          fit: BoxFit.contain,
          animation: "minus press",
          sizeFromArtboard: true,
          artboard: "UI minus"),
    );
  }
}

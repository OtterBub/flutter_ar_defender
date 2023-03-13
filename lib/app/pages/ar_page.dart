import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';

import '../../src/arframe.dart';

class ARPage extends StatefulWidget {
  const ARPage({super.key, required this.title});

  final String title;

  @override
  State<ARPage> createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {
  late ARKitController arKitController;
  ARFrame arFrame = ARFrame();

  @override
  void dispose() {
    arKitController.updateAtTime = null;
    arKitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buildWidget = Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ARKitSceneView(
          showFeaturePoints: true, onARKitViewCreated: onARKitViewCreated),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "heightObject",
            onPressed: () {
              // change icon
              setState(
                () {
                  arFrame.pressedAddBtn("height");
                },
              );
            },
            tooltip: 'heightObject',
            child: Icon(
                arFrame.positionHeight ? Icons.arrow_upward : Icons.height),
          ),
          FloatingActionButton(
            heroTag: "AddObject",
            onPressed: () {
              arFrame.pressedAddBtn("add");
            },
            tooltip: 'addObject',
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
    return GestureDetector(
      child: buildWidget,
      onVerticalDragUpdate: (details) {
        arFrame.onVerticalDragUpdate(details);
      },
      onHorizontalDragUpdate: (details) {
        arFrame.onHorizontalDragUpdate(details);
      },
    );
  }

  void onARKitViewCreated(ARKitController controller) {
    arKitController = controller;
    arFrame.init(controller);

    arKitController.addCoachingOverlay(CoachingOverlayGoal.horizontalPlane);
    arKitController.updateAtTime = (time) => arFrame.update(time);
  }
}

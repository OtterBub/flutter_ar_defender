import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:collection/collection.dart';

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

  void _addObject() {
    setState(() {
      // Add Object
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ARKitSceneView(
          showFeaturePoints: true, onARKitViewCreated: onARKitViewCreated),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          arFrame.pressedAddBtn();
        },
        tooltip: 'AddObject',
        child: const Icon(Icons.add),
      ),
    );
  }

  void onARKitViewCreated(ARKitController controller) {
    arKitController = controller;
    arKitController.addCoachingOverlay(CoachingOverlayGoal.horizontalPlane);

    arFrame.init(controller);

    arKitController.updateAtTime = (time) => arFrame.update(time);
  }
}

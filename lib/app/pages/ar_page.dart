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
  ARFrame gameFrame = ARFrame();

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
        onPressed: _addObject,
        tooltip: 'AddObject',
        child: const Icon(Icons.add),
      ),
    );
  }

  void onARKitViewCreated(ARKitController controller) {
    arKitController = controller;
    arKitController.addCoachingOverlay(CoachingOverlayGoal.horizontalPlane);

    gameFrame.init(controller);

    arKitController.updateAtTime = (time) => gameFrame.update(time);

    final newNode = ARKitNode(
        geometry: ARKitSphere(radius: 0.25),
        position: vector.Vector3(0, 0, -1.5));

    arKitController.add(newNode);

    final modelNode = ARKitReferenceNode(
        url: 'models.scnassets/dash.dae',
        position: vector.Vector3(0, 0, -1.0),
        scale: vector.Vector3.all(0.3));

    arKitController.add(modelNode);
  }
}

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
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
        onPressed: _incrementCounter,
        tooltip: 'AddObject',
        child: const Icon(Icons.add),
      ),
    );
  }

  late ARKitController arKitController;
  void onARKitViewCreated(ARKitController controller) {
    arKitController = controller;
    arKitController.addCoachingOverlay(CoachingOverlayGoal.horizontalPlane);

    final newNode = ARKitNode(
        geometry: ARKitSphere(radius: 0.25),
        position: vector.Vector3(0, 0, -1.0));

    arKitController.add(newNode);
  }
}

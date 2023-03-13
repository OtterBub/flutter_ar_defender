import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:collection/collection.dart';

class ARFrame {
  Map<String, ARKitNode> objectMap = <String, ARKitNode>{};
  late ARKitController arKitController;
  bool firstPositioning = false;
  bool positionHeight = false;
  double zNodePosition = -0.5;
  double yNodePosition = 0;
  Vector3 cameraDirect = Vector3(0, 0, 0);
  Vector3 hitTestTranslate = Vector3(0, 0, 0);

  void dispose() {
    objectMap.clear();
  }

  void init(ARKitController controller) {
    arKitController = controller;

    movingNode = ARKitReferenceNode(
        name: "main object",
        url:
            'models.scnassets/generator/Emergency_Backup_Generator-(COLLADA_3 (COLLAborative Design Activity)).dae',
        position: Vector3(0, 0, -1.0),
        scale: Vector3.all(0.1));
    addNode(movingNode!);
  }

  void run() {}

  bool busyUpdate = false;
  ARKitNode? movingNode;
  void update(double time) {
    if (busyUpdate) return;
    busyUpdate = true;

    arKitController.pointOfViewTransform().then(
      (value) {
        Vector3 rotateForward = value!.forward;
        rotateForward.y = 0;
        rotateForward.normalize();
        cameraDirect = rotateForward;
      },
    );
    arKitController.performHitTest(x: 0.5, y: 0.7).then(_arHitResult);

    Vector3 position = hitTestTranslate + (cameraDirect * zNodePosition);
    position.y = position.y + yNodePosition;

    movingNode!.transform.setTranslation(position);
    arKitController.update(movingNode!.name, node: movingNode);

    busyUpdate = false;
  }

  void _arHitResult(List<ARKitTestResult> resultList) {
    if (resultList.isEmpty) return;

    final point = resultList.firstWhereOrNull(
      (o) => o.type == ARKitHitTestResultType.featurePoint,
    );

    if (point == null) return;

    hitTestTranslate = Vector3(
      point.worldTransform.getColumn(3).x,
      point.worldTransform.getColumn(3).y,
      point.worldTransform.getColumn(3).z,
    );
  }

  void pressedAddBtn(String btnName) {
    if (btnName.compareTo("add") == 0) {
      if (firstPositioning == false) {
        movingNode = ARKitReferenceNode(
            url: 'models.scnassets/arrow_skpark.dae', scale: Vector3.all(0.1));

        addNode(movingNode!);

        firstPositioning = false;
      }
    } else if (btnName.compareTo("height") == 0) {
      positionHeight = !positionHeight;
    }
  }

  void addNode(ARKitNode node) {
    objectMap.addAll({node.name: node});
    node.transform.setTranslation(movingNode!.transform.getTranslation());
    arKitController.add(node);
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    const positionSpeed = 0.01;
    if (positionHeight) {
      if (details.delta.direction > 0) {
        // down
        yNodePosition -= details.delta.distance * positionSpeed;
      } else {
        // up
        yNodePosition += details.delta.distance * positionSpeed;
      }
    } else {
      if (details.delta.direction > 0) {
        // down
        zNodePosition += details.delta.distance * positionSpeed;
      } else {
        // up
        zNodePosition -= details.delta.distance * positionSpeed;
      }
    }
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    const rotateSpeed = 0.01;
    if (details.delta.direction > 0) {
      // left
      movingNode!.transform.rotateY(-details.delta.distance * rotateSpeed);
    } else {
      // right
      movingNode!.transform.rotateY(details.delta.distance * rotateSpeed);
    }
  }
}

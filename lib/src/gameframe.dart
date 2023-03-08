import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:collection/collection.dart';

class GameFrame {
  Map<String, ARKitNode> objectMap = <String, ARKitNode>{};
  late ARKitController arKitController;

  void init(ARKitController controller) {
    arKitController = controller;
  }

  void run() {}

  bool busyUpdate = false;
  ARKitNode? movingNode;
  void update(double time) {
    if (busyUpdate) return;
    busyUpdate = true;

    if (movingNode == null) {
      movingNode = ARKitNode(geometry: ARKitSphere(radius: 0.05));
      arKitController.add(movingNode!);
    }

    arKitController.performHitTest(x: 0.5, y: 0.7).then(_arHitResult);

    busyUpdate = false;
  }

  void _arHitResult(List<ARKitTestResult> resultList) {
    if (resultList.isEmpty) return;

    final point = resultList.firstWhereOrNull(
      (o) => o.type == ARKitHitTestResultType.featurePoint,
    );

    if (point == null) return;

    final position = Vector3(
      point.worldTransform.getColumn(3).x,
      point.worldTransform.getColumn(3).y,
      point.worldTransform.getColumn(3).z,
    );

    movingNode!.transform.setTranslation(position);
    arKitController.update(movingNode!.name, node: movingNode);
  }
}

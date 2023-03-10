import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:collection/collection.dart';

class ARFrame {
  Map<String, ARKitNode> objectMap = <String, ARKitNode>{};
  late ARKitController arKitController;
  bool firstPositioning = false;

  void dispose() {
    objectMap.clear();
  }

  void init(ARKitController controller) {
    arKitController = controller;

    // final newNode = ARKitNode(
    //     geometry: ARKitSphere(radius: 0.25),
    //     position: vector.Vector3(0, 0, -1.5));

    // arKitController.add(newNode);
    movingNode = ARKitReferenceNode(
        url:
            'models.scnassets/generator/Emergency_Backup_Generator-(COLLADA_3 (COLLAborative Design Activity)).dae',
        position: Vector3(0, 0, -1.0),
        scale: Vector3.all(0.1));
    arKitController.add(movingNode!);
  }

  void run() {}

  bool busyUpdate = false;
  ARKitNode? movingNode;
  void update(double time) {
    if (busyUpdate) return;
    busyUpdate = true;

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

  void pressedAddBtn() {
    if (firstPositioning == false) {
      // addNode(movingNode!);
      // arKitController.remove(movingNode!.name);

      movingNode = ARKitNode(geometry: ARKitSphere(radius: 0.05));
      arKitController.add(movingNode!);

      firstPositioning = false;
    }
  }

  void addNode(ARKitNode node) {
    objectMap.addAll({node.name: node});
    node.transform.setTranslation(movingNode!.transform.getTranslation());
    node.transform.rotateY(90);
    arKitController.add(node);
  }
}

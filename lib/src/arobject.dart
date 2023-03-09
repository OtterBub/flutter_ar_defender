import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart';

class ARObject {
  ARKitNode? node;

  void setNode(ARKitNode node) {
    if (this.node != null) this.node = node;
  }

  void update(double time) {}
}

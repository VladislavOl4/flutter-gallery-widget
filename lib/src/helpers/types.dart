import 'package:flutter_unity_widget/src/helpers/scene_loaded.dart';
import 'package:flutter_unity_widget/src/facade_controller.dart';

typedef void UnityCreatedCallback(UnityWidgetController controller);
typedef void UnityMessageCallback(dynamic handler);
typedef void UnityOrientationChangeCallback(dynamic handler);
typedef void GalleryIsReadyCallback(dynamic handler);
typedef void UnitySceneChangeCallback(SceneLoaded? message);
typedef void UnityUnloadCallback();

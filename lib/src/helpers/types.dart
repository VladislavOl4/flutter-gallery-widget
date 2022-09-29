import '../../src/helpers/scene_loaded.dart';
import '../../src/abstract_classes/facade_controller.dart';

typedef void UnityCreatedCallback(UnityWidgetController controller);
typedef void UnityMessageCallback(dynamic handler);
typedef void UnityGalleryStateChangeCallback(dynamic handler);
typedef void UnitySceneChangeCallback(SceneLoaded? message);
typedef void UnityUnloadCallback();

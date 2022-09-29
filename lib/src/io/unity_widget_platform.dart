import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'device_method.dart';

import '../abstract_classes/facade_platform.dart';

class WidgetPlatform {
  static UnityWidgetPlatform _instance = MethodChannelUnityWidget();
  /// The default instance of [UnityWidgetPlatform] to use.
  ///
  /// Defaults to [MethodChannelUnityWidgetFlutter].
  static UnityWidgetPlatform get instance => _instance;
  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [UnityWidgetPlatform] when they register themselves.
  static set instance(UnityWidgetPlatform instance) {
    PlatformInterface.verifyToken(instance, UnityWidgetPlatform.token);
    _instance = instance;
  }
}

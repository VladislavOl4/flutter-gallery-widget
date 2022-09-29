import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../abstract_classes/facade_controller.dart';
import '../helpers/events.dart';
import 'device_method.dart';
import 'unity_widget.dart';
import '../io/unity_widget_platform.dart';

class MobileUnityWidgetController extends UnityWidgetController {
  final MobileUnityWidgetState _unityWidgetState;

  /// The unityId for this controller
  final int unityId;

  /// used for cancel the subscription
  StreamSubscription? _onUnityMessageSub,
      _onUnityGalleryStateChangeSub,
      _onUnitySceneLoadedSub,
      _onUnityUnloadedSub;

  MobileUnityWidgetController._(this._unityWidgetState,
      {required this.unityId}) {
    _connectStreams(unityId);
  }

  /// Initialize [UnityWidgetController] with [id]
  /// Mainly for internal use when instantiating a [UnityWidgetController] passed
  /// in [UnityWidget.onUnityCreated] callback.
  static Future<MobileUnityWidgetController> init(
      int id, MobileUnityWidgetState unityWidgetState) async {
    await WidgetPlatform.instance.init(id);
    return MobileUnityWidgetController._(
      unityWidgetState,
      unityId: id,
    );
  }

  @visibleForTesting
  MethodChannel? get channel {
    if (WidgetPlatform.instance is MethodChannelUnityWidget) {
      return (WidgetPlatform.instance as MethodChannelUnityWidget)
          .channel(unityId);
    }
    return null;
  }

  void _connectStreams(int unityId) {
    if (_unityWidgetState.widget.onUnityMessage != null) {
      _onUnityMessageSub = WidgetPlatform.instance
          .onUnityMessage(unityId: unityId)
          .listen((UnityMessageEvent e) =>
              _unityWidgetState.widget.onUnityMessage!(e.value));
    }

    if (_unityWidgetState.widget.onUnityGalleryStateChange != null) {
      _onUnityGalleryStateChangeSub = WidgetPlatform.instance
          .onUnityGalleryStateChange(unityId: unityId)
          .listen((UnityGalleryStateChangeEvent e) =>
              _unityWidgetState.widget.onUnityGalleryStateChange!(e.value));
    }

    if (_unityWidgetState.widget.onUnitySceneLoaded != null) {
      _onUnitySceneLoadedSub = WidgetPlatform.instance
          .onUnitySceneLoaded(unityId: unityId)
          .listen((UnitySceneLoadedEvent e) =>
              _unityWidgetState.widget.onUnitySceneLoaded!(e.value));
    }

    if (_unityWidgetState.widget.onUnityUnloaded != null) {
      _onUnityUnloadedSub = WidgetPlatform.instance
          .onUnityUnloaded(unityId: unityId)
          .listen((_) => _unityWidgetState.widget.onUnityUnloaded!());
    }
  }

  /// Checks to see if unity player is ready to be used
  /// Returns `true` if unity player is ready.
  Future<bool?>? isReady() {
    if (!_unityWidgetState.widget.enablePlaceholder) {
      return WidgetPlatform.instance.isReady(unityId: unityId);
    }
    return null;
  }

  /// Get the current pause state of the unity player
  /// Returns `true` if unity player is paused.
  Future<bool?>? isPaused() {
    if (!_unityWidgetState.widget.enablePlaceholder) {
      return WidgetPlatform.instance.isPaused(unityId: unityId);
    }
    return null;
  }

  /// Get the current load state of the unity player
  /// Returns `true` if unity player is loaded.
  Future<bool?>? isLoaded() {
    if (!_unityWidgetState.widget.enablePlaceholder) {
      return WidgetPlatform.instance.isLoaded(unityId: unityId);
    }
    return null;
  }

  /// Helper method to know if Unity has been put in background mode (WIP) unstable
  /// Returns `true` if unity player is in background.
  Future<bool?>? inBackground() {
    if (!_unityWidgetState.widget.enablePlaceholder) {
      return WidgetPlatform.instance.inBackground(unityId: unityId);
    }
    return null;
  }

  /// Creates a unity player if it's not already created. Please only call this if unity is not ready,
  /// or is in unloaded state. Use [isLoaded] to check.
  /// Returns `true` if unity player was created succesfully.
  Future<bool?>? create() {
    if (!_unityWidgetState.widget.enablePlaceholder) {
      return WidgetPlatform.instance.createUnityPlayer(unityId: unityId);
    }
    return null;
  }

  /// Post message to unity from flutter. This method takes in a string [message].
  /// The [gameObject] must match the name of an actual unity game object in a scene at runtime, and the [methodName],
  /// must exist in a `MonoDevelop` `class` and also exposed as a method. [message] is an parameter taken by the method
  ///
  /// ```dart
  /// postMessage("GameManager", "openScene", "ThirdScene")
  /// ```
  Future<void>? postMessage(String gameObject, methodName, message) {
    if (!_unityWidgetState.widget.enablePlaceholder) {
      return WidgetPlatform.instance.postMessage(
        unityId: unityId,
        gameObject: gameObject,
        methodName: methodName,
        message: message,
      );
    }
    return null;
  }

  /// Post message to unity from flutter. This method takes in a Json or map structure as the [message].
  /// The [gameObject] must match the name of an actual unity game object in a scene at runtime, and the [methodName],
  /// must exist in a `MonoDevelop` `class` and also exposed as a method. [message] is an parameter taken by the method
  ///
  /// ```dart
  /// postJsonMessage("GameManager", "openScene", {"buildIndex": 3, "name": "ThirdScene"})
  /// ```
  Future<void>? postJsonMessage(
      String gameObject, String methodName, Map<String, dynamic> message) {
    if (!_unityWidgetState.widget.enablePlaceholder) {
      return WidgetPlatform.instance.postJsonMessage(
        unityId: unityId,
        gameObject: gameObject,
        methodName: methodName,
        message: message,
      );
    }
    return null;
  }

  /// Pause the unity in-game player with this method
  Future<void>? pause() {
    if (!_unityWidgetState.widget.enablePlaceholder) {
      return WidgetPlatform.instance.pausePlayer(unityId: unityId);
    }
    return null;
  }

  /// Resume the unity in-game player with this method idf it is in a paused state
  Future<void>? resume() {
    if (!_unityWidgetState.widget.enablePlaceholder) {
      return WidgetPlatform.instance.resumePlayer(unityId: unityId);
    }
    return null;
  }

  /// Sometimes you want to open unity in it's own process and openInNativeProcess does just that.
  /// It works for Android and iOS is WIP
  Future<void>? openInNativeProcess() {
    if (!_unityWidgetState.widget.enablePlaceholder) {
      return WidgetPlatform.instance.openInNativeProcess(unityId: unityId);
    }
    return null;
  }

  /// Unloads unity player from th current process (Works on Android only for now)
  /// iOS is WIP. For more information please read [Unity Docs](https://docs.unity3d.com/2020.2/Documentation/Manual/UnityasaLibrary.html)
  Future<void>? unload() {
    if (!_unityWidgetState.widget.enablePlaceholder) {
      return WidgetPlatform.instance.unloadPlayer(unityId: unityId);
    }
    return null;
  }

  /// Quits unity player. Note that this kills the current flutter process, thus quiting the app
  Future<void>? quit() {
    if (!_unityWidgetState.widget.enablePlaceholder) {
      return WidgetPlatform.instance.quitPlayer(unityId: unityId);
    }
    return null;
  }

  Future<void>? galleryProfileDidLoad(Map<String, dynamic> message) {
    if (!_unityWidgetState.widget.enablePlaceholder) {
      return WidgetPlatform.instance.galleryProfileDidLoad(
        unityId: unityId,
        message: message,
      );
    }
    return null;
  }

  Future<void>? sneakersDidLoad(Map<String, dynamic> message) {
    if (!_unityWidgetState.widget.enablePlaceholder) {
      return WidgetPlatform.instance.sneakersDidLoad(
        unityId: unityId,
        message: message,
      );
    }
    return null;
  }

  /// cancel the subscriptions when dispose called
  void _cancelSubscriptions() {
    _onUnityMessageSub?.cancel();
    _onUnityGalleryStateChangeSub?.cancel();
    _onUnitySceneLoadedSub?.cancel();
    _onUnityUnloadedSub?.cancel();

    _onUnityMessageSub = null;
    _onUnityGalleryStateChangeSub = null;
    _onUnitySceneLoadedSub = null;
    _onUnityUnloadedSub = null;
  }

  void dispose() {
    _cancelSubscriptions();
    WidgetPlatform.instance.dispose(unityId: unityId);
  }
}

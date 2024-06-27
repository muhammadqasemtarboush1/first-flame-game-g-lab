import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../brick_breaker.dart';

// class PlayArea extends RectangleComponent with HasGameReference<BrickBreaker> {
//   PlayArea()
//       : super(
//           paint: Paint()..color = const Color(0xfff2e8cf),
//           children: [RectangleHitbox()],
//         );

//   @override
//   FutureOr<void> onLoad() async {
//     super.onLoad();
//     size = Vector2(game.width, game.height);
//   }
// }

class PlayArea extends RectangleComponent with HasGameReference<BrickBreaker> {
  late SpriteComponent backgroundSpriteComponent;

  PlayArea()
      : super(
          paint: Paint()..color = const Color(0xfff2e8cf),
          children: [RectangleHitbox()],
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    size = Vector2(game.width, game.height);

    // Load the background sprite
    final backgroundSprite = await Sprite.load('background.jpg');

    // Create a SpriteComponent for the background and set its size to fill the play area
    backgroundSpriteComponent = SpriteComponent(
      sprite: backgroundSprite,
      size: size,
    );

    // Add the background sprite component to this component
    add(backgroundSpriteComponent);
  }
}

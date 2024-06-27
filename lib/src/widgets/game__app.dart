import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flame_audio/flame_audio.dart';

import '../brick_breaker.dart';
import '../config.dart';
import 'overlay_screen.dart';
import 'score_card.dart';

// class GameApp extends StatefulWidget {
//   const GameApp({super.key});

//   @override
//   State<GameApp> createState() => _GameAppState();
// }

// class _GameAppState extends State<GameApp> {
//   final BrickBreaker game = BrickBreaker();
//   String playText = 'Music OFF';

//   @override
//   void initState() {
//     super.initState();
//     _loadAudio();
//   }

//   Future<void> _loadAudio() async {
//     await FlameAudio.audioCache.loadAll([
//       'sfx/bricks_hit.mp3',
//       'sfx/hit_bat.mp3',
//       'bgm.mp3',
//     ]);
//     FlameAudio.bgm.play('bgm.mp3', volume: 0.1);
//   }

//   void stopAllFlameAudio() {
//     FlameAudio.bgm.stop();
//     FlameAudio.audioCache.clearAll();
//   }

//   @override
//   void dispose() {
//     stopAllFlameAudio();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         textTheme: GoogleFonts.pressStart2pTextTheme().apply(
//           bodyColor: const Color(0xff184e77),
//           displayColor: const Color(0xff184e77),
//         ),
//       ),
//       home: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color(0xffa9d6e5),
//                 Color(0xfff2e8cf),
//               ],
//             ),
//           ),
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Center(
//                 child: Column(
//                   children: [
//                     ScoreCard(score: game.score),
//                     Expanded(
//                       child: FittedBox(
//                         child: SizedBox(
//                           width: gameWidth,
//                           height: gameHeight,
//                           child: GameWidget(
//                             game: game,
//                             overlayBuilderMap: {
//                               PlayState.welcome.name: (context, game) =>
//                                   const OverlayScreen(
//                                     title: 'TAP TO PLAY',
//                                     subtitle: 'Use arrow keys or swipe',
//                                   ),
//                               PlayState.gameOver.name: (context, game) =>
//                                   const OverlayScreen(
//                                     title: 'G A M E   O V E R',
//                                     subtitle: 'Tap to Play Again',
//                                   ),
//                               PlayState.won.name: (context, game) =>
//                                   const OverlayScreen(
//                                     title: 'Y O U   W O N ! ! !',
//                                     subtitle: 'Tap to Play Again',
//                                   ),
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                         onTap: () {
//                           if (FlameAudio.bgm.isPlaying) {
//                             playText = 'Music ON';
//                             FlameAudio.bgm.pause();
//                           } else {
//                             playText = 'Music OFF';
//                             FlameAudio.bgm.play('bgm.mp3', volume: 0.08);
//                           }
//                           setState(() {});
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.all(8.0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.0),
//                             color: Colors.grey[200],
//                           ),
//                           child: Text(playText),
//                         ))
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> with WidgetsBindingObserver {
  final BrickBreaker game = BrickBreaker();
  String playText = 'Music ON';

  @override
  void initState() {
    super.initState();
    FlameAudio.bgm.stop();

    WidgetsBinding.instance.addObserver(this);
    _loadAudio();
  }

  Future<void> _loadAudio() async {
    await FlameAudio.audioCache.loadAll([
      'sfx/bricks_hit.mp3',
      'sfx/hit_bat.mp3',
    ]);
    // FlameAudio.bgm.play('bgm.mp3', volume: 0.1);
  }

  void stopAllFlameAudio() {
    FlameAudio.bgm.stop();
    FlameAudio.audioCache.clearAll();
  }

  @override
  void dispose() {
    stopAllFlameAudio();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      FlameAudio.bgm.pause();
    } else if (state == AppLifecycleState.resumed) {
      FlameAudio.bgm.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: const Color(0xff184e77),
          displayColor: const Color(0xff184e77),
        ),
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffa9d6e5),
                Color(0xfff2e8cf),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    ScoreCard(score: game.score),
                    Expanded(
                      child: FittedBox(
                        child: SizedBox(
                          width: gameWidth,
                          height: gameHeight,
                          child: GameWidget(
                            game: game,
                            overlayBuilderMap: {
                              PlayState.welcome.name: (context, game) =>
                                  const OverlayScreen(
                                    title: 'TAP TO PLAY',
                                    subtitle: 'Use arrow keys or swipe',
                                  ),
                              PlayState.gameOver.name: (context, game) =>
                                  const OverlayScreen(
                                    title: 'G A M E   O V E R',
                                    subtitle: 'Tap to Play Again',
                                  ),
                              PlayState.won.name: (context, game) =>
                                  const OverlayScreen(
                                    title: 'Y O U   W O N ! ! !',
                                    subtitle: 'Tap to Play Again',
                                  ),
                            },
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (FlameAudio.bgm.isPlaying) {
                          playText = 'Music ON';
                          FlameAudio.bgm.pause();
                        } else {
                          playText = 'Music OFF';
                          FlameAudio.bgm.play('bgm.mp3', volume: 0.08);
                        }
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[200],
                        ),
                        child: Text(playText),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

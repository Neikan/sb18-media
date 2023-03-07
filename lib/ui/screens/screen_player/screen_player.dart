// Flutter imports:
import 'package:app_media/ui/components/ui_loader.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:video_player/video_player.dart';

// Project imports:
import 'package:app_media/consts/urls.dart';
import 'package:app_media/ui/components/ui_header.dart';

class ScreenPlayer extends StatefulWidget {
  const ScreenPlayer({super.key});

  @override
  State<ScreenPlayer> createState() => _ScreenPlayerState();
}

class _ScreenPlayerState extends State<ScreenPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(videoUrl);
    // _controller = VideoPlayerController.asset(videoLocal);

    _controller.addListener(() {
      setState(() {});
    });

    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UiHeader(
        title: 'Player',
      ),
      body: SafeArea(
        child: _controller.value.isInitialized
            ? Stack(
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      children: [
                        VideoPlayer(_controller),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              backgroundColor: Colors.green.shade100,
                              bufferedColor: Colors.green.shade200,
                              playedColor: Colors.green,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 16.0,
                            bottom: 16,
                            left: 16.0,
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.green.withOpacity(0.5),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => _controller.seekTo(
                                      Duration(
                                        seconds: _controller
                                                .value.position.inSeconds -
                                            10,
                                      ),
                                    ),
                                    icon: const Icon(Icons.replay_10),
                                  ),
                                  _controller.value.isPlaying
                                      ? IconButton(
                                          onPressed: _controller.pause,
                                          icon: const Icon(Icons.pause),
                                        )
                                      : IconButton(
                                          onPressed: _controller.play,
                                          icon: const Icon(Icons.play_arrow),
                                        ),
                                  IconButton(
                                    onPressed: () => _controller
                                        .seekTo(const Duration(seconds: 10)),
                                    icon: const Icon(Icons.forward_10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const UiLoader(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}

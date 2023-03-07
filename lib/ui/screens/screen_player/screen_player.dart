// Flutter imports:
import 'dart:async';

import 'package:app_media/ui/components/ui_button.dart';
import 'package:app_media/ui/components/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Package imports:
import 'package:video_player/video_player.dart';

// Project imports:
import 'package:app_media/consts/urls.dart';
import 'package:app_media/ui/components/ui_header.dart';
import 'package:app_media/ui/components/ui_loader.dart';

part 'components/ui_button_play.dart';
part 'components/ui_controls.dart';
part 'components/ui_slider.dart';

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

    // _controller = VideoPlayerController.asset(videoLocal);
    _controller = VideoPlayerController.network(videoUrl)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((_) => setState(() {}))
      ..play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const UiHeader(title: 'Player'),
      body: SafeArea(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(_controller),
                    UiControls(controller: _controller),
                  ],
                ),
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

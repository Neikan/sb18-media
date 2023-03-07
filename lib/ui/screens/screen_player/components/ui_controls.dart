part of '../screen_player.dart';

class UiControls extends StatefulWidget {
  final VideoPlayerController controller;

  const UiControls({
    super.key,
    required this.controller,
  });

  @override
  State<UiControls> createState() => UiControlsState();
}

class UiControlsState extends State<UiControls> {
  bool _isPlaying = true;
  bool _isShowControls = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (_) => _handleTap(),
      onTapDown: (_) => _handleTap(),
      child: Visibility(
        visible: _isShowControls,
        replacement: const SizedBox.expand(),
        child: Stack(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UiButton(
                    icon: Icons.replay_10,
                    onPressed: () => _handleSeekTo(seconds: -10),
                  ),
                  UiButtonPlay(
                    isPlaying: _isPlaying,
                    onPressed: _handlePlay,
                  ),
                  UiButton(
                    icon: Icons.forward_10,
                    onPressed: _handleSeekTo,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: UiSlider(controller: widget.controller),
            ),
          ],
        ),
      ),
    );
  }

  Duration _handleDelay({int delay = 3}) => Duration(seconds: delay);

  void _handleTap() {
    setState(() {
      _isShowControls = !_isShowControls;
    });

    Future.delayed(_handleDelay(), () {
      if (_isPlaying) {
        _handleAutoHideControls();
      }
    });
  }

  void _handleAutoHideControls() {
    if (_isShowControls) {
      Timer(_handleDelay(), () {
        setState(() => _isShowControls = false);
      });
    }
  }

  void _handlePlay() {
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();

      setState(() {
        _isPlaying = false;
      });
    } else {
      widget.controller.play();

      setState(() {
        _isPlaying = true;
      });

      _handleAutoHideControls();
    }
  }

  void _handleSeekTo({int seconds = 10}) {
    widget.controller.seekTo(
      Duration(seconds: widget.controller.value.position.inSeconds + seconds),
    );

    _handleAutoHideControls();
  }
}

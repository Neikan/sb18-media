part of '../screen_player.dart';

class UiSlider extends StatelessWidget {
  final VideoPlayerController controller;

  const UiSlider({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final duration = controller.value.duration;
    final position = controller.value.position;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Slider.adaptive(
          value: position.inMilliseconds / duration.inMilliseconds,
          onChanged: (value) =>
              controller.seekTo(controller.value.duration * value),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UiText(text: _formatDuration(position)),
              UiText(text: _formatDuration(duration)),
            ],
          ),
        ),
      ],
    );
  }

  static String _formatDuration(Duration duration) {
    NumberFormat formatter = NumberFormat('00');

    final minutes = formatter.format(duration.inMinutes);
    final seconds = formatter.format(duration.inSeconds % 60);

    return '$minutes:$seconds';
  }
}

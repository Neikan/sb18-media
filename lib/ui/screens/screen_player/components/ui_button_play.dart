part of '../screen_player.dart';

class UiButtonPlay extends StatelessWidget {
  final bool isPlaying;
  final void Function() onPressed;

  const UiButtonPlay({
    super.key,
    required this.isPlaying,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: UiButton(
        icon: isPlaying ? Icons.pause : Icons.play_arrow,
        onPressed: onPressed,
      ),
    );
  }
}

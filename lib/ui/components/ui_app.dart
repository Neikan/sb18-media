// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app_media/ui/screens/screen_player/screen_player.dart';
import 'package:app_media/ui/styles/themes.dart';

class UiApp extends StatelessWidget {
  const UiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTheme,
      debugShowCheckedModeBanner: false,
      home: const ScreenPlayer(),
    );
  }
}

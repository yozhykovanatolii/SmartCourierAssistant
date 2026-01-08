import 'package:flutter/material.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: false,
      activeTrackColor: Colors.green,
      activeThumbColor: Colors.white,
      onChanged: (isDarkMode) {},
    );
  }
}

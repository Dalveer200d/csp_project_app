import 'package:flutter/material.dart';
import 'package:csp_project_app/themes/app_theme.dart';
import 'package:provider/provider.dart';

class ThemeIcon extends StatefulWidget {
  const ThemeIcon({super.key});

  @override
  State<ThemeIcon> createState() => _ThemeIconState();
}

class _ThemeIconState extends State<ThemeIcon> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppTheme>(context);

    return IconButton(
      onPressed: () {
        provider.toggleTheme();
      },
      icon: provider.isLight
          ? Icon(Icons.wb_sunny_outlined)
          : Icon(Icons.nightlight_round_outlined),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: SettingApp()));

class SettingApp extends StatefulWidget {
  const SettingApp({super.key});
  State<SettingApp> createState() => _SettingAppState();
}

class _SettingAppState extends State<SettingApp> {
  bool on = false;

  Widget build(BuildContext context) => Scaffold(
    body: Center(child: SwitchListTile(
      title: Text(on ? 'ON' : 'OFF'),
      value: on,
      onChanged: (v) => setState(() => on = v),
    )),
  );
}
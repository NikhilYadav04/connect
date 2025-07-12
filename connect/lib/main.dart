import 'package:connect/http/utils/http_client.dart';
import 'package:flutter/material.dart';
import 'package:connect/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
  await HttpClient().init();

  runApp(const MyApp());
}

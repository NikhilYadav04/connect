import 'package:expert/app.dart';
import 'package:expert/http/utils/http_client.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));

    await HttpClient().init();

  runApp(const MyApp());
}

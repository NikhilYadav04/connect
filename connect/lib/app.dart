import 'package:connect/controller/dummy.dart';
import 'package:connect/core/router/appRouter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:  [
      ChangeNotifierProvider(create: (_)=>ProviderDummy(),)
    ],
    child: MaterialApp(
      title: 'PeerConnect',
      debugShowCheckedModeBanner: false,
      initialRoute: '/landing_screen',
      onGenerateRoute: generateRoute,
    ),
    );
  }
}
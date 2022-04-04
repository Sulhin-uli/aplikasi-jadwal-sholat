import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/application/jadwal_sholat_provider.dart';
import 'package:schedule_app/presentation/home/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ChangeNotifierProvider(
        create: (context) => JadwalSholatProvider(),
        child: HomePage(),
      ),
    );
  }
}

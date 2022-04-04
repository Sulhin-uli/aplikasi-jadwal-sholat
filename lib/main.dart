import 'package:flutter/material.dart';
import 'package:schedule_app/presentation/app_widget.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(AppWidget()));
}

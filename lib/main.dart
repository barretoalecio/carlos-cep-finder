import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app/core/utils/configuration/hive_initialization.dart';
import 'app/modules/app_module.dart';
import 'app/modules/app_widget.dart';

Future<void> loadEnviromentVariables() async {
  await dotenv.load(fileName: '.env');
}

Future<void> main() async {
  await loadEnviromentVariables();
  WidgetsFlutterBinding.ensureInitialized();
  hiveInitialization(
    onInitialized: () => runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    ),
  );
}

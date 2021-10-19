import 'package:flutter/material.dart';
import 'package:flutter_bloc_learn/src/injection/injection.dart';
import 'src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  runApp(const App());
}

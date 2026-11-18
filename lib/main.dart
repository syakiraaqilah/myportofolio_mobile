import 'package:material_ui/material_ui.dart';
import 'screens/menu.dart';
import 'theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      theme: AppTheme.light,
      home: MyHomePage(),
    );
  }
}
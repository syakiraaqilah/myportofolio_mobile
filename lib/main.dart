import 'package:material_ui/material_ui.dart';
import 'screens/menu.dart';
import 'theme.dart';
import '../services/api_client.dart';
import '../services/auth_state.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp(apiClient: ApiClient()));

class MyApp extends StatelessWidget {
  const MyApp({required this.apiClient, super.key});

  final ApiClient apiClient;   

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: apiClient),
        ChangeNotifierProvider(create: (_) => AuthState(apiClient)),
      ],
      child: MaterialApp(
        title: 'MyPortfolio',
        theme: AppTheme.light,
        home: MyHomePage(),
      ),
    );
  }
}
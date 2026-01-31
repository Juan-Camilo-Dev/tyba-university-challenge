import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'injection_container.dart' as di;
import 'presentation/providers/university_provider.dart';

// import 'presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Inicializamos la inyección de dependencias
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<UniversityProvider>()),
      ],
      child: MaterialApp(
        title: 'Tyba University Explorer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Colores
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.indigo,
            elevation: 0,
            centerTitle: true,
          ),
          useMaterial3: false,
        ),
        home: const Scaffold(body: Center(child: Text("Building..."))),
      ),
    );
  }
}
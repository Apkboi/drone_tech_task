import 'package:drone_tech_task/providers/drone_provider.dart';
import 'package:drone_tech_task/presenter/screens/drone_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DroneProvider>(
          create: (context) => DroneProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Drone tech',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DronesScreen(),
      ),
    );
  }
}

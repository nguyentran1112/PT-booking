import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/firebase_options.dart';
import 'package:fitness/routing/routing.dart';
import 'package:fitness/screen/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:fitness/screen/users/bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthenticationBloc(),
          ),
        BlocProvider(
          create: (context) => UsersBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
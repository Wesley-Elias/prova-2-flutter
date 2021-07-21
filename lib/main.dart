import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './api/api.dart';
import './helpers/helpers.dart';

import 'screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ListaArtistas(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CadastrarArtista(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => DeletarArtista(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => EditarArtista(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => EditarArtista(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ListaMusicas(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CadastrarMusicas(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => EditarMusicas(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => DeletarMusicas(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Avaliação 2',
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

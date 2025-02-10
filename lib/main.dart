import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/core/theme.dart';
import 'package:sola/data/database/database_helper.dart';
import 'package:sola/data/datasources/bus_db.dart';
import 'package:sola/data/repositories/bus_repository.dart';
import 'package:sola/presentation/features/home/home_screen.dart';
import 'package:sola/presentation/providers/bus_providers.dart';

import 'package:sqflite/sqflite.dart';  // Pour gérer SQLite
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';         // Pour manipuler les chemins de fichiers

void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  final dbPath = join(await getDatabasesPath(), 'transport.db');
  await deleteDatabase(dbPath); // Supprime l'ancienne base
  final db =await DatabaseHelper().database ;
  final busDB = BusDB(db);
  final busRepository = BusRepository(busDB);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BusProvider(busRepository)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOLA',
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
    );
  }
}

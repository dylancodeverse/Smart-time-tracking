import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/core/theme.dart';
import 'package:sola/data/datasources/active_bus_db.dart';
import 'package:sola/data/localdatabase/access_helper.dart';
import 'package:sola/data/localdatabase/database_helper.dart';
import 'package:sola/data/repositories/active_bus_repository.dart';
import 'package:sola/presentation/features/home/home_screen.dart';
import 'package:sola/presentation/providers/active_bus_list_provider.dart';

import 'package:sqflite/sqflite.dart';  // Pour gérer SQLite

void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  final dbPath = await DBAccess.getDbPath();
  // await deleteDatabase(dbPath); // Supprime l'ancienne base
  final db =await DatabaseHelper().database ;
  final activeBusDB = ActiveBusDB(db);
  final activeBusRepository = ActiveBusRepository(activeBusDB);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ActiveBusListProvider(activeBusRepository)), // 🔹 Gestion de la liste
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

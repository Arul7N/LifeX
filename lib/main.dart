import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Only initialize database on mobile platforms (not web)
  if (!kIsWeb) {
    try {
      await DatabaseService.instance.initDatabase();
    } catch (e) {
      print('Database initialization failed: $e');
    }
  }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FamilyProvider()),
      ],
      child: MaterialApp(
        title: 'Family Health App',
        theme: AppTheme.lightTheme,
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class FamilyProvider extends ChangeNotifier {
  final List<FamilyMember> _members = [];
  
  List<FamilyMember> get members => _members;
  
  void addMember(FamilyMember member) {
    _members.add(member);
    notifyListeners();
  }
}

class FamilyMember {
  final String id;
  final String name;
  final String role;
  final DateTime dateOfBirth;
  
  FamilyMember({
    required this.id,
    required this.name,
    required this.role,
    required this.dateOfBirth,
  });
}
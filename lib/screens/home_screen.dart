import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../theme/app_theme.dart';
import 'family_sharing_screen.dart';
import 'medical_records_screen.dart';
import 'checkups_screen.dart';
import 'reminders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    FamilySharingScreen(),
    MedicalRecordsScreen(),
    CheckupsScreen(),
    RemindersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Health'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: AppTheme.primaryBlue,
        unselectedItemColor: AppTheme.neutral500,
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.accountGroup),
            label: 'Family',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.fileDocument),
            label: 'Records',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.stethoscope),
            label: 'Check-ups',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.bell),
            label: 'Reminders',
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../theme/app_theme.dart';

class CheckupsScreen extends StatefulWidget {
  const CheckupsScreen({super.key});

  @override
  _CheckupsScreenState createState() => _CheckupsScreenState();
}

class _CheckupsScreenState extends State<CheckupsScreen> {
  final List<Map<String, dynamic>> _checkups = [
    {
      'title': 'Annual Physical Exam',
      'member': 'John Doe',
      'date': '2024-01-15',
      'doctor': 'Dr. Smith',
      'status': 'Completed',
      'hasComparison': true,
      'recommendations': [
        'Increase daily exercise',
        'Reduce sodium intake',
        'Schedule follow-up in 6 months'
      ],
    },
    {
      'title': 'Blood Pressure Check',
      'member': 'Jane Doe',
      'date': '2024-01-20',
      'doctor': 'Dr. Johnson',
      'status': 'Scheduled',
      'hasComparison': false,
      'recommendations': [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Check-ups',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ElevatedButton.icon(
                onPressed: _showScheduleDialog,
                icon: Icon(Icons.add),
                label: Text('Schedule'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Card(
            color: AppTheme.lightBlue.withOpacity(0.1),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(MdiIcons.brain, color: AppTheme.primaryBlue),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Health Analysis',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Compare reports and get personalized recommendations',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _checkups.length,
              itemBuilder: (context, index) {
                final checkup = _checkups[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor: _getStatusColor(checkup['status']),
                      child: Icon(
                        _getStatusIcon(checkup['status']),
                        color: Colors.white,
                      ),
                    ),
                    title: Text(checkup['title']),
                    subtitle: Text('${checkup['member']} • ${checkup['date']}'),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Icon(MdiIcons.doctor),
                              title: Text('Doctor'),
                              subtitle: Text(checkup['doctor']),
                            ),
                            if (checkup['hasComparison']) ...[
                              SizedBox(height: 16),
                              Text(
                                'AI Recommendations',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primaryBlue,
                                ),
                              ),
                              SizedBox(height: 8),
                              ...checkup['recommendations'].map<Widget>((rec) => 
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    children: [
                                      Icon(
                                        MdiIcons.checkCircle,
                                        size: 16,
                                        color: AppTheme.successGreen,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(child: Text(rec)),
                                    ],
                                  ),
                                ),
                              ).toList(),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () => _showComparison(checkup),
                                      icon: Icon(MdiIcons.compare),
                                      label: Text('View Comparison'),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () {},
                                      icon: Icon(MdiIcons.upload),
                                      label: Text('Upload Report'),
                                    ),
                                  ),
                                ],
                              ),
                            ] else ...[
                              SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(MdiIcons.upload),
                                label: Text('Upload Report'),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return AppTheme.successGreen;
      case 'Scheduled':
        return AppTheme.warningYellow;
      case 'Overdue':
        return AppTheme.errorRed;
      default:
        return AppTheme.neutral500;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Completed':
        return MdiIcons.checkCircle;
      case 'Scheduled':
        return MdiIcons.clock;
      case 'Overdue':
        return MdiIcons.alertCircle;
      default:
        return MdiIcons.calendar;
    }
  }

  void _showScheduleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Schedule Check-up'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Check-up Type'),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Doctor'),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Date',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Schedule'),
          ),
        ],
      ),
    );
  }

  void _showComparison(Map<String, dynamic> checkup) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Health Comparison',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Blood Pressure'),
                        Row(
                          children: [
                            Text('120/80', style: TextStyle(color: AppTheme.successGreen)),
                            Icon(MdiIcons.arrowUp, color: AppTheme.errorRed, size: 16),
                            Text('130/85', style: TextStyle(color: AppTheme.errorRed)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Cholesterol'),
                        Row(
                          children: [
                            Text('180', style: TextStyle(color: AppTheme.warningYellow)),
                            Icon(MdiIcons.arrowDown, color: AppTheme.successGreen, size: 16),
                            Text('165', style: TextStyle(color: AppTheme.successGreen)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'AI Analysis',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Card(
              color: AppTheme.successGreen.withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Your cholesterol levels have improved significantly. However, blood pressure needs attention. Consider reducing salt intake and increasing physical activity.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../theme/app_theme.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  _RemindersScreenState createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  final List<Map<String, dynamic>> _reminders = [
    {
      'title': 'Take Blood Pressure Medication',
      'member': 'John Doe',
      'time': '08:00 AM',
      'type': 'Medicine',
      'isCompleted': false,
      'frequency': 'Daily',
    },
    {
      'title': 'Annual Check-up Reminder',
      'member': 'Jane Doe',
      'time': '10:00 AM',
      'type': 'Appointment',
      'isCompleted': false,
      'frequency': 'Yearly',
    },
    {
      'title': 'Vitamin D Supplement',
      'member': 'John Doe',
      'time': '07:00 PM',
      'type': 'Medicine',
      'isCompleted': true,
      'frequency': 'Daily',
    },
  ];

  bool _travelMode = false;

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
                'Reminders',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ElevatedButton.icon(
                onPressed: _showAddReminderDialog,
                icon: Icon(Icons.add),
                label: Text('Add'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Card(
            child: SwitchListTile(
              title: Text('Travel Mode'),
              subtitle: Text('Adjust reminders for different time zones'),
              value: _travelMode,
              onChanged: (value) => setState(() => _travelMode = value),
              secondary: Icon(MdiIcons.airplane),
            ),
          ),
          if (_travelMode) ...[
            SizedBox(height: 8),
            Card(
              color: AppTheme.lightBlue.withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(MdiIcons.mapMarker, color: AppTheme.primaryBlue),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Location: New York',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text('Nearby healthcare: 3 hospitals, 5 clinics'),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Find Care'),
                    ),
                  ],
                ),
              ),
            ),
          ],
          SizedBox(height: 16),
          Text(
            'Today\'s Reminders',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _reminders.length,
              itemBuilder: (context, index) {
                final reminder = _reminders[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: reminder['isCompleted'] 
                          ? AppTheme.successGreen 
                          : _getTypeColor(reminder['type']),
                      child: Icon(
                        reminder['isCompleted'] 
                            ? MdiIcons.check 
                            : _getTypeIcon(reminder['type']),
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      reminder['title'],
                      style: TextStyle(
                        decoration: reminder['isCompleted'] 
                            ? TextDecoration.lineThrough 
                            : null,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${reminder['member']} • ${reminder['time']}'),
                        Text('${reminder['frequency']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!reminder['isCompleted'])
                          IconButton(
                            icon: Icon(MdiIcons.check),
                            onPressed: () => _markCompleted(index),
                          ),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              ),
                            ),
                            PopupMenuItem(
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Delete'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () => _showReminderDetails(reminder),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Medicine':
        return AppTheme.primaryBlue;
      case 'Appointment':
        return AppTheme.warningYellow;
      case 'Exercise':
        return AppTheme.successGreen;
      default:
        return AppTheme.neutral500;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'Medicine':
        return MdiIcons.pill;
      case 'Appointment':
        return MdiIcons.calendar;
      case 'Exercise':
        return MdiIcons.run;
      default:
        return MdiIcons.bell;
    }
  }

  void _markCompleted(int index) {
    setState(() {
      _reminders[index]['isCompleted'] = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reminder marked as completed'),
        backgroundColor: AppTheme.successGreen,
      ),
    );
  }

  void _showAddReminderDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Reminder'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Type'),
              items: ['Medicine', 'Appointment', 'Exercise', 'Other']
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Time',
                suffixIcon: Icon(Icons.access_time),
              ),
              readOnly: true,
              onTap: () async {
                await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
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
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showReminderDetails(Map<String, dynamic> reminder) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reminder['title'],
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(MdiIcons.account),
              title: Text('For'),
              subtitle: Text(reminder['member']),
            ),
            ListTile(
              leading: Icon(MdiIcons.clock),
              title: Text('Time'),
              subtitle: Text(reminder['time']),
            ),
            ListTile(
              leading: Icon(MdiIcons.repeat),
              title: Text('Frequency'),
              subtitle: Text(reminder['frequency']),
            ),
            SizedBox(height: 16),
            if (reminder['type'] == 'Medicine') ...[
              Card(
                color: AppTheme.lightBlue.withOpacity(0.1),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'OCR Detected Information',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text('Dosage: 10mg'),
                      Text('Instructions: Take with food'),
                      Text('Refills: 2 remaining'),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
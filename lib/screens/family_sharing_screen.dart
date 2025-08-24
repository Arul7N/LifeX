import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/family_member_card.dart';

class FamilySharingScreen extends StatefulWidget {
  const FamilySharingScreen({super.key});

  @override
  _FamilySharingScreenState createState() => _FamilySharingScreenState();
}

class _FamilySharingScreenState extends State<FamilySharingScreen> {
  final List<Map<String, dynamic>> _familyMembers = [
    {
      'name': 'John Doe',
      'role': 'Father',
      'avatar': 'JD',
      'status': 'Active',
      'lastCheckup': '2024-01-15',
    },
    {
      'name': 'Jane Doe',
      'role': 'Mother',
      'avatar': 'JA',
      'status': 'Active',
      'lastCheckup': '2024-01-10',
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
                'Family Members',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ElevatedButton.icon(
                onPressed: _showAddMemberDialog,
                icon: Icon(Icons.add),
                label: Text('Add Member'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(MdiIcons.shield, color: AppTheme.successGreen),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Emergency Alerts Active',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'All family members will be notified in case of emergency',
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
              itemCount: _familyMembers.length,
              itemBuilder: (context, index) {
                return FamilyMemberCard(
                  member: _familyMembers[index],
                  onTap: () => _showMemberDetails(_familyMembers[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddMemberDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Family Member'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Role'),
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

  void _showMemberDetails(Map<String, dynamic> member) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              member['name'],
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(MdiIcons.account),
              title: Text('Role'),
              subtitle: Text(member['role']),
            ),
            ListTile(
              leading: Icon(MdiIcons.calendar),
              title: Text('Last Check-up'),
              subtitle: Text(member['lastCheckup']),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('View Records'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('Edit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
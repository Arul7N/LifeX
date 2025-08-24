import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../theme/app_theme.dart';

class MedicalRecordsScreen extends StatefulWidget {
  const MedicalRecordsScreen({super.key});

  @override
  _MedicalRecordsScreenState createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _records = [
    {
      'title': 'Blood Test Report',
      'type': 'Lab Report',
      'date': '2024-01-15',
      'doctor': 'Dr. Smith',
      'hospital': 'City Hospital',
      'member': 'John Doe',
    },
    {
      'title': 'Prescription - Antibiotics',
      'type': 'Prescription',
      'date': '2024-01-10',
      'doctor': 'Dr. Johnson',
      'hospital': 'Family Clinic',
      'member': 'Jane Doe',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search records...',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) => setState(() => _searchQuery = value),
                ),
              ),
              SizedBox(width: 16),
              PopupMenuButton<String>(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.neutral300),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_selectedFilter),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'All', child: Text('All')),
                  PopupMenuItem(value: 'Lab Report', child: Text('Lab Reports')),
                  PopupMenuItem(value: 'Prescription', child: Text('Prescriptions')),
                  PopupMenuItem(value: 'X-Ray', child: Text('X-Rays')),
                ],
                onSelected: (value) => setState(() => _selectedFilter = value),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Medical Records',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ElevatedButton.icon(
                onPressed: _showUploadDialog,
                icon: Icon(MdiIcons.upload),
                label: Text('Upload'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _records.length,
              itemBuilder: (context, index) {
                final record = _records[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getTypeColor(record['type']),
                      child: Icon(
                        _getTypeIcon(record['type']),
                        color: Colors.white,
                      ),
                    ),
                    title: Text(record['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${record['member']} • ${record['date']}'),
                        Text('${record['doctor']} - ${record['hospital']}'),
                      ],
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: ListTile(
                            leading: Icon(Icons.visibility),
                            title: Text('View'),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            leading: Icon(Icons.share),
                            title: Text('Share'),
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
                    onTap: () => _showRecordDetails(record),
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
      case 'Lab Report':
        return AppTheme.primaryBlue;
      case 'Prescription':
        return AppTheme.successGreen;
      case 'X-Ray':
        return AppTheme.warningYellow;
      default:
        return AppTheme.neutral500;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'Lab Report':
        return MdiIcons.testTube;
      case 'Prescription':
        return MdiIcons.pill;
      case 'X-Ray':
        return MdiIcons.imageFilterCenterFocus;
      default:
        return MdiIcons.fileDocument;
    }
  }

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Upload Medical Record'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Type'),
              items: ['Lab Report', 'Prescription', 'X-Ray', 'Other']
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(MdiIcons.fileUpload),
              label: Text('Select File'),
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
            child: Text('Upload'),
          ),
        ],
      ),
    );
  }

  void _showRecordDetails(Map<String, dynamic> record) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              record['title'],
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(MdiIcons.account),
              title: Text('Patient'),
              subtitle: Text(record['member']),
            ),
            ListTile(
              leading: Icon(MdiIcons.calendar),
              title: Text('Date'),
              subtitle: Text(record['date']),
            ),
            ListTile(
              leading: Icon(MdiIcons.doctor),
              title: Text('Doctor'),
              subtitle: Text(record['doctor']),
            ),
            ListTile(
              leading: Icon(MdiIcons.hospital),
              title: Text('Hospital'),
              subtitle: Text(record['hospital']),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(MdiIcons.download),
              label: Text('Download File'),
            ),
          ],
        ),
      ),
    );
  }
}
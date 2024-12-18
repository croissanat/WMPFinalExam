import 'package:flutter/material.dart';
import 'database_helper.dart';

class CatalogAfterEnrollPage extends StatefulWidget {
  final int userId;

  CatalogAfterEnrollPage({required this.userId});

  @override
  _CatalogAfterEnrollPageState createState() => _CatalogAfterEnrollPageState();
}

class _CatalogAfterEnrollPageState extends State<CatalogAfterEnrollPage> {
  final _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> enrolledSubjects = [];

  @override
  void initState() {
    super.initState();
    _loadEnrolledSubjects();
  }

  _loadEnrolledSubjects() async {
    var subjects = await _dbHelper.getSubjects(widget.userId);
    setState(() {
      enrolledSubjects = subjects;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catalog After Enroll', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.deepPurple),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: enrolledSubjects.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(enrolledSubjects[index]['subject_name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text('Credits: ${enrolledSubjects[index]['credit']}', style: TextStyle(color: Colors.grey[700])),
              ),
            );
          },
        ),
      ),
    );
  }
}

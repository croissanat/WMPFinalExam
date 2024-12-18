import 'package:flutter/material.dart';
import 'database_helper.dart';

class CatalogEnrollmentPage extends StatefulWidget {
  final int userId;

  CatalogEnrollmentPage({required this.userId});

  @override
  _CatalogEnrollmentPageState createState() => _CatalogEnrollmentPageState();
}

class _CatalogEnrollmentPageState extends State<CatalogEnrollmentPage> {
  final _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> subjects = [];
  int totalCredits = 0;

  @override
  void initState() {
    super.initState();
    subjects = [
      {'name': 'Cyber Security Fundamentals', 'credit': 6},
      {'name': 'Security Risk Management', 'credit': 5},
      {'name': 'Digital Forensics', 'credit': 6},
      {'name': 'Ethical Hacking', 'credit': 4},
      {'name': 'Cyber Security Project', 'credit': 4},
      {'name': 'Security Compliance and Audit', 'credit': 5},
    ];
  }

  _enrollSubject(String subjectName, int credit) async {
    if (totalCredits + credit <= 24) {
      await _dbHelper.addSubject(widget.userId, subjectName, credit);
      setState(() {
        totalCredits += credit;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You can only enroll up to 24 credits')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catalog Enrollment', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.deepPurple),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(subjects[index]['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text('Credits: ${subjects[index]['credit']}', style: TextStyle(color: Colors.grey[700])),
                      trailing: ElevatedButton(
                        onPressed: () => _enrollSubject(subjects[index]['name'], subjects[index]['credit']),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                        child: Text('Enroll', style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total Credits: $totalCredits / 24',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            ElevatedButton(
              onPressed: totalCredits == 0 ? null : () {
                // Navigate to summary or next page
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: Text('Summary Enrollment', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

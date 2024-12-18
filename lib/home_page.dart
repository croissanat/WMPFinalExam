import 'package:flutter/material.dart';
import 'catalog_enrollment_page.dart';
import 'catalog_after_enroll_page.dart';

class HomePage extends StatelessWidget {
  final int userId;

  HomePage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Welcoming Text
            Text(
              'Welcome to Your Dashboard!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.deepPurpleAccent,
                    offset: Offset(3.0, 3.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Explore your courses and enroll in the ones that interest you.',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.deepPurple.shade700,
              ),
            ),
            SizedBox(height: 40),
            // Catalog Enrollment Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CatalogEnrollmentPage(userId: userId)),
                );
              },
              icon: Icon(Icons.book, size: 30, color: Colors.white),
              label: Text(
                  'Catalog Enrollment',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: Size(double.infinity, 50),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            SizedBox(height: 20),
            // Catalog After Enroll Button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CatalogAfterEnrollPage(userId: userId)),
                );
              },
              icon: Icon(Icons.check_circle, size: 30, color: Colors.white),
              label: Text(
                  'Catalog After Enroll',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                minimumSize: Size(double.infinity, 50),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

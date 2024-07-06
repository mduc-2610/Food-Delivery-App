import 'package:flutter/material.dart';

class FaceIDSecurityScreen extends StatefulWidget {
  @override
  _FaceIDSecurityScreenState createState() => _FaceIDSecurityScreenState();
}

class _FaceIDSecurityScreenState extends State<FaceIDSecurityScreen> {
  bool isAuthenticated = false;

  void _authenticate() {
    // Simulate authentication process
    setState(() {
      isAuthenticated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face ID Security'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isAuthenticated ? Icons.verified : Icons.face,
              size: 100,
              color: isAuthenticated ? Colors.green : Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              'Secure your account with your face using Face ID',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              isAuthenticated
                  ? 'Authentication successful'
                  : 'Please position your face in front of the camera to authenticate with Face ID',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text('Continue'),
            ),
            TextButton(
              onPressed: () {
                // Handle skip
              },
              child: Text('Skip'),
            ),
          ],
        ),
      ),
    );
  }
}

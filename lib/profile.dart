import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String? referId;

  const Profile({super.key, this.referId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Profile Screen',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Text(
          referId != null ? 'Refer ID: $referId' : 'Error: refId is required',
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}

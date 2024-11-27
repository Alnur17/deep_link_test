import 'package:flutter/material.dart';
import 'home.dart';
import 'profile.dart';
import 'package:app_links/app_links.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;
  String? _initialLink;

  @override
  void initState() {
    super.initState();
    _setupAppLinks();
  }

  // Setup AppLinks to listen for deep links
  void _setupAppLinks() async {
    _appLinks = AppLinks();

    // Handle the app being launched via a link
    final initialLink = await _appLinks.getInitialLink();
    print('Initial Link: $initialLink'); // Debugging

    if (initialLink != null) {
      final Uri uri = Uri.parse(initialLink.toString()); // Convert string to Uri
      final referId = uri.queryParameters['refId'];
      if (referId != null) {
        setState(() {
          _initialLink = initialLink.toString(); // Set the link as string
        });
      } else {
        setState(() {
          _initialLink = 'Error: refId is not available'; // Handle missing refId
        });
      }
    }

    // Listen for links while the app is running
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        final referId = uri.queryParameters['refId'];
        if (referId != null) {
          setState(() {
            _initialLink = uri.toString(); // Convert Uri to String
          });
        } else {
          setState(() {
            _initialLink = 'Error: refId is not available';
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if refId is available and navigate accordingly
    if (_initialLink == null) {
      return const MaterialApp(
        home: Home(),
      );
    } else if (_initialLink!.startsWith('http') && _initialLink != 'Error: refId is required') {
      final uri = Uri.parse(_initialLink!);
      final referId = uri.queryParameters['refId'];
      print('Navigating to Profile with Refer ID: $referId');
      return MaterialApp(
        home: Profile(referId: referId),
      );
    } else {
      return const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Text(
              'Error: refId is required',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
      );
    }
  }
}

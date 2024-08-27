import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController loadTypeController = TextEditingController();
  FocusNode vehicleNoFocusNode = FocusNode();
  FocusNode loadTypeFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    vehicleNoFocusNode.addListener(() {
      if (!vehicleNoFocusNode.hasFocus) {
        _handleLoadType();
      }
    });
  }

  @override
  void dispose() {
    vehicleNoController.dispose();
    loadTypeController.dispose();
    vehicleNoFocusNode.dispose();
    loadTypeFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleLoadType() async {
    print('found');
// Add your logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: vehicleNoController,
              decoration: InputDecoration(labelText: 'VehicleNo'),
              focusNode: vehicleNoFocusNode,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: loadTypeController,
              decoration: InputDecoration(labelText: 'LoadType'),
              focusNode: loadTypeFocusNode,
            ),
          ],
        ),
      ),
    );
  }
}

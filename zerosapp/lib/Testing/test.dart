import 'package:flutter/material.dart';

class RecyclingScreen extends StatefulWidget {
  static var routeName='/RecyclingScreen';

  @override
  _RecyclingScreenState createState() => _RecyclingScreenState();
}

class _RecyclingScreenState extends State<RecyclingScreen> {
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _totalPointsController = TextEditingController();

  void calculateTotalPoints() {
    int quantity = int.tryParse(_quantityController.text) ?? 0;
  String type = _typeController.text.toLowerCase();
    int point;
    if (type == 'plastic') {
      point = 3;
    } else if (type == 'metal') {
      point = 5;
    } else if (type == 'glass') {
      point = 2;
    } else {
      point = 0; // Default value if the type is not recognized
    }
    int totalPoints = quantity * point;
    _totalPointsController.text = totalPoints.toString();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _typeController.dispose();
    _totalPointsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recycling Program'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity',
              ),
              onChanged: (value) {
                calculateTotalPoints();
              },
            ),
            TextField(
              controller: _typeController,
              decoration: InputDecoration(
                labelText: 'Type',
              ),
              onChanged: (value) {
                calculateTotalPoints();
              },
            ),
            TextField(
              controller: _totalPointsController,
              decoration: InputDecoration(
                labelText: 'Total Points',
              ),
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}

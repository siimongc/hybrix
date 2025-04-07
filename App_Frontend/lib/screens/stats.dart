import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/baseScreen.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  Map<String, dynamic> stats = {};

  @override
  void initState() {
    super.initState();
    fetchStats();
  }

  Future<void> fetchStats() async {
    final url = Uri.parse('http://10.0.2.2:3000/hybrix/statsData/1');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          stats = data;
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Nuevo recorrido",
      icon: Icons.motorcycle,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF6CB2A6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                "Estadísticas...",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  padding: EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    statCard(
                      "Temperatura",
                      stats['temperature'] != null
                          ? "${stats['temperature']}°"
                          : "-",
                      Icons.thermostat,
                      Colors.grey,
                    ),
                    statCard(
                      "Velocidad promedio",
                      stats['speed'] != null ? "${stats['speed']} km/h" : "-",
                      Icons.speed,
                      Colors.blue,
                    ),
                    statCard(
                      "RPM",
                      stats['rpm'] != null ? "${stats['rpm']}" : "-",
                      Icons.rotate_right,
                      Colors.orange,
                    ),
                    statCard(
                      "Batería",
                      stats['battery'] != null ? "${stats['battery']}%" : "-",
                      Icons.battery_charging_full,
                      Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget statCard(String title, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: color),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

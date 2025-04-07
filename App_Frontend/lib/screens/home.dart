import 'package:flutter/material.dart';
import '/widgets/baseScreen.dart';
import 'create_vehicle_page.dart';
import 'info.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateVehiclePage()),
                );
              },
              icon: const Icon(Icons.motorcycle, color: Colors.white),
              label: const Text(
                "+ AÑADIR VEHÍCULO",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF64A3A3),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "No hay un dispositivo conectado...",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _buildButton(Icons.map, "Mis recorridos"),
                _buildButton(Icons.directions_car, "Ubicación vehículo"),
                _buildButton(Icons.bar_chart, "Estadísticas", onTap: () {
                  Navigator.pushNamed(context, '/stats', arguments: 1);
                }),
                _buildButton(Icons.motorcycle, "Sobre mi moto", onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InfoScreen(),
                      settings: const RouteSettings(arguments: 1), // ID fijo temporal
                    ),
                  );
                }),
                _buildButton(Icons.settings, "Ajustes"),
                _buildButton(Icons.eco, "Mi huella verde"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String text, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.black),
          const SizedBox(height: 8),
          Text(text, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

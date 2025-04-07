import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateVehiclePage extends StatefulWidget {
  const CreateVehiclePage({super.key});

  @override
  State<CreateVehiclePage> createState() => _CreateVehiclePageState();
}

class _CreateVehiclePageState extends State<CreateVehiclePage> {
  final _formKey = GlobalKey<FormState>();

  final _idTypeController = TextEditingController();
  final _idUserController = TextEditingController();
  final _plateController = TextEditingController();
  final _yearController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _displacementController = TextEditingController();
  final _weightController = TextEditingController();
  final _powerController = TextEditingController();
  final _torqueController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _idTypeController.dispose();
    _idUserController.dispose();
    _plateController.dispose();
    _yearController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _displacementController.dispose();
    _weightController.dispose();
    _powerController.dispose();
    _torqueController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final vehicleData = {
        'id_type': int.tryParse(_idTypeController.text) ?? 0,
        'id_user': int.tryParse(_idUserController.text) ?? 0,
        'plate': _plateController.text,
        'year': int.tryParse(_yearController.text) ?? 0,
        'brand': _brandController.text,
        'model': _modelController.text,
        'displacement': int.tryParse(_displacementController.text) ?? 0,
        'weight': int.tryParse(_weightController.text) ?? 0,
        'power': double.tryParse(_powerController.text) ?? 0.0,
        'torque': double.tryParse(_torqueController.text) ?? 0.0,
        'id': 1
      };

      try {
        final response = await http.post(
          Uri.parse('http://10.0.2.2:3000/hybrix/create'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(vehicleData),
        );

        setState(() {
          _isLoading = false;
        });

        if (response.statusCode == 201 || response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Vehículo registrado con éxito')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al registrar vehículo: ${response.body}')),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de conexión: $e')),
        );
      }
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, complete este campo';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              color: const Color(0xFF5BB1AF),
              child: const Center(
                child: Text(
                  'Create Vehicle',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField('ID de la moto', _idTypeController, keyboardType: TextInputType.number),
                    _buildTextField('ID del usuario', _idUserController, keyboardType: TextInputType.number),
                    _buildTextField('Placa', _plateController),
                    _buildTextField('Año', _yearController, keyboardType: TextInputType.number),
                    _buildTextField('Marca', _brandController),
                    _buildTextField('Modelo', _modelController),
                    _buildTextField('Cilindraje (cc)', _displacementController, keyboardType: TextInputType.number),
                    _buildTextField('Peso (kg)', _weightController, keyboardType: TextInputType.number),
                    _buildTextField('Potencia (HP)', _powerController, keyboardType: TextInputType.number),
                    _buildTextField('Torque (Nm)', _torqueController, keyboardType: TextInputType.number),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5BB1AF),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Registrar', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

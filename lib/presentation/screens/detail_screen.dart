import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/university.dart';
import '../providers/university_provider.dart';

class DetailScreen extends StatefulWidget {
  final University university;

  const DetailScreen({super.key, required this.university});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _studentsController;
  final ImagePicker _picker = ImagePicker();
  String? _currentImagePath;

  @override
  void initState() {
    super.initState();
    // Inicializamos con los datos existentes
    _studentsController = TextEditingController(
      text: widget.university.studentCount?.toString() ?? '',
    );
    _currentImagePath = widget.university.imagePath;
  }

  @override
  void dispose() {
    _studentsController.dispose();
    super.dispose();
  }

  // Función para seleccionar imagen
  Future<void> _pickImage(ImageSource source) async {
    final XFile? photo = await _picker.pickImage(source: source);
    if (photo != null) {
      setState(() {
        _currentImagePath = photo.path;
      });
    }
  }

  // Función para guardar cambios
  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      int? students;
      if (_studentsController.text.isNotEmpty) {
        students = int.tryParse(_studentsController.text);
      }

      // Creamos una copia actualizada de la universidad
      final updatedUniversity = widget.university.copyWith(
        studentCount: students,
        imagePath: _currentImagePath,
      );

      // Actualizamos el estado global
      context.read<UniversityProvider>().updateUniversity(updatedUniversity);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Información actualizada correctamente')),
      );

      Navigator.pop(context); // Regresar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle Universidad")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Sección de Imagen
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(context: context, builder: (_) => _buildImagePickerOptions());
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                    image: _currentImagePath != null
                        ? DecorationImage(
                      image: FileImage(File(_currentImagePath!)),
                      fit: BoxFit.cover,
                    )
                        : null,
                    border: Border.all(color: Colors.indigo, width: 2),
                  ),
                  child: _currentImagePath == null
                      ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                      Text("Subir Foto", style: TextStyle(color: Colors.grey)),
                    ],
                  )
                      : null,
                ),
              ),
              const SizedBox(height: 20),

              // Información solo lectura
              Text(
                widget.university.name,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              _buildInfoTile("País", widget.university.country ?? "N/A"),
              _buildInfoTile("Web", widget.university.webPages.isNotEmpty ? widget.university.webPages.first : "N/A"),

              const Divider(height: 40),

              // Campo Editable: Número de estudiantes
              TextFormField(
                controller: _studentsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Número de Estudiantes",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.people),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (int.tryParse(value) == null) {
                      return "Por favor ingresa un número válido";
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Botón Guardar
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Guardar Cambios", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildImagePickerOptions() {
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Galería'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Cámara'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }
}
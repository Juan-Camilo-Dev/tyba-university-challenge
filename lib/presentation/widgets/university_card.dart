import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/entities/university.dart';

class UniversityCard extends StatelessWidget {
  final University university;
  final VoidCallback onTap;
  final bool isGrid; // Nuevo parámetro para saber el modo

  const UniversityCard({
    super.key,
    required this.university,
    required this.onTap,
    this.isGrid = false, // Por defecto es lista
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      // Ajustamos márgenes según el modo
      margin: isGrid
          ? const EdgeInsets.all(8)
          : const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: isGrid ? _buildGridLayout() : _buildListLayout(),
        ),
      ),
    );
  }

  // DISEÑO ORIGINAL (LISTA)
  Widget _buildListLayout() {
    return Row(
      children: [
        _buildAvatar(size: 50),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                university.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                university.country ?? 'Sin país',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ],
    );
  }

  // NUEVO DISEÑO (GRID - Vertical y Centrado)
  Widget _buildGridLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildAvatar(size: 60), // Avatar más grande
        const SizedBox(height: 12),
        Text(
          university.name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          maxLines: 3, // Permitimos más líneas en vertical
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          university.country ?? 'Sin país',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }

  // Widget auxiliar para el Avatar
  Widget _buildAvatar({required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        shape: BoxShape.circle, // Circular
        image: university.imagePath != null
            ? DecorationImage(
          image: FileImage(File(university.imagePath!)),
          fit: BoxFit.cover,
        )
            : null,
        border: Border.all(color: Colors.indigo.shade100, width: 1),
      ),
      child: university.imagePath == null
          ? Icon(Icons.school, color: Colors.indigo, size: size * 0.5)
          : null,
    );
  }
}
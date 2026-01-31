import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/university_provider.dart';
import '../widgets/university_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Cargamos la data apenas inicia la pantalla
    // Usamos addPostFrameCallback para evitar errores de renderizado inicial
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UniversityProvider>().loadUniversities();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Escuchamos los cambios del Provider
    final provider = context.watch<UniversityProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tyba Universities"),
        actions: [
          // Botón para cambiar entre Lista y Grid
          IconButton(
            icon: Icon(provider.isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              provider.toggleViewMode();
            },
          )
        ],
      ),
      body: provider.isLoading && provider.displayedUniversities.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
          ? Center(child: Text(provider.errorMessage!))
          : NotificationListener<ScrollNotification>(
        // Lógica del Infinite Scroll (BONO)
        onNotification: (ScrollNotification scrollInfo) {
          if (!provider.isLoading &&
              scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 200) {
            // Si estamos cerca del final, cargamos más
            provider.loadMore();
          }
          return true;
        },
        child: provider.isGridView
            ? _buildGridView(provider)
            : _buildListView(provider),
      ),
    );
  }

  Widget _buildListView(UniversityProvider provider) {
    return ListView.builder(
      itemCount: provider.displayedUniversities.length + 1, // +1 para el loader final
      itemBuilder: (context, index) {
        if (index == provider.displayedUniversities.length) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final uni = provider.displayedUniversities[index];
        return UniversityCard(
          university: uni,
          onTap: () => _navigateToDetail(context, uni),
        );
      },
    );
  }

  Widget _buildGridView(UniversityProvider provider) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columnas
        childAspectRatio: 0.8, // Relación de aspecto
      ),
      itemCount: provider.displayedUniversities.length,
      itemBuilder: (context, index) {
        final uni = provider.displayedUniversities[index];
        return UniversityCard(
          university: uni,
          onTap: () => _navigateToDetail(context, uni),
        );
      },
    );
  }

  void _navigateToDetail(BuildContext context, dynamic university) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(university: university),
      ),
    );
  }
}
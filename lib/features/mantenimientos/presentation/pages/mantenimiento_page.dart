import 'package:appmuni/features/mantenimientos/presentation/viewmodels/busquedasolicitudes_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/formulario_widget.dart';
import '../widgets/consulta_widget.dart';

class MantenimientoPage extends StatefulWidget {
  const MantenimientoPage({super.key});

  @override
  _MantenimientoPageState createState() => _MantenimientoPageState();
}

class _MantenimientoPageState extends State<MantenimientoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Escuchar cambios de índice en el TabController
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        // Índice del tab de consulta
        // Reinicia el ViewModel cada vez que se entra a la pestaña de consulta
        Provider.of<BusquedaMantenimientoViewModel>(context, listen: false)
            .resetBusqueda();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red, // Fondo rojo para los tabs no seleccionados
                borderRadius: BorderRadius.circular(8),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor:
                    Colors.red, // Color de texto para el tab seleccionado
                unselectedLabelColor: Colors
                    .white, // Color de texto para los tabs no seleccionados
                indicator: BoxDecoration(
                  color: Colors.white, // Fondo blanco para el tab seleccionado
                  borderRadius: BorderRadius.circular(8),
                ),
                tabs: [
                  _buildFixedTab('Registrar'),
                  _buildFixedTab('Consultar'),
                  _buildFixedTab('Estado'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // TabBarView para el contenido de cada pestaña
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  FormularioPage(opcion: 'REGISTRAR MANTENIMIENTO'),
                  BusquedaMantenimientoWidget(),
                  FormularioPage(opcion: 'APROBAR/RECHAZAR MANTENIMIENTO'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para crear un Tab con tamaño fijo
  Widget _buildFixedTab(String text) {
    return Tab(
      child: Container(
        width: 100, // Ajusta el ancho deseado para cada tab
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

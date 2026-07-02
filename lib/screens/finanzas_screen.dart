import 'package:flutter/material.dart';

import 'cobros_screen.dart';
import 'pagos_screen.dart';

class FinanzasScreen
    extends StatelessWidget {
  const FinanzasScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title:
              const Text(
            'Finanzas',
          ),
          bottom:
              const TabBar(
            tabs: [
              Tab(
                text: 'Pagos',
              ),
              Tab(
                text: 'Cobros',
              ),
            ],
          ),
        ),
        body:
            const TabBarView(
          children: [
            PagosScreen(),
            CobrosScreen(),
          ],
        ),
      ),
    );
  }
}
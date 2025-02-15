import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/data/models/active_bus.dart';
import 'package:sola/presentation/providers/active_bus_list_provider.dart';
import 'package:sola/presentation/providers/active_bus_providers.dart';
import 'package:sola/presentation/widgets/bus/bus_card.dart';

class BusListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Selector<ActiveBusListProvider, List<ActiveBus>>(
        selector: (_, provider) => provider.filteredBus,
        builder: (context, filteredBus, child) {
          return ListView.builder(
            itemCount: filteredBus.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider(
                create: (_) => ActiveBusProvider(filteredBus[index]), 
                child: ActiveBusCard(),
              );
            },
          );
        },
      ),
    );
  }
}

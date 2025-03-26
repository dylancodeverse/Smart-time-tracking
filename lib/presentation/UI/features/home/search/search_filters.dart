import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sola/presentation/providers/home/search_filter_provider.dart';

class SearchFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filterProvider.filters.map((filter) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _FilterButton(
                label: filter,
                isActive: filterProvider.selectedFilter == filter,
                onTap: () => filterProvider.setSelectedFilter(context,filter),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Color(0xFF008069) : Colors.grey[300], // Vert actif, gris sinon
        foregroundColor: isActive ? Colors.white : Colors.black, // Texte

        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(label, style: TextStyle(fontSize: 12)),
    );
  }
}

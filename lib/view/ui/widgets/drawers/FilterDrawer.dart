import 'package:bitshelf/controllers/FilterController.dart';
import 'package:bitshelf/services/Filter/FilterFactory.dart';
import 'package:flutter/material.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key});

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  Map<String,List<String>?> filters = {};
  List<String> reviewsBounds = ["",""];
  List<String> labelsToFilter = FilterFactory.filters.keys.toList();
  late FilterController filterController;

  @override
  Widget build(BuildContext context) {
    List<Widget> filterFields = [];
    filterController = FilterController(context);
    for (var label in labelsToFilter) {
      if (label == "review") {
        filterFields.addAll([
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) {
                if(value.isEmpty && reviewsBounds[1].isEmpty){
                  filters.remove(label);
                  return;
                }
                reviewsBounds[0] = value;
                filters[label] = reviewsBounds;
                filterController.addFilter(label, reviewsBounds);
                setState(() { });
              },
              decoration: const InputDecoration(
                labelText: 'Reviews (from)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) {
                if(value.isEmpty && reviewsBounds[0].isEmpty){
                  filters.remove(label);
                  return;
                }
                reviewsBounds[1] = value;
                filters[label] = reviewsBounds;
                filterController.addFilter(label, reviewsBounds);
                setState(() { });
              },
              decoration: const InputDecoration(
                labelText: 'Reviews (to)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ]);
      } else {
        filterFields.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) {
                if(value.isEmpty){
                  filters.remove(label);
                  return;
                }
                filters[label] = [value];
                filterController.addFilter(label, [value]);
                setState(() { });
              },
              decoration: InputDecoration(
                labelText: label[0].toUpperCase() + label.substring(1),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        );
      }
    }
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Filtering:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ...filterFields,
        const SizedBox(height: 24),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: MaterialButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onPressed: () {
                    filterController.applyFilters();
                    Navigator.pop(context);
                  },
                  child: const Text('Apply Filters', style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: MaterialButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onPressed: () {
                    filterController.resetFilters();
                    Navigator.pop(context);
                  },
                  child: const Text('Reset Filters', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
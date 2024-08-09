import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final Map<String, String> filters;
  FilterScreen({required this.filters});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Map<String, bool> profiles = {
    'Data Science': false,
    'Web Development': false,
    'Mobile App Development': false,
  };

  Map<String, bool> cities = {
    'New York': false,
    'San Francisco': false,
    'Los Angeles': false,
  };

  Map<String, bool> durations = {
    '1 Month': false,
    '3 Months': false,
    '6 Months': false,
  };

  @override
  void initState() {
    super.initState();
    _initializeFilters();
  }

  void _initializeFilters() {
    widget.filters.forEach((key, value) {
      if (profiles.containsKey(value)) {
        profiles[value] = true;
      } else if (cities.containsKey(value)) {
        cities[value] = true;
      } else if (durations.containsKey(value)) {
        durations[value] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profiles',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: profiles.keys.map((String key) {
                return FilterChip(
                  label: Text(key),
                  selected: profiles[key]!,
                  onSelected: (bool selected) {
                    setState(() {
                      profiles[key] = selected;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Text('Cities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: cities.keys.map((String key) {
                return FilterChip(
                  label: Text(key),
                  selected: cities[key]!,
                  onSelected: (bool selected) {
                    setState(() {
                      cities[key] = selected;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Text('Durations',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: durations.keys.map((String key) {
                return FilterChip(
                  label: Text(key),
                  selected: durations[key]!,
                  onSelected: (bool selected) {
                    setState(() {
                      durations[key] = selected;
                    });
                  },
                );
              }).toList(),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Map<String, String> selectedFilters = {};
                profiles.forEach((key, value) {
                  if (value) selectedFilters['profile'] = key;
                });
                cities.forEach((key, value) {
                  if (value) selectedFilters['city'] = key;
                });
                durations.forEach((key, value) {
                  if (value) selectedFilters['duration'] = key;
                });
                Navigator.pop(context, selectedFilters);
              },
              child: Text('Apply Filters'),
            )
          ],
        ),
      ),
    );
  }
}

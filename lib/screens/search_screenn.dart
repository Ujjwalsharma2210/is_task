import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'filter_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> internships = [];
  Map<String, String> filters = {};

  @override
  void initState() {
    super.initState();
    fetchInternships();
  }

  Future<void> fetchInternships() async {
    final response = await http
        .get(Uri.parse('https://internshala.com/flutter_hiring/search'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['internships_meta'];
      setState(() {
        internships = (data as Map<String, dynamic>)
            .values
            .map((e) => e as Map<String, dynamic>)
            .toList();
        applyFilters(); // Apply filters after fetching data
      });
    } else {
      throw Exception('Failed to load internships');
    }
  }

  void applyFilters() {
    List<Map<String, dynamic>> filteredInternships = internships;
    filters.forEach((key, value) {
      if (value.isNotEmpty) {
        filteredInternships = filteredInternships.where((internship) {
          return internship[key] != null &&
              internship[key].toString().contains(value);
        }).toList();
      }
    });

    setState(() {
      internships = filteredInternships;
    });
  }

  void updateFilters(Map<String, String> newFilters) {
    setState(() {
      filters = newFilters;
      applyFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internship Search'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FilterScreen(filters: filters)),
              );
              if (result != null) {
                updateFilters(result);
              }
            },
          )
        ],
      ),
      body: internships.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: internships.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(internships[index]['title'] ?? 'No Title'),
                  subtitle: Text(internships[index]['duration'] ?? ''),
                );
              },
            ),
    );
  }
}

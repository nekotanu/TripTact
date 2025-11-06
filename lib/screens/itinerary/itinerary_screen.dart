import 'package:flutter/material.dart';

class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Itinerary')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3, // placeholder
        itemBuilder: (_, index) => Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text('Day ${index + 1}'),
            subtitle: const Text(
              'Morning: Eiffel Tower\nAfternoon: Louvre\nEvening: Seine River',
            ),
            onTap: () => Navigator.pushNamed(context, '/map'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/offline'),
        child: const Icon(Icons.save),
      ),
    );
  }
}

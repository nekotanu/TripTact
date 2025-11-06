import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triptact/models/place.dart';
import 'package:triptact/models/trips.dart';
import 'package:triptact/provider/trip_provider.dart';
import '../../../core/constants/app_colors.dart';

class CreateTripDialog extends StatefulWidget {
  const CreateTripDialog({super.key});

  @override
  State<CreateTripDialog> createState() => _CreateTripDialogState();
}

class _CreateTripDialogState extends State<CreateTripDialog> {
  int _currentStep = 0;

  final List<String> _selectedCities = [];
  final List<String> _selectedPlaces = [];
  final List<String> _selectedRestaurants = [];

  // Dummy data (Tokyo only)
  final List<String> _dummyCities = ['Tokyo'];

  final List<Map<String, dynamic>> _dummyPlaces = [
    {
      'name': 'Tokyo Tower',
      'description': 'Iconic red tower offering panoramic city views.',
      'image':
          'https://imgs.search.brave.com/1NBvEOOJ53lhDMz4M6xoJoRV6yaCqU_o7jLVQJBUig8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9taW5h/dG9rYW5rb3Byb2Qu/YmxvYi5jb3JlLndp/bmRvd3MubmV0L2Fz/c2V0cy8yMDIyLzA3/LzI5LzAwLzM4LzUw/L3Rva3lvX3Rvd2Vy/XzAxLmpwZw',
    },
    {
      'name': 'Senso-ji Temple',
      'description': 'Tokyo’s oldest Buddhist temple, located in Asakusa.',
      'image':
          'https://images.unsplash.com/photo-1522850959516-58f958dde2c1?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=687',
    },
    {
      'name': 'Shibuya Crossing',
      'description': 'Famous busy intersection symbolizing Tokyo’s energy.',
      'image':
          'https://images.unsplash.com/photo-1536098561742-ca998e48cbcc?auto=format&fit=crop&w=800&q=80',
    },
  ];

  final List<Map<String, dynamic>> _dummyRestaurants = [
    {
      'name': 'Sushi Saito',
      'description': 'Michelin-starred sushi restaurant known for perfection.',
      'image':
          'https://imgs.search.brave.com/3CY_mMjM7oZ5APiDUbbHnKFHJqu3wUlXwQ0ptVPCSJ0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9iNzBm/MDg0ZTI5ZjNmOGZh/ZmZiMC0zODlmZmZj/NWI5MDkzNjYzNWQx/NjZhMzJmZGIxMWI2/YS5zc2wuY2YzLnJh/Y2tjZG4uY29tL2Fu/ZHktaGF5bGVyLXN1/c2hpLXNhaXRvLXN1/c2hpLXNhaXRpbyUy/MDU0NzIlMjBTYWl0/byUyMGluJTIwYWN0/aW9uLWNyb3AtdjEu/SlBH',
    },
    {
      'name': 'Ichiran Ramen',
      'description': 'World-famous ramen chain with individual booths.',
      'image':
          'https://imgs.search.brave.com/g1qUQFXHFeAUBaFZyAtG7JO36CaYjWOLxp8OWtg7ah0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YWJp/c2FiaS1zdG9yZS5q/cC9jZG4vc2hvcC9m/aWxlcy81MVFyekFY/YXhOTC5fQUMuanBn/P3Y9MTcyNTUyMDc2/OCZ3aWR0aD03MjA',
    },
    {
      'name': 'Gyukatsu Motomura',
      'description': 'Crispy beef cutlet restaurant in Shibuya.',
      'image':
          'https://imgs.search.brave.com/Kr26FiOVLKvPCGQVjv15KOdgK9p2JFSjEQi2qlcd6Zk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/aG93Z29vZGlzaXRh/Y3R1YWxseS5jb20v/d3AtY29udGVudC91/cGxvYWRzLzIwMjMv/MDgvR3l1a2F0c3Ut/TW90b211cmEtVGVu/amluLUZ1a3Vva2Et/Ny1XZWItMS5qcGc',
    },
  ];

  void _nextStep() {
    if (_currentStep < 3) setState(() => _currentStep++);
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context);
    }
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildDestinationStep();
      case 1:
        return _buildPlacesStep();
      case 2:
        return _buildRestaurantStep();
      case 3:
        return _buildSummaryStep();
      default:
        return const SizedBox.shrink();
    }
  }

  // ---- STEP 1: DESTINATION ----
  Widget _buildDestinationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Choose Your Destination",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Currently supporting Tokyo only (for demo).",
          style: TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _dummyCities.map((city) {
            final selected = _selectedCities.contains(city);
            return ChoiceChip(
              label: Text(city),
              selected: selected,
              onSelected: (_) => setState(() {
                selected
                    ? _selectedCities.remove(city)
                    : _selectedCities.add(city);
              }),
              selectedColor: AppColors.primary,
              labelStyle: TextStyle(
                color: selected ? Colors.white : AppColors.textPrimary,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ---- STEP 2: PLACES ----
  Widget _buildPlacesStep() {
    if (_selectedCities.isEmpty) {
      return const Text(
        "Please select Tokyo as your destination.",
        style: TextStyle(color: AppColors.textSecondary),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Places to Explore",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Select landmarks or attractions you’d like to visit.",
          style: TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 16),
        ..._dummyPlaces.map((place) {
          final selected = _selectedPlaces.contains(place['name']);
          return GestureDetector(
            onTap: () {
              setState(() {
                selected
                    ? _selectedPlaces.remove(place['name'])
                    : _selectedPlaces.add(place['name']);
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: selected ? AppColors.primary : Colors.grey.shade300,
                  width: selected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                    child: Image.network(
                      place['image']!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place['name']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          place['description']!,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  // ---- STEP 3: RESTAURANTS ----
  Widget _buildRestaurantStep() {
    if (_selectedCities.isEmpty) {
      return const Text(
        "Please select Tokyo first.",
        style: TextStyle(color: AppColors.textSecondary),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Restaurants to Try",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Pick your favorite Tokyo food spots.",
          style: TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 16),
        ..._dummyRestaurants.map((res) {
          final selected = _selectedRestaurants.contains(res['name']);
          return GestureDetector(
            onTap: () {
              setState(() {
                selected
                    ? _selectedRestaurants.remove(res['name'])
                    : _selectedRestaurants.add(res['name']);
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: selected ? AppColors.primary : Colors.grey.shade300,
                  width: selected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                    child: Image.network(
                      res['image']!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          res['name']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          res['description']!,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  // ---- STEP 4: SUMMARY ----
  Widget _buildSummaryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Your Tokyo Trip Summary",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Here’s your personalized Tokyo itinerary!",
          style: TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 20),
        _buildSummaryCard("Destination", content: _selectedCities.join(", ")),
        const SizedBox(height: 12),
        _buildSummaryCard(
          "Places to Explore",
          content: _selectedPlaces.isEmpty
              ? "No places selected"
              : _selectedPlaces.join(", "),
        ),
        const SizedBox(height: 12),
        _buildSummaryCard(
          "Where to Eat",
          content: _selectedRestaurants.isEmpty
              ? "No restaurants selected"
              : _selectedRestaurants.join(", "),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, {required String content}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(content, style: const TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stepTitles = ['Destination', 'Places', 'Restaurants', 'Summary'];

    return Center(
      child: Container(
        width: 420,
        constraints: const BoxConstraints(maxHeight: 650),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 12),
          ],
        ),
        child: Column(
          children: [
            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Create Your Trip',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Step ${_currentStep + 1} of 4',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  stepTitles[_currentStep],
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: (_currentStep + 1) / 4,
              color: AppColors.primary,
              backgroundColor: Colors.grey.shade200,
              minHeight: 5,
            ),
            const SizedBox(height: 20),
            Expanded(child: SingleChildScrollView(child: _buildStepContent())),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: _prevStep,
                  icon: const Icon(Icons.arrow_back, size: 18),
                  label: const Text('Back'),
                ),

                // ElevatedButton.icon(
                //   onPressed: () {
                //     if (_currentStep < 3) {
                //       setState(() => _currentStep++);
                //     } else {
                //       if (_selectedCities.isNotEmpty) {
                //         final newTrip = Trip(
                //           destination: _selectedCities.first,
                //           places: List.from(_selectedPlaces),
                //           restaurants: List.from(_selectedRestaurants),
                //         );

                //         final tripProvider = Provider.of<TripProvider>(
                //           context,
                //           listen: false,
                //         );
                //         tripProvider.addTrip(newTrip);

                //         Navigator.pop(context);
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           const SnackBar(
                //             content: Text("Trip added successfully!"),
                //           ),
                //         );
                //       } else {
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           const SnackBar(
                //             content: Text("Please select Tokyo first."),
                //           ),
                //         );
                //       }
                //     }
                //   },
                //   icon: Icon(
                //     _currentStep == 3 ? Icons.check : Icons.arrow_forward,
                //   ),
                //   label: Text(_currentStep == 3 ? 'Finish' : 'Next'),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: AppColors.primary,
                //   ),
                // ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_currentStep < 3) {
                      setState(() => _currentStep++);
                    } else {
                      if (_selectedCities.isNotEmpty) {
                        final newTrip = Trip(
                          destination: _selectedCities.first,
                          places: List.from(_selectedPlaces),
                          restaurants: List.from(_selectedRestaurants),
                        );

                        // Add trip to provider
                        final tripProvider = Provider.of<TripProvider>(
                          context,
                          listen: false,
                        );
                        tripProvider.addTrip(newTrip);

                        // Close dialog before navigating
                        Navigator.pop(context);

                        // Navigate to the TripScreen with this trip
                        Navigator.pushNamed(
                          context,
                          '/trip_screen',
                          arguments: newTrip,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Trip added successfully!"),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select a destination"),
                          ),
                        );
                      }
                    }
                  },
                  icon: Icon(
                    _currentStep == 3 ? Icons.check : Icons.arrow_forward,
                  ),
                  label: Text(_currentStep == 3 ? 'Finish' : 'Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

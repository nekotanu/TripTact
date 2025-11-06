import 'package:flutter/material.dart';
import 'package:triptact/provider/trip_provider.dart';
import 'package:triptact/screens/create_trips/create_trip_dialog.dart';
import 'package:triptact/screens/home/data/dummy_trip.dart';
import 'package:triptact/screens/home/widgets/discover_card.dart';
import '../../../core/constants/app_colors.dart';
import 'widgets/trip_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => const Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: CreateTripDialog(),
          ),
        ),
        child: const Icon(Icons.add, color: AppColors.white),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- Header Section ----
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Discover',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Explore amazing destinations and\nplan your next adventure',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.settings_outlined,
                      color: AppColors.textPrimary,
                      size: 26,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ---- Featured Destinations ----
              const Text(
                'Featured Destinations',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 250,
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 2, right: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: featuredDestinations.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    return DiscoverCard(place: featuredDestinations[index]);
                  },
                ),
              ),

              const SizedBox(height: 32),

              // ---- My Trips ----
              const Text(
                'My Trips',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),
              Consumer<TripProvider>(
                builder: (context, tripProvider, child) {
                  final trips = tripProvider.trips;
                  if (trips.isEmpty) {
                    return const Text(
                      'No trips yet — create your first trip using the + button!',
                      style: TextStyle(color: AppColors.textSecondary),
                    );
                  }
                  return Column(
                    children: trips.map((trip) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/trip_summary',
                            arguments: trip,
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.location_on_outlined,
                              color: AppColors.primary,
                            ),
                            title: Text(
                              trip.destination,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${trip.places.length} places • ${trip.restaurants.length} restaurants",
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),

              const SizedBox(height: 80), // spacing at bottom
            ],
          ),
        ),
      ),
    );
  }
}

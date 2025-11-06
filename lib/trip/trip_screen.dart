import 'package:flutter/material.dart';
import 'package:triptact/core/constants/app_colors.dart';
import 'package:triptact/models/trips.dart';
import 'package:url_launcher/url_launcher.dart';

class TripScreen extends StatelessWidget {
  final Trip trip;

  const TripScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: Text(trip.destination),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, trip.destination),
                const SizedBox(height: 20),
                _buildInfoCards(),
                const SizedBox(height: 20),
                const Text(
                  "Trip Guide",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSection(
                  "Places to Explore",
                  trip.places,
                  isPlace: true,
                  context: context,
                ),
                const SizedBox(height: 16),
                _buildSection(
                  "Where to Eat",
                  trip.restaurants,
                  isPlace: false,
                  context: context,
                ),
                const SizedBox(height: 20),
                _buildTripOverview(trip),
              ],
            ),
          ),
          _buildFloatingButtons(),
        ],
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _buildHeader(BuildContext context, String cityName) {
    final images = {
      'Tokyo':
          'https://images.unsplash.com/photo-1505159940484-eb2b9f2588e2?auto=format&fit=crop&w=1000&q=80',
      'Paris':
          'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?auto=format&fit=crop&w=1000&q=80',
      'Bali':
          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1000&q=80',
    };

    final cityImage =
        images[cityName] ??
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1000&q=80';

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            cityImage,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.5), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cityName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Where tradition meets neon lights",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------- INFO CARDS ----------------
  Widget _buildInfoCards() {
    final info = [
      {'icon': Icons.wb_sunny_rounded, 'text': 'Sunny 27°C'},
      {'icon': Icons.calendar_month_rounded, 'text': 'Mar - May'},
      {'icon': Icons.train_rounded, 'text': 'Tokyo Metro'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: info.map((i) {
        return Expanded(
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                children: [
                  Icon(
                    i['icon'] as IconData,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    i['text'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ---------------- SECTION BUILDER ----------------
  Widget _buildSection(
    String title,
    List<String> items, {
    required bool isPlace,
    required BuildContext context,
  }) {
    if (items.isEmpty) {
      return _buildEmptyState(title);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...items.map((item) {
          final image = _getImageForItem(item);
          final desc = _getDescription(item);
          return _buildPlaceCard(context, item, image, desc);
        }),
      ],
    );
  }

  Widget _buildPlaceCard(
    BuildContext context,
    String name,
    String image,
    String description,
  ) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // ...
                    TextButton.icon(
                      onPressed: () async {
                        final placeName = name;
                        final encodedName = Uri.encodeComponent(placeName);
                        final googleMapsUrl =
                            'https://www.google.com/maps/dir/?api=1&origin=current+location&destination=$encodedName&travelmode=driving';

                        if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
                          await launchUrl(
                            Uri.parse(googleMapsUrl),
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Could not open Google Maps'),
                            ),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.map_outlined,
                        color: AppColors.primary,
                      ),
                      label: const Text(
                        "View on Map",
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- FLOATING BUTTONS ----------------
Widget _buildFloatingButtons() {
  return Positioned(
    right: 16,
    bottom: 16,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.small(
          heroTag: 'map',
          onPressed: () {},
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.map_outlined),
        ),
        const SizedBox(height: 10),
        FloatingActionButton.small(
          heroTag: 'share',
          onPressed: () {},
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.share_outlined),
        ),
        const SizedBox(height: 10),
        FloatingActionButton.small(
          heroTag: 'save',
          onPressed: () {},
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.picture_as_pdf_outlined),
        ),
      ],
    ),
  );
}

// ---------------- TRIP OVERVIEW ----------------
Widget _buildTripOverview(Trip trip) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _OverviewItem(
            icon: Icons.calendar_today,
            label: "Duration",
            value: "3 days",
          ),
          _OverviewItem(icon: Icons.place, label: "Spots", value: "5"),
          _OverviewItem(icon: Icons.star, label: "Avg Rating", value: "4.6"),
        ],
      ),
    ),
  );
}

// ---------------- HELPERS ----------------
Widget _buildEmptyState(String title) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
    ),
    child: Center(
      child: Text(
        "No $title found yet.",
        style: const TextStyle(color: AppColors.textSecondary),
      ),
    ),
  );
}

String _getImageForItem(String item) {
  final map = {
    'Tokyo Tower':
        'https://imgs.search.brave.com/w7VUq0qCgI_LcicCNQ9Hgm4K2X8rWItVtIoDiIBf2Xw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvODAz/NjU1MDY2L3Bob3Rv/L3Rva3lvLXRvd2Vy/LmpwZz9zPTYxMng2/MTImdz0wJms9MjAm/Yz1FLXEwMDNYZjZE/SFR0Sm95b2hveUox/cUJwd2hsNzRNZ3NG/NXhhOTdoSGIwPQ',
    'Senso-ji Temple':
        'https://imgs.search.brave.com/d77Xlvzq04IAu016SmEvB99bJj0Neogzvnm9r0nYn1o/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/YWR2YW50b3VyLmNv/bS9pbWcvamFwYW4v/dG9reW8vc2Vuc28t/amktdGVtcGxlL3Nl/bnNvLWppLXRlbXBs/ZTQuanBn',
    'Shibuya Crossing':
        'https://imgs.search.brave.com/Z90YSIp0Eew9Ak637hDRTdEPSsnY_z_9PHVcFdUMip8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YW5k/ZXJvbi1pbWFnZXMu/Z3VtbGV0LmlvL2Js/b2dzL25ldy8yMDI0/LzExL3NoaWJ1eWEt/c2NyYW1ibGUtY3Jv/c3NpbmctdnMuLXNo/aW5qdWt1LWNyb3Nz/aW5nLmpwZw',
    'Ichiran Ramen':
        'https://imgs.search.brave.com/g1qUQFXHFeAUBaFZyAtG7JO36CaYjWOLxp8OWtg7ah0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YWJp/c2FiaS1zdG9yZS5q/cC9jZG4vc2hvcC9m/aWxlcy81MVFyekFY/YXhOTC5fQUMuanBn/P3Y9MTcyNTUyMDc2/OCZ3aWR0aD03MjA',
    'Sushi Saito':
        'https://imgs.search.brave.com/3CY_mMjM7oZ5APiDUbbHnKFHJqu3wUlXwQ0ptVPCSJ0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9iNzBm/MDg0ZTI5ZjNmOGZh/ZmZiMC0zODlmZmZj/NWI5MDkzNjYzNWQx/NjZhMzJmZGIxMWI2/YS5zc2wuY2YzLnJh/Y2tjZG4uY29tL2Fu/ZHktaGF5bGVyLXN1/c2hpLXNhaXRvLXN1/c2hpLXNhaXRpbyUy/MDU0NzIlMjBTYWl0/byUyMGluJTIwYWN0/aW9uLWNyb3AtdjEu/SlBH',
  };
  return map[item] ??
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80';
}

String _getDescription(String item) {
  final desc = {
    'Tokyo Tower': 'Iconic tower with stunning skyline views.',
    'Senso-ji Temple': 'Historic Buddhist temple in Asakusa.',
    'Shibuya Crossing': 'Famous intersection with vibrant energy.',
    'Ichiran Ramen': 'Solo ramen booths with amazing tonkotsu broth.',
    'Sushi Saito': 'Michelin-starred sushi dining experience.',
  };
  return desc[item] ?? 'A must-visit spot in Tokyo.';
}

// ---------------- SUB WIDGETS ----------------
class _OverviewItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _OverviewItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

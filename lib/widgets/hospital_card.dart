import 'package:flutter/material.dart';
import 'package:medilink/views/hospital_details.dart';

class hospitalCard extends StatelessWidget {
  const hospitalCard({super.key, required this.h, required this.facilities});

  final dynamic h;
  final List facilities;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HospitalDetailScreen(hospital: h)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE2F1FA)),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Image
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: facilities.isNotEmpty
                    ? Image.network(
                        facilities[0]['icon'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'assets/images/hospital_placeholder.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'assets/images/hospital_placeholder.png',
                        fit: BoxFit.cover,
                      ),
              ),
            ),

            // Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      h['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (i) => Icon(
                              i < (h['rating'] as num).toInt()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: const Color(0xFFFFC107),
                              size: 14,
                            ),
                          ),
                        ),
                        Text(
                          "${h['distance_km']} km",
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    if (facilities.isNotEmpty)
                      Wrap(
                        spacing: 4,
                        children: facilities.take(3).map<Widget>((f) {
                          return CircleAvatar(
                            radius: 10,
                            backgroundImage: NetworkImage(f['icon']),
                            backgroundColor: Colors.grey.shade200,
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

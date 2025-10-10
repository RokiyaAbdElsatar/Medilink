import 'package:flutter/material.dart';

class PharmacyContainer extends StatelessWidget {
  const PharmacyContainer({
    super.key,
    required this.imgUrl,
    required this.mainText,
    required this.subText,
  });

  final String imgUrl;
  final String mainText;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFEBF4FF),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // keeps it as compact as possible
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imgUrl,
                height: 125,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              mainText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            Text(subText, style: const TextStyle(fontSize: 9)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NovelaCard extends StatelessWidget {
  final String titulo;
  final String imageUrl;
  final bool grande;
  final VoidCallback? onTap;

  const NovelaCard({
    super.key,
    required this.titulo,
    required this.imageUrl,
    this.grande = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: grande ? 140 : double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // IMAGEN
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: theme.cardColor, // 🔥 usa tu main
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 6),

            // TITULO
            Text(
              titulo,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: grande ? 16 : 14,
                fontWeight: FontWeight.w600,
                color: Colors.white, // 🔥 consistente con tu app
              ),
            ),
          ],
        ),
      ),
    );
  }
}
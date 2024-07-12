import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
      ),
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: Image.network(
            imageUrl,
            errorBuilder: (BuildContext context, Object error,
                StackTrace? stackTrace) {
              return const Text(
                'Image not available',
                style: TextStyle(color: Colors.red, fontSize: 24),
                textAlign: TextAlign.center,
              );
            },
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
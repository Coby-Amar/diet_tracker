import 'dart:io';

import 'package:diet_tracker/widgets/appbar_themed.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FullScreenExtras {
  final File image;
  final String prevPage;
  final dynamic extras;

  const FullScreenExtras({
    required this.image,
    required this.prevPage,
    required this.extras,
  });
}

class FullScreenImagePage extends StatelessWidget {
  const FullScreenImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final image = GoRouterState.of(context).extra as Uint8List;
    return Scaffold(
      appBar: const AppBarThemed(title: 'תמונה מלאה'),
      body: Image.memory(
        image,
        fit: BoxFit.contain,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}

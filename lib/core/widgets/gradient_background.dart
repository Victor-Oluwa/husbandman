// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class GradientBacground extends StatelessWidget {
  const GradientBacground({
    required this.image, required this.child, super.key,
  });
  final String image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: SafeArea(child: Center(child: child)),
    );
  }
}

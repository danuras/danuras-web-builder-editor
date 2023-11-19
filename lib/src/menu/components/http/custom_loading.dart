import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoading extends StatefulWidget {
  const CustomLoading({super.key});

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0x66000000),
      body: Center(
        child: SpinKitCircle(
          color: Colors.white,
          
          size: 50,
        ),
      ),
    );
  }
}

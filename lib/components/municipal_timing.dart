// lib/components/municipal_timing.dart
import 'package:flutter/material.dart';

// FIX: Renamed class from MunuicipalTiming
class MunicipalTiming extends StatefulWidget {
  
  // FIX: Renamed constructor
  const MunicipalTiming({super.key, required this.start, required this.end});

  final String start;
  final String end;

  @override
  // FIX: Renamed state class
  State<MunicipalTiming> createState() => _MunicipalTimingState();
}

// FIX: Renamed state class
class _MunicipalTimingState extends State<MunicipalTiming> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo, width: 1),
        borderRadius: BorderRadius.circular(15),
        color: Color.fromRGBO(211, 211, 211, 0.8),
      ),
      child: Text(
        "Municipal Water Timing: ${widget.start} - ${widget.end}",
        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }
}
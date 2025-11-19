import 'package:flutter/material.dart';

class PrayerCard extends StatelessWidget {
  final String prayerName;
  final String prayerTime;
  final bool isNextPrayer;

  const PrayerCard({
    Key? key,
    required this.prayerName,
    required this.prayerTime,
    this.isNextPrayer = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isNextPrayer ? Colors.green[50] : Colors.white,
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isNextPrayer ? Colors.green : Colors.grey,
          child: Text(
            prayerName[0],
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          prayerName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isNextPrayer ? Colors.green : Colors.black87,
          ),
        ),
        trailing: Text(
          prayerTime,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isNextPrayer ? Colors.green : Colors.black54,
          ),
        ),
      ),
    );
  }
}

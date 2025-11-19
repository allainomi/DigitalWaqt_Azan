import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/prayer_times.dart';
import '../services/prayer_time_service.dart';
import '../widgets/prayer_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PrayerTimes? _prayerTimes;
  String _nextPrayer = 'Loading...';
  bool _isLoading = true;
  String _location = 'Fetching location...';

  @override
  void initState() {
    super.initState();
    _getPrayerTimes();
  }

  Future<void> _getPrayerTimes() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      setState(() {
        _location = 'Lat: ${position.latitude.toStringAsFixed(2)}, Lon: ${position.longitude.toStringAsFixed(2)}';
      });

      PrayerTimes times = await PrayerTimeService.getPrayerTimes(
        position.latitude,
        position.longitude,
      );

      String nextPrayer = PrayerTimeService.getNextPrayer(times);

      setState(() {
        _prayerTimes = times;
        _nextPrayer = nextPrayer;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _location = 'Location access required';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Waqt Azan'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Next Prayer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _nextPrayer,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        _location,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Prayer Times List
                Expanded(
                  child: _prayerTimes == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Unable to fetch prayer times',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _getPrayerTimes,
                                child: Text('Retry'),
                              ),
                            ],
                          ),
                        )
                      : ListView(
                          children: [
                            PrayerCard(
                              prayerName: 'Fajr',
                              prayerTime: _prayerTimes!.fajr,
                              isNextPrayer: _nextPrayer == 'Fajr',
                            ),
                            PrayerCard(
                              prayerName: 'Sunrise',
                              prayerTime: _prayerTimes!.sunrise,
                              isNextPrayer: false,
                            ),
                            PrayerCard(
                              prayerName: 'Dhuhr',
                              prayerTime: _prayerTimes!.dhuhr,
                              isNextPrayer: _nextPrayer == 'Dhuhr',
                            ),
                            PrayerCard(
                              prayerName: 'Asr',
                              prayerTime: _prayerTimes!.asr,
                              isNextPrayer: _nextPrayer == 'Asr',
                            ),
                            PrayerCard(
                              prayerName: 'Maghrib',
                              prayerTime: _prayerTimes!.maghrib,
                              isNextPrayer: _nextPrayer == 'Maghrib',
                            ),
                            PrayerCard(
                              prayerName: 'Isha',
                              prayerTime: _prayerTimes!.isha,
                              isNextPrayer: _nextPrayer == 'Isha',
                            ),
                          ],
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getPrayerTimes,
        child: Icon(Icons.refresh),
        backgroundColor: Colors.green,
      ),
    );
  }
}

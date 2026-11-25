import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Inisialisasi Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    debugPrint('🔥 Firebase berhasil diinisialisasi');
  } catch (e, s) {
    debugPrint('❌ Gagal menginisialisasi Firebase: $e');
    FirebaseCrashlytics.instance.recordError(e, s);
  }

  runApp(const DHT11MonitoringApp());
}

class DHT11MonitoringApp extends StatelessWidget {
  const DHT11MonitoringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Realtime Monitoring DHT11',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double temperature = 25.0;
  double humidity = 50.0;
  late String time;

  // Data untuk grafik
  final List<FlSpot> _temperatureData = [];
  final List<FlSpot> _humidityData = [];
  int _timeIndex = 0;

  @override
  void initState() {
    super.initState();
    time = _getCurrentTime();

    // Mulai mendengarkan data dari Firestore
    _initializeFirestoreListener();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} '
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
  }

  void _initializeFirestoreListener() {
    FirebaseFirestore.instance
        .collection('sensor_data')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        setState(() {
          temperature = data['temperature'] ?? 25.0;
          humidity = data['humidity'] ?? 50.0;
          time = _getCurrentTime();

          // Tambahkan data ke grafik
          if (_temperatureData.length >= 10) _temperatureData.removeAt(0);
          if (_humidityData.length >= 10) _humidityData.removeAt(0);

          _temperatureData.add(FlSpot(_timeIndex.toDouble(), temperature));
          _humidityData.add(FlSpot(_timeIndex.toDouble(), humidity));

          _timeIndex++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Realtime Monitoring DHT11 Sensor with ESP32',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDataCard(
                      'Temperature',
                      temperature.toStringAsFixed(1),
                      '°C',
                      temperature > 30 ? Colors.red : Colors.yellow,
                    ),
                    const SizedBox(width: 10),
                    _buildDataCard(
                      'Humidity',
                      humidity.toStringAsFixed(0),
                      '%',
                      humidity > 60 ? Colors.red : Colors.green,
                    ),
                    const SizedBox(width: 10),
                    _buildDataCard(
                      'Time',
                      time,
                      '',
                      Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Temperature & Humidity Graph',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildGraph(),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/uii_logo.png',
                  height: 100,
                ),
                const Text(
                  'Universitas Islam Indonesia',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataCard(String label, String value, String unit, Color color) {
    return Flexible(
      child: Card(
        color: color,
        elevation: 4,
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 120,
            maxWidth: 140,
            minHeight: 150,
            maxHeight: 150,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (label == 'Time')
                Column(
                  children: [
                    Text(
                      value.split(' ')[0],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      value.split(' ')[1],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (unit.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          unit,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGraph() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(show: true),
          titlesData: const FlTitlesData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: _temperatureData.isNotEmpty
                  ? _temperatureData
                  : [const FlSpot(0, 0)],
              isCurved: true,
              color: Colors.orange,
              barWidth: 4,
              isStrokeCapRound: true,
            ),
            LineChartBarData(
              spots: _humidityData.isNotEmpty
                  ? _humidityData
                  : [const FlSpot(0, 0)],
              isCurved: true,
              color: Colors.blue,
              barWidth: 4,
              isStrokeCapRound: true,
            ),
          ],
        ),
      ),
    );
  }
}
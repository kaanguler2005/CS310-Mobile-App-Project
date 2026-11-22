import 'package:flutter/material.dart';
import 'Profile.dart';

class StudyTimerPage extends StatefulWidget {
  const StudyTimerPage({super.key});

  @override
  State<StudyTimerPage> createState() => _StudyTimerPageState();
}

class _StudyTimerPageState extends State<StudyTimerPage> {
  bool _running = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Profile profile =
        Profile(); // TODO will be state and loaded from a database
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Back', style: TextStyle(color: Colors.white)),
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          'Study timer',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Home',
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profile',
            onPressed: () {
              // TODO profile
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('TODO go to ProfilePage')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 120),
              const Text(
                "25:00",
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 12),
              const Text('Focus session', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 72),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // TODO start or pause
                      setState(() {
                        _running = !_running;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(150, 55),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      side: const BorderSide(
                        color: Colors.blueAccent,
                        width: 1.5,
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(_running ? 'Pause' : 'Start'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO reset
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(150, 55),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      side: const BorderSide(
                        color: Colors.blueAccent,
                        width: 1.5,
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text('Reset'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              const Text(
                'The Start button says Pause while the timer is running.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Sessions today: ${profile.sessionsToday()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

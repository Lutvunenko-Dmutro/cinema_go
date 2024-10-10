import 'package:flutter/material.dart';
import 'seating_chart_screen.dart';

class MovieSelectionScreen extends StatefulWidget {
  @override
  _MovieSelectionScreenState createState() => _MovieSelectionScreenState();
}

class _MovieSelectionScreenState extends State<MovieSelectionScreen> {
  final List<String> movies = ['Чудо-жінка', 'Месники', 'Зоряні війни'];
  String? selectedMovie;
  String? selectedSession;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Вибір Фільму')),
      body: Center(
        child: Container(
          width: 400,
          height: 600,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Виберіть фільм та сеанс',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                DropdownButton<String>(
                  hint: Text('Виберіть Фільм'),
                  value: selectedMovie,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMovie = newValue;
                      selectedSession = null; // Скидання сеансу
                    });
                  },
                  items: movies.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                DropdownButton<String>(
                  hint: Text('Виберіть Сеанс'),
                  value: selectedSession,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSession = newValue;
                    });
                  },
                  items: [
                    '12:00 PM',
                    '3:00 PM',
                    '6:00 PM',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  onPressed: () {
                    if (selectedMovie != null && selectedSession != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeatingChartScreen(
                            movie: selectedMovie!,
                            session: selectedSession!,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Будь ласка, виберіть фільм та сеанс')),
                      );
                    }
                  },
                  child: Text('Далі', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

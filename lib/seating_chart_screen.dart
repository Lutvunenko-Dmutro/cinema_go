import 'package:flutter/material.dart';

class SeatingChartScreen extends StatefulWidget {
  final String movie;
  final String session;

  SeatingChartScreen({required this.movie, required this.session});

  @override
  _SeatingChartScreenState createState() => _SeatingChartScreenState();
}

class _SeatingChartScreenState extends State<SeatingChartScreen> {
  late List<List<bool>> _seats;
  late List<String> _selectedSeats;

  @override
  void initState() {
    super.initState();
    // Змінено 15 на 30 для місць у ряду
    _seats = List.generate(8, (_) => List.generate(30, (_) => false));
    _selectedSeats = [];
  }

  void _toggleSeat(int row, int col) {
    setState(() {
      _seats[row][col] = !_seats[row][col];
      String seat = 'Ряд ${row + 1} Місце ${col + 1}';
      if (_selectedSeats.contains(seat)) {
        _selectedSeats.remove(seat);
      } else {
        _selectedSeats.add(seat);
      }
    });
  }

  void _confirmSelection() {
    if (_selectedSeats.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Підтверджено Місця: ${_selectedSeats.join(', ')}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Місця не вибрано!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Схема Місць'),
      ),
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
                  '${widget.movie} (${widget.session})',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Flexible(
                  child: Text('Вибрані Місця: ${_selectedSeats.join(', ')}'),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        children: [
                          // Нумерація рядів
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(8, (row) {
                              return Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[200],
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Text('Ряд ${row + 1}'),
                              );
                            }).map((widget) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0), // Відступ між рядами
                              child: widget,
                            )).toList(),
                          ),
                          // Сітка місць
                          Column(
                            children: List.generate(8, (row) {
                              return Row(
                                children: List.generate(30, (col) { // Змінено 15 на 30 для місць у ряду
                                  bool isSelected = _seats[row][col];
                                  return GestureDetector(
                                    onTap: () => _toggleSeat(row, col),
                                    child: Container(
                                      margin: EdgeInsets.all(4.0),
                                      width: 40, // Розмір квадрата
                                      height: 40, // Розмір квадрата
                                      decoration: BoxDecoration(
                                        color: isSelected ? Colors.redAccent : Colors.greenAccent,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${col + 1}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  onPressed: _confirmSelection,
                  child: Text('Підтвердити Вибір', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

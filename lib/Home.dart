import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AddTaskPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class Todo {
  String title;
  DateTime date;
  String description;
  String category;
  bool isDone;

  Todo({
    required this.title,
    required this.date,
    required this.description,
    required this.category,
    this.isDone = false,
  });
}

List<Todo> dummyTasks = [
  
];

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final headingStyle = GoogleFonts.fraunces(
      fontWeight: FontWeight.w600,
      fontSize: 32,
      color: AppColors.ink,
    );
    final bodyStyle = GoogleFonts.inter(fontSize: 14, color: AppColors.inkSoft);
    final labelStyle = GoogleFonts.ibmPlexMono(
      fontSize: 11,
      letterSpacing: 1.2,
      color: AppColors.amber,
    );

    final now = DateTime.now();
    final formatted = DateFormat('EEEE, dd MMMM').format(now);

    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: AppColors.paper,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            formatted.toUpperCase(),
            style: labelStyle,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text('Good morning,\nBilal.', style: headingStyle),
            const SizedBox(height: 4),
            Text('5 tasks left for today', style: bodyStyle),
            const SizedBox(height: 20),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dummyTasks.length,
              itemBuilder: (context, index) {
                final task = dummyTasks[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: CheckboxListTile(
                    value: task.isDone,
                    onChanged: (value) {
                      setState(() {
                        task.isDone = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isDone ? TextDecoration.lineThrough : null,
                        color: task.isDone ? AppColors.done : AppColors.ink,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${task.category} · ${TimeOfDay.fromDateTime(task.date).format(context)}',
                      style: bodyStyle,
                    ),
                  ),
                );
              },
            ),

            FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddTaskPage()),
                );

                setState(() {}); // dummyTasks changed in AddTaskPage, rebuild to show it
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
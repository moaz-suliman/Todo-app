import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_color.dart';
import 'package:todo_app/core/custom_widget/app_button.dart';
import 'package:todo_app/feature/new_task.dart/presintation/provider/new_task_provider.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController notesController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'New Task',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel ',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppColor.secondryColor,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<NewTaskProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  style: GoogleFonts.inter(fontSize: 24),
                  decoration: InputDecoration(
                    hintText: 'What needs to be done?',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 24,
                      color: Colors.grey.shade400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.primaryColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'NOTES',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    color: AppColor.secondryColor,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: notesController,
                  maxLines: 4,
                  style: GoogleFonts.inter(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Add details or notes (optional)',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.grey.shade400,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.shade200,
                ),
                const Spacer(),

                if (provider.error.isNotEmpty)
                  Text(
                    provider.error,
                    style: const TextStyle(color: Colors.red),
                  ),

                const SizedBox(height: 8),
                AppButton(
                  text: provider.isLoading ? 'Saving...' : 'Save Task',
                  onPressed: provider.isLoading
                      ? () {}
                      : () async {
                          final success = await provider.addTask(
                            title: titleController.text,
                            description: notesController.text,
                          );

                          if (!context.mounted) return;

                          if (success) {
                            Navigator.pop(context);
                          }
                        },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

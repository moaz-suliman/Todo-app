import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_color.dart';
import 'package:todo_app/feature/HomePage/presintation/provider/todo_page_povider.dart';
import 'package:todo_app/feature/HomePage/presintation/widget/build_filter_tap.dart';
import 'package:todo_app/feature/auth/login/presintation/provider/user_provider.dart';
import 'package:todo_app/feature/new_task.dart/presintation/view/new_task_page.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    super.initState();

    context.read<TodoPagePovider>().getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'My Tasks',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                context.read<UserProvider>().logOut(context);
              },
              icon: const Icon(
                Icons.logout_rounded,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewTaskPage()),
          );
          if (mounted) {
            context.read<TodoPagePovider>().getTasks();
          }
        },
        backgroundColor: AppColor.primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),

      body: Consumer<TodoPagePovider>(
        builder: (context, provider, child) {
          final filteredTasks = provider.tasks.where((task) {
            if (provider.selectedFilter == 'Active') {
              return task.isDone != true;
            }

            if (provider.selectedFilter == 'Completed') {
              return task.isDone == true;
            }

            return true;
          }).toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    BuildFilterTap(filter: 'All'),
                    const SizedBox(width: 24),
                    BuildFilterTap(filter: 'Active'),
                    const SizedBox(width: 24),
                    BuildFilterTap(filter: 'Completed'),
                  ],
                ),

                const SizedBox(height: 12),
                Divider(height: 1, color: Colors.grey.shade200),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (provider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (provider.error.isNotEmpty) {
                        return Center(
                          child: Text(
                            provider.error,
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else if (filteredTasks.isEmpty) {
                        return const Center(child: Text('No tasks found'));
                      } else {
                        return ListView.separated(
                          itemCount: filteredTasks.length,
                          separatorBuilder: (context, index) =>
                              Divider(height: 1, color: Colors.grey.shade200),
                          itemBuilder: (context, index) {
                            final task = filteredTasks[index];

                            return ListTile(
                              contentPadding: EdgeInsets.zero,

                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return AlertDialog(
                                      title: const Text('Remove task'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(dialogContext).pop();
                                          },
                                          child: const Text('cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.of(dialogContext).pop();

                                            final taskIndex = provider.tasks
                                                .indexOf(task);

                                            if (taskIndex != -1) {
                                              await provider.removeTask(
                                                taskIndex,
                                              );
                                            }
                                          },
                                          child: const Text(
                                            'remove',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },

                              // تغيير حالة إكمال المهمة
                              onTap: () {
                                provider.toggleTaskCompletion(
                                  provider.tasks.indexOf(task),
                                );
                              },

                              leading: Icon(
                                task.isDone == true
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                size: 28,
                                color: task.isDone == true
                                    ? AppColor.primaryColor
                                    : Colors.grey.shade300,
                              ),

                              title: Text(
                                task.title ?? '',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  decoration: task.isDone == true
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: task.isDone == true
                                      ? Colors.grey
                                      : Colors.black87,
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

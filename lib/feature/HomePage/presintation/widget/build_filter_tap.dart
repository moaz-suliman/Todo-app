import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_color.dart';
import 'package:todo_app/feature/HomePage/presintation/provider/todo_page_povider.dart';

class BuildFilterTap extends StatelessWidget {
  final String filter;
  const BuildFilterTap({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    String selectedFilter = context.read<TodoPagePovider>().selectedFilter;
    final isSelected = selectedFilter == filter;

    return GestureDetector(
      onTap: () {
        selectedFilter = filter;
        context.read<TodoPagePovider>().changeSelectedFilter(filter);
      },
      child: Text(
        filter,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isSelected ? AppColor.primaryColor : AppColor.secondryColor,
        ),
      ),
    );
  }
}

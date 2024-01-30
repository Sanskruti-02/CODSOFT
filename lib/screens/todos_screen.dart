import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/universal_provider.dart';

class TodosScren extends StatefulWidget {
  const TodosScren({super.key});

  @override
  State<TodosScren> createState() => _TodosScrenState();
}

class _TodosScrenState extends State<TodosScren> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UniversalProvider>(
      builder: (context, universalProvider, child) =>
          universalProvider.dataModel == null
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                ))
              : Scaffold(
                  body: universalProvider.incompleteTask!.isEmpty
                      ? SingleChildScrollView(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 60.h,
                                ),
                                Image.asset(
                                  'assets/no_tasks.png',
                                  height: 300.h,
                                  width: 300.w,
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                Text(
                                  'Add a task and get to work on it!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                    color: Colors.deepPurple.withOpacity(0.8),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'Today is your canvas.',
                                  style: TextStyle(
                                    color: Colors.deepPurple.withOpacity(0.8),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                          child: ListView.builder(
                            itemCount: universalProvider.incompleteTask!.length,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(
                                  bottom: universalProvider
                                              .incompleteTask!.length ==
                                          index + 1
                                      ? 100.h
                                      : 10.h),
                              child: universalProvider.incompleteTask![index],
                            ),
                          ),
                        ),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Colors.deepPurple,
                    child: const Icon(
                      Icons.add_task_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () =>
                        universalProvider.showAddTaskDialog(context),
                  ),
                ),
    );
  }
}

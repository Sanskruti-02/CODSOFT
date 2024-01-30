import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/universal_provider.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
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
                  body: universalProvider.completedTask!.isEmpty
                      ? SingleChildScrollView(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 60.h,
                                ),
                                Image.asset(
                                  'assets/no_completed_tasks.png',
                                  height: 300.h,
                                  width: 300.w,
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                Text(
                                  'Your canvas awaits!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                    color: Colors.deepPurple.withOpacity(0.8),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "Let's add a new task and get to work.",
                                  style: TextStyle(
                                    color: Colors.deepPurple.withOpacity(0.8),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                                SizedBox(
                                  width: 150.w,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.deepPurple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.r),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      universalProvider
                                          .showAddTaskDialog(context);
                                    },
                                    child: Text(
                                      'Add Task',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
                            itemCount: universalProvider.completedTask!.length,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: universalProvider.completedTask![index],
                            ),
                          ),
                        ),
                ),
    );
  }
}

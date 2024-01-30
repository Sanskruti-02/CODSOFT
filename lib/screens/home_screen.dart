import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/universal_provider.dart';
import '../screens/completed_screen.dart';
import '../screens/todos_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> pages = [
    const TodosScren(),
    const CompletedScreen(),
  ];

  @override
  void initState() {
    Provider.of<UniversalProvider>(context, listen: false).loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UniversalProvider>(
      builder: (context, universalProvider, child) => Scaffold(
        appBar: AppBar(
          title: const Text('ToDo'),
          centerTitle: true,
          surfaceTintColor: Colors.white,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
            fontSize: 20.sp,
          ),
        ),
        body: PageView.builder(
          controller: universalProvider.pageController,
          onPageChanged: (index) => universalProvider.currentScreenInd = index,
          itemCount: pages.length,
          itemBuilder: (context, index) => pages[index],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey[300]!,
              ),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            currentIndex: universalProvider.currentScreenInd,
            onTap: (index) {
              universalProvider.pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.linear);
              universalProvider.currentScreenInd = index;
            },
            backgroundColor: Colors.white,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                label: 'Tasks',
                icon: Icon(
                  Icons.format_list_numbered_rounded,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Completed',
                icon: Icon(Icons.task_alt_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

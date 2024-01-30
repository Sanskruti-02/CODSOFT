import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quotes/providers/universal_provider.dart';
import '../screens/favorites_screen.dart';
import '../screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 867.4),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UniversalProvider())
        ],
        child: MaterialApp(
          title: 'Quotes',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              titleTextStyle: TextStyle(
                color: Colors.deepPurple,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            scaffoldBackgroundColor: Colors.white,
          ),
          initialRoute: 'home',
          routes: {
            'home': (context) => const HomeScreen(),
            'favourites': (context) => const FavoritesScreen(),
          },
        ),
      ),
    );
  }
}

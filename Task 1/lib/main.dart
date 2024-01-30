import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/home_screen.dart';
import '../providers/universal_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
    ));
    return ScreenUtilInit(
      designSize: const Size(392.72, 872.72),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UniversalProvider(),
          )
        ],
        child: MaterialApp(
          title: 'ToDo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
            scaffoldBackgroundColor: Colors.white,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
          initialRoute: 'home',
          routes: {
            'home': (context) => const HomeScreen(),
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';

import 'package:anysynx/features/tiktok/tiktok_screen.dart';
import 'package:anysynx/features/instagram/instagram_screen.dart';
import 'package:anysynx/features/youtube/youtube_screen.dart';
import 'package:anysynx/features/x/x_screen.dart';
import 'package:anysynx/features/about/about_screen.dart';

final List<Widget Function()> _tabs = [
  () => TikTokDownloaderScreen(),
  () => InstagramDownloaderScreen(),
  () => YouTubeDownloaderScreen(),
  () => XDownloaderScreen(),
  () => AboutDownloaderScreen(),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnySynx',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/":
            return MaterialPageRoute(builder: (_) => HomePage());
          case "/tiktok":
            return MaterialPageRoute(builder: (_) => TikTokDownloaderScreen());
          case "/instagram":
            return MaterialPageRoute(
              builder: (_) => InstagramDownloaderScreen(),
            );
          default:
            return MaterialPageRoute(builder: (_) => TikTokDownloaderScreen());
        }
      },
    );
  }
}

class ButtonMove extends StatelessWidget {
  const ButtonMove({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed("/tiktok"),
                child: const Text("Tiktok Downloader"),
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed("/instagram"),
                child: const Text("Instagram Downloader"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;

  void _handleIndexChanged(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // body: SizedBox(
      //   height: MediaQuery.of(context).size.height,
      //   child: Image.network(
      //     "https://mrahkat.net/wp-content/uploads/2019/07/unnamed-file-416.jpg",
      //     fit: BoxFit.fitHeight,
      //   ),
      // ),
      body: Column(
        children: [
          _tabs[_currentIndex](),
          SizedBox(height: 20.0),
        ],
      ),
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: _currentIndex,
        height: 10,
        // indicatorColor: Colors.blue,
        unselectedItemColor: Colors.white70,
        borderWidth: 1,
        outlineBorderColor: Colors.white.withValues(alpha: 0.3),
        backgroundColor: Colors.black.withValues(alpha: 0.2),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withValues(alpha: 0.1),
        //     blurRadius: 4,
        //     spreadRadius: 4,
        //     offset: Offset(0, 10),
        //   ),
        // ],
        onTap: _handleIndexChanged,
        items: [
          CrystalNavigationBarItem(
            icon: Icons.tiktok,
            unselectedIcon: Icons.tiktok_outlined,
            selectedColor: Colors.white,
            badge: Badge(
              label: Text("9+", style: TextStyle(color: Colors.white)),
            ),
          ),

          CrystalNavigationBarItem(
            icon: Icons.insert_chart,
            unselectedIcon: Icons.insert_chart,
            selectedColor: Colors.white,
          ),

          CrystalNavigationBarItem(
            icon: Icons.youtube_searched_for,
            unselectedIcon: Icons.youtube_searched_for,
            selectedColor: Colors.white,
          ),

          CrystalNavigationBarItem(
            icon: Icons.close,
            unselectedIcon: Icons.close,
            selectedColor: Colors.white,
          ),

          CrystalNavigationBarItem(
            icon: Icons.person,
            unselectedIcon: Icons.person,
            selectedColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

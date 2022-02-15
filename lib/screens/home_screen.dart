import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_motion_demo/models/receipe_model.dart';
import 'package:flutter_motion_demo/routers/motion_animator.dart';
import 'package:flutter_motion_demo/screens/add_receipe_screen.dart';
import 'package:flutter_motion_demo/screens/home_views/profile_view.dart';
import 'package:flutter_motion_demo/screens/home_views/recipes_view.dart';
import 'package:flutter_motion_demo/routers/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ReceipeModel> _receipes = [];
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _fetchReceipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipes'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNav(),
      body: _currentView(),
      floatingActionButton: MotionAnimator().containerTransformTransition(
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide.none,
        ),
        closedBuilder: (context, openContainer) => FloatingActionButton(
          onPressed: () => openContainer(),
          child: const Icon(Icons.add),
        ),
        openBuilder: (context, closeContainer) => const AddReceipeScreen(),
      ),
    );
  }

  Widget _bottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentTab,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: (index) => setState(() => _currentTab = index),
      items: [
        _bottomNavItem(Icons.home, 'Receipes'),
        _bottomNavItem(Icons.person, 'Profile'),
      ],
    );
  }

  BottomNavigationBarItem _bottomNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }

  Widget _currentView() {
    return MotionAnimator().fadeThroughWidgetTransition(
      child: _currentTab == 0 ? RecipesView(receipes: _receipes) : const ProfileView(),
    );
  }

  Future<void> _fetchReceipes() async {
    final jsonStr = await rootBundle.loadString('assets/receipes.json');
    final jsonData = jsonDecode(jsonStr);
    _receipes.addAll((jsonData['receipes'] as List).map((e) => ReceipeModel.fromJSON(e)));
    setState(() {});
  }
}

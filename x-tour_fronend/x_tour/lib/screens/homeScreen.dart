import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_tour/routes/route_constants.dart';
import 'package:x_tour/screens/journalListScreen.dart';
import '../screens/screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('HomeScreen'));

  final StatefulNavigationShell navigationShell;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onTap(BuildContext context, int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  Widget _buildBottomNavigationItem(
    int index,
    IconData iconData,
  ) {
    final isSelected = index == _selectedIndex;
    final iconColor = isSelected ? const Color.fromARGB(255, 24,217,163) : Colors.grey;
    final dotColor = isSelected ? Color.fromARGB(255, 24, 217, 163) : Colors.transparent;

    return GestureDetector(
      onTap: () => _onTap(context, index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
      
            children: [
              Icon(
                iconData,
                color: iconColor,
                size: 25,
              ),
              SizedBox(height: 8),
              if (isSelected)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dotColor,
                  ),
                ),
            ],
          ),
          
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavigationItem(
                0,
                Icons.home
                
              ),
              _buildBottomNavigationItem(
                1,
                Icons.search
              ),
              _buildBottomNavigationItem(
                2,
                Icons.article_outlined
              ),
              _buildBottomNavigationItem(
                3,
                Icons.account_circle
              ),
            ],
          ),
        ),
      ),
    );
  }
}

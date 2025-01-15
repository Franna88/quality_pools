import 'package:flutter/material.dart';
import 'package:quality_pools/HomePage/home_page.dart';
import 'package:quality_pools/MyPools/my_pools.dart';
import 'package:quality_pools/main_page_layout.dart';
import 'package:quality_pools/Settings/settings_tab.dart';
import 'package:quality_pools/Themes/quality_pool_textstyle.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Color(0XFF1A8CF0),
      icon: Icon(
        Icons.menu,
        color: Colors.white,
        size: 30,
      ),
      onSelected: (String value) {
        switch (value) {
          case 'Home':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
            break;
          case 'My Pools':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyPools(),
              ),
            );
            break;
          case 'Settings':
            // Navigate to SettingsTab
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsTab(),
              ),
            );
            break;
          case 'Logout':
            Navigator.pushNamed(context, '/login');
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        _buildMenuItem(
          context,
          'Home',
          Icons.home_outlined,
        ),
        _buildMenuItem(context, 'My Pools', Icons.water),
        _buildMenuItem(context, 'Settings', Icons.settings),
        _buildMenuItem(context, 'Logout', Icons.logout),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem(
      BuildContext context, String title, IconData icon) {
    return PopupMenuItem(
      value: title,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 4.0,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: QualityPoolTextstyle(context).blackStyleBody,
              ),
              SizedBox(width: 20),
              Icon(
                icon,
                color: Color(0XFF095BB2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

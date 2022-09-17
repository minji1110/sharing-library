import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_library/common/common_color.dart';
import 'package:sharing_library/provider/my_home_provider.dart';
import 'package:sharing_library/screen/my_home/my_home_view.dart';
import 'package:sharing_library/screen/my_home/my_home_view_model.dart';

class MainTabBar extends StatefulWidget {
  @override
  _MainTabBarState createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyHomeProvider()),
        ChangeNotifierProvider(create: (context) => MyHomeViewModel()),
      ],
      child: Scaffold(
        backgroundColor: lightBrown,
        body: Container(
          padding: EdgeInsets.only(bottom: 15.0),
          child: TabBarView(
            controller: _tabController,
            children: [MyHomeView(), Container(), Container(), Container()],
          ),
        ),
        bottomNavigationBar: TabBar(
          unselectedLabelColor: darkBrown,
          indicatorColor: Colors.transparent,
          labelPadding: EdgeInsets.only(bottom: 15.0),
          labelColor: Colors.white,
          tabs: [
            _setTabItem(Icons.menu_book_outlined, 'Home'),
            _setTabItem(Icons.favorite_outline, 'Like'),
            _setTabItem(Icons.chat_bubble_outline, 'Chat'),
            _setTabItem(Icons.person_outline, 'My'),
          ],
          controller: _tabController,
        ),
      ),
    );
  }

  Tab _setTabItem(icons, label) {
    return Tab(
        child: Column(
      children: [
        Icon(
          icons,
          size: 28.0,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12.0),
        )
      ],
    ));
  }
}

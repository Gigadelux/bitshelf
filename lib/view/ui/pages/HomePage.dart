
import 'package:bitshelf/view/ui/pages/BookPage.dart';
import 'package:bitshelf/view/ui/pages/ProfilePage.dart';
import 'package:bitshelf/view/ui/pages/SettingPage.dart';
import 'package:bitshelf/view/ui/widgets/NavigatorButton.dart';
import 'package:bitshelf/view/ui/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = [Bookpage(),Profilepage(),Settingpage()];
  List<String> selecters_titles = ["Manage Books", "Profile", "Settings"];
  List<IconData> selecters_icons = [Icons.book, Icons.person, Icons.settings];
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            navigationButtons: List.generate(selecters_titles.length, 
              (int index){
                return NavigatorButton(
                  title: selecters_titles[index], 
                  icon: selecters_icons[index], 
                  onPressed: ()=>setState(() {
                    selected = index;
                  }), 
                  selected: index==selected);
              }
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: selected,
              children: pages,
            ),
          )
        ],
      ),
    );
  }
}

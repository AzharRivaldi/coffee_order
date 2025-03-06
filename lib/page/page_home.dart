import 'package:coffee_shop/fragment/fragment_history.dart';
import 'package:coffee_shop/fragment/fragment_home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  static const List _bodyView = <Widget>[
    FragmentHome(),
    FragmentHistory()
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  final List<String> _labels = ['For You', 'History Order'];

  @override
  Widget build(BuildContext context) {
    List<Widget> icons = const [
      Icon(Icons.coffee),
      Icon(Icons.history_edu),
    ];

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfff8f8f8),
        centerTitle: true,
        title: const Text(
          "Coffee Shop",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff2c2c2c)),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
              Icons.coffee_maker_outlined,
            color: Color(0xff1B100E),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
                Icons.arrow_drop_down_circle_outlined,
              color: Color(0xff1B100E),
            ),
          ),
        ],
      ),
      body: Center(
        child: _bodyView.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            color: const Color(0xFF493628),
            child: TabBar(
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xFFFFF4EA),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide.none,
                ),
                tabs: [
                  for (int i = 0; i < icons.length; i++)
                    _tabItem(
                      icons[i],
                      _labels[i],
                      isSelected: i == _selectedIndex,
                    ),
                ],
                controller: _tabController),
          ),
        ),
      ),
    );
  }
}

Widget _tabItem(Widget child, String label, {bool isSelected = false}) {
  return AnimatedContainer(
      margin: const EdgeInsets.all(8),
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 500),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFDFA878),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          child,
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      )
  );
}
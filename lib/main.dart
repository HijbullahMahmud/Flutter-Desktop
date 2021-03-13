import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Desktop',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Desktop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDark = false;
  int _index = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreenContent(),
    HomeScreenContent(),
    HomeScreenContent(),
    HomeScreenContent(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _index,
        elevation: 10.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.music_video),
              label: "Video",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: "Discover",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              backgroundColor: Colors.blue),
        ],
      ),
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  bool isDark = false;
  List<String> categories = [
    "Top Storis",
    "Latest",
    "Politics",
    "Tech",
    "Sports",
    "Entertainment",
    "World",
    "Religion"
  ];
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    isDark = false;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Container(
            color: Colors.amber,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          );
        }),
      ),
      body: _mainContentUI(),
    );
  }

  Widget _mainContentUI() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    setState(() {
                      this.selectedCategoryIndex = index;
                    });
                    print("Category selected at $index");
                  },
                  child: HomeScreenCategoryListRow(
                      name: categories[index],
                      isSelected: selectedCategoryIndex == index),
                ),
              ),
            ),
          ),

          //slider list
          SliverToBoxAdapter(
            child: Container(
              height: 270,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                        child: SliderListRow(
                          isDark: isDark,
                        ),
                      )),
            ),
          ),

          //article list
          SliverToBoxAdapter(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 20,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => InkWell(
                child: ArticleListRow(isDark: isDark),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HomeScreenCategoryListRow extends StatelessWidget {
  bool isSelected;
  String name;

  HomeScreenCategoryListRow(
      {Key key, @required this.name, @required this.isSelected})
      : super(key: key);
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      child: Card(
        color: Colors.blue,
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: StrutStyle(fontSize: 12.0),
                  text: TextSpan(text: this.name),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              child: Container(
                height: 3,
                color: Colors.white,
              ),
              visible: this.isSelected,
            )
          ],
        ),
      ),
    );
  }
}

class SliderListRow extends StatelessWidget {
  bool isDark;

  SliderListRow({Key key, @required this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  color: Colors.blue),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: StrutStyle(fontSize: 20),
                  maxLines: 2,
                  text: TextSpan(
                      text: "The Belarusian president has placed army on as"),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                child: Row(
                  children: [
                    Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.amber),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sheena Niru",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "15 Feb 2021",
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.bookmark_outline_outlined,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.favorite_outline_outlined,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleListRow extends StatelessWidget {
  bool isDark;

  ArticleListRow({Key key, @required this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 140,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 140,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0)),
                    color: Colors.blue),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            strutStyle: StrutStyle(fontSize: 20),
                            maxLines: 3,
                            text: TextSpan(
                                text:
                                    "Article title Article title Article title Article title Article title Article title Article title Article title ",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.black)),
                          ),
                        ),
                      ),
                      // Text(
                      //     "Article title Article title Article title Article title Article title Article title Article title Article title ",
                      //     //overflow: TextOverflow.visible,
                      //     maxLines: 3,
                      //     style: TextStyle(
                      //         fontSize: 20,
                      //         color: isDark
                      //             ? ColorRes.textColorDark
                      //             : ColorRes.textColorLight)),
                      //
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '2h',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              width: 1.5,
                              height: 15,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Business',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.message_rounded,
                            size: 18,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              '45',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

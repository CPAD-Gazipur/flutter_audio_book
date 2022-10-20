import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_audio_book/widgets/custom_tab_container.dart';

import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List popularBooks = [];

  late ScrollController _scrollController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();

    readJSONFiles();
  }

  readJSONFiles() async {
    await DefaultAssetBundle.of(context)
        .loadString('assets/json/popular_books.json')
        .then((popularBookJSON) {
      setState(() {
        popularBooks = json.decode(popularBookJSON);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ImageIcon(
                      AssetImage('assets/images/menu.png'),
                      size: 18,
                      color: Colors.black,
                    ),
                    Row(
                      children: const [
                        Icon(Icons.search),
                        SizedBox(width: 15),
                        Icon(Icons.notifications),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.only(
                  left: 15,
                ),
                child: Row(
                  children: const [
                    Text(
                      'Popular Books',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 160,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -20,
                      right: -25,
                      child: SizedBox(
                        height: 160,
                        child: PageView.builder(
                          controller: PageController(viewportFraction: 0.8),
                          itemCount:
                              popularBooks.isEmpty ? 0 : popularBooks.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 160,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage(
                                    popularBooks[index]['image'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: AppColors.backgroundColor,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(30),
                          child: Container(
                            margin: const EdgeInsets.only(
                              bottom: 15,
                            ),
                            child: TabBar(
                              indicatorPadding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(
                                right: 10,
                                left: 10,
                              ),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 7,
                                    offset: const Offset(0, 0),
                                  )
                                ],
                              ),
                              tabs: const [
                                CustomTabContainer(
                                  title: 'New',
                                  color: AppColors.menu1Color,
                                ),
                                CustomTabContainer(
                                  title: 'Popular',
                                  color: AppColors.menu2Color,
                                ),
                                CustomTabContainer(
                                  title: 'Trending',
                                  color: AppColors.menu3Color,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: const [
                      Material(
                        child: ListTile(
                          title: Text('Content'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ),
                      Material(
                        child: ListTile(
                          title: Text('Content'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ),
                      Material(
                        child: ListTile(
                          title: Text('Content'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

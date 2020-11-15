import 'package:anisan/constants/MyColors.dart';
import 'package:anisan/constants/sizeConfig.dart';
import 'package:anisan/state/auth/auth.dart';
import 'package:anisan/views/screens/location/request/request_location.dart';
import 'package:anisan/views/screens/login/login.dart';
import 'package:anisan/views/screens/profile/profile.dart';
import 'package:anisan/views/screens/refer/refer.dart';
import 'package:anisan/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_swiper/flutter_swiper.dart';

import 'components/DrawerTitle.dart';
import 'components/ListItem.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<String> imageList = [
    'https://cdn.pixabay.com/photo/2015/02/24/15/41/dog-647528_960_720.jpg',
    "https://media.istockphoto.com/photos/child-hands-formig-heart-shape-picture-id951945718?k=6&m=951945718&s=612x612&w=0&h=ih-N7RytxrTfhDyvyTQCA5q5xKoJToKSYgdsJ_mHrv0=",
    "https://static.toiimg.com/thumb/msid-58475411,width-748,height-499,resizemode=4,imgsize-142947/.jpg",
    "https://m.hindustantimes.com/rf/image_size_444x250/HT/p2/2020/05/21/Pictures/_037138a2-9b47-11ea-a010-c71373fc244b.jpg",
    "https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search/jcr_content/main-pars/image/visual-reverse-image-search-v2_intro.jpg"
  ];

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  int tabindex = 0;
  bool showSearchAction = false, categorySelected = false;

  TabController controller;
  ScrollController _scrollController;

  handleState() => (mounted) ? setState(() => null) : null;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
    _scrollController = new ScrollController()
      ..addListener(() {
        showSearchAction = _isAppBarExpanded;
        handleState();
      });
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    Sizes().init(context);

    return Scaffold(
      key: _drawerKey,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildAppBar(context),
          if (categorySelected) ...[
            _buildAppBar2(context),
            SliverFillRemaining(
              child: TabBarView(
                controller: controller,
                children: <Widget>[
                  Center(child: Text("Tab 1")),
                  Center(child: Text("Tab 2")),
                  Center(child: Text("Tab 3")),
                ],
              ),
            )
          ] else ...[
            _buildCategory(),
            SliverFillRemaining(
              child: Column(
                children: [
                  _buildSlider(),
                  _buildComplimentBox(),
                  _buildOfferBox(),
                  _buildAnisanPlusBox()
                ],
              ),
            )
          ],
        ],
      ), // Th
      drawer: Drawer(
        child: Container(
          color: MyColors.primaryColorSwatch.shade900,
          child: ListView(
            children: [
              DrawerHeader(
                child: DrawerTitle('Anisan'),
              ),
              ListItem('home'.trim().toUpperCase(), () {
                //Navigator.of(context).pushReplacementNamed(Routes.home);
              }),
              ListItem('My Account'.trim(), () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => Profile()));
              }),
              ListItem('My Orders'.trim(), () {
                //Navigator.of(context).pushReplacementNamed(Routes.home);
              }),
              ListItem('Credits'.trim(), () {
                //Navigator.of(context).pushReplacementNamed(Routes.home);
              }),
              ListItem('Refer'.trim(), () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) => Refer()));
              }),
              ListItem('Terms and Conditions'.trim(), () {
                //Navigator.of(context).pushReplacementNamed(Routes.home);
              }),
              ListItem('FAQ\'s'.trim(), () {
                //Navigator.of(context).pushReplacementNamed(Routes.home);
              }),
              ListItem('Privacy Policy'.trim(), () {
                //Navigator.of(context).pushReplacementNamed(Routes.home);
              }),
              ListItem('Share'.trim(), () {
                //Navigator.of(context).pushReplacementNamed(Routes.home);
              }),
            ],
          ),
        ),
      ), // is trailing comma makes auto-formatting nicer for build methods.
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: Sizes.screenHeight * 0.2,
      floating: false,
      pinned: true,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        onPressed: () => _drawerKey.currentState.openDrawer(),
      ),
      actions: [
        if (showSearchAction) ...[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.grey.shade700,
            ),
            onPressed: () {},
          ),
        ],
        IconButton(
          icon: Icon(
            Icons.location_on,
            color: Colors.grey.shade700,
          ),
          onPressed: () {
            return Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => RequestLocation()));
          },
        ),
        IconButton(
          icon: Icon(
            Icons.account_circle_rounded,
            color: Colors.grey.shade700,
          ),
          onPressed: () {
            if (Auth.auth.currentUser == null)
              return Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (context) => Login()));

            Navigator.of(context)
                .push(new MaterialPageRoute(builder: (context) => Profile()));
          },
        ),
      ],
      elevation: 0,
      flexibleSpace: Container(
        height: Sizes.screenHeight * 0.3,
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: Sizes.appBarHeight,
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    hintText: "Search for restaurant or dishes",
                    suffixIcon: Icon(Icons.search)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverPersistentHeader _buildCategory() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 40.0,
        maxHeight: 60.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), color: Colors.white),
              width: 100.0,
              child: Card(
                child: Text('data'),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar2(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        maxHeight: Sizes.appBarHeight,
        minHeight: Sizes.appBarHeight,
        child: new TabBar(
          indicatorColor: Colors.red,
          isScrollable: true,
          tabs: [
            new Tab(
              child: Container(
                child: Icon(
                  Icons.list,
                  color: Colors.grey,
                ),
              ),
            ),
            new Tab(
              child: Container(
                child: Icon(
                  Icons.list,
                  color: Colors.grey,
                ),
              ),
            ),
            new Tab(
              child: Container(
                child: Icon(
                  Icons.list,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
          controller: controller,
        ),
      ),
      pinned: true,
    );
  }

  Widget _buildSlider() {
    return SizedBox(
      height: Sizes.screenHeight * 0.3,
      width: double.infinity,
      child: Swiper(
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            child: PNetworkImage(
              imageList[index],
              fit: BoxFit.fill,
            ),
          );
        },
        viewportFraction: 1.0,
        scale: 1.0,
        itemCount: imageList.length,
        layout: SwiperLayout.DEFAULT,
        loop: true,
        onTap: (value) {
          //return onTap(value);
        },
        pagination: new SwiperPagination(builder: new SwiperCustomPagination(
            builder: (BuildContext context, SwiperPluginConfig config) {
          return new ConstrainedBox(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: new DotSwiperPaginationBuilder(
                      color: Colors.white,
                      activeColor: Colors.red.shade600,
                      size: 10.0,
                      activeSize: 15.0)
                  .build(context, config),
            ),
            constraints: new BoxConstraints.expand(height: 50.0),
          );
        })),
      ),
    );
  }

  Widget _buildOfferBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        width: Sizes.screenWidth,
        height: Sizes.screenHeight * 0.1,
        decoration: BoxDecoration(
          color: Colors.yellow.shade700,
        ),
        child: Text(
          'Offer Box',
          textScaleFactor: 1.4,
        ),
      ),
    );
  }

  Widget _buildComplimentBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        width: Sizes.screenWidth,
        height: Sizes.screenHeight * 0.1,
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: Text(
          'Compliment Box',
          textScaleFactor: 1.4,
        ),
      ),
    );
  }

  Widget _buildAnisanPlusBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        width: Sizes.screenWidth,
        height: Sizes.screenHeight * 0.1,
        decoration: BoxDecoration(
          color: Colors.blue.shade400,
        ),
        child: Text(
          'Join Anisan Plus Box',
          textScaleFactor: 1.4,
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

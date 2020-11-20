import 'package:anisan/constants/MyColors.dart';
import 'package:anisan/constants/sizeConfig.dart';
import 'package:anisan/views/screens/home/components/dotted_line.dart';
import 'package:anisan/views/screens/profile/profile.dart';
import 'package:anisan/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Home2 extends StatefulWidget {
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  int _selectedIndex = 0;

  List<String> imageList = [
    'https://cdn.pixabay.com/photo/2015/02/24/15/41/dog-647528_960_720.jpg',
    "https://media.istockphoto.com/photos/child-hands-formig-heart-shape-picture-id951945718?k=6&m=951945718&s=612x612&w=0&h=ih-N7RytxrTfhDyvyTQCA5q5xKoJToKSYgdsJ_mHrv0=",
    "https://static.toiimg.com/thumb/msid-58475411,width-748,height-499,resizemode=4,imgsize-142947/.jpg",
    "https://m.hindustantimes.com/rf/image_size_444x250/HT/p2/2020/05/21/Pictures/_037138a2-9b47-11ea-a010-c71373fc244b.jpg",
    "https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search/jcr_content/main-pars/image/visual-reverse-image-search-v2_intro.jpg"
  ];

  List<String> categoryImg = [
    "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/delish-190808-baked-drumsticks-0205-portrait-pf-1567089281.jpg?crop=1.00xw:0.667xh;0,0.150xh&resize=768:*",
    "https://images2.minutemediacdn.com/image/upload/c_crop,h_843,w_1500,x_0,y_10/v1555172614/shape/mentalfloss/iStock-177369626_1.jpg?itok=YfyNMOBR",
    "https://api.time.com/wp-content/uploads/2019/11/fish-with-human-face-tik-tok-video.jpg?quality=85&w=1200&h=628&crop=1"
  ];

  List<String> categoryTitle = ['Chicken', 'Goat', "Fish"];

  handleState() => (mounted) ? setState(() => null) : null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: MyColors.primaryColor, // Color for Android
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness:
            Brightness.light // Dark == white status bar -- for IOS.
        ));

    return Scaffold(
      key: _drawerKey,
      drawer: Drawer(
        child: ListView(
          children: [
            drawerTile(
                label: 'Profile',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => Profile()));
                })
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [_appBar(), _buildContentFrame()],
        ),
      ),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  BottomNavigationBar _bottomNavBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          label: 'Order',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.apps_outlined),
          label: 'Category',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'List',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.black54,
      onTap: (index) {
        _selectedIndex = index;
        handleState();
      },
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedIconTheme: IconThemeData(size: 32),
      unselectedIconTheme: IconThemeData(size: 24),
      selectedLabelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
      ),
    );
  }

  Widget _buildError(
      {String error = 'Something went wrong.\nPlease try again later'}) {
    return Flexible(
      child: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        child: Text(
          error,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          textScaleFactor: 2,
        ),
      ),
    );
  }

  Widget _appBar() {
    return Container(
      color: MyColors.primaryColor,
      height: Sizes.appBarHeight + Sizes.appBarHeight,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _sizedBox(
              h: 40,
              w: double.infinity,
              child: Row(
                children: [
                  _sizedBox(w: 10),
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                        size: 28,
                      ),
                      onPressed: () => _drawerKey.currentState.openDrawer()),
                  _sizedBox(w: 10),
                  Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                  _sizedBox(w: 10),
                  _searchBoxAppBar(),
                  _sizedBox(w: 20),
                  IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                        size: 28,
                      ),
                      onPressed: () {}),
                  _sizedBox(w: 10),
                ],
              )),
        ),
      ),
    );
  }

  Widget _searchBoxAppBar() {
    return Flexible(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: DottedLine(
              dashColor: Colors.black,
              lineThickness: 2,
              dashGapLength: 6,
              dashLength: 6,
              dashGapColor: Colors.transparent,
              direction: Axis.horizontal,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Location - Mumbai, Navi Mumbai",
                  border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }

  Widget _sizedBox({double h = 0, double w = 0, Widget child}) {
    return SizedBox(
      width: w,
      height: h,
      child: child,
    );
  }

  Widget _buildContentFrame() {
    return Flexible(
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: MyColors.primaryColor,
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
                color: MyColors.backgroudColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(60))),
            child: Stack(
              children: [
                if (_selectedIndex == 0) ...[
                  _buildOrderPage()
                ] else if (_selectedIndex == 1)
                  ...[]
                else if (_selectedIndex == 2)
                  ...[]
                else ...[
                  _buildError()
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderPage() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildSearchBox(),
          _sizedBox(h: 40),
          _buildCategoryBox(),
          _sizedBox(h: 40),
          _buildFreshDeals()
        ],
      ),
    );
  }

  Widget _buildFreshDeals() {
    return SizedBox(
      height: Sizes.screenHeight * 0.3,
      width: double.infinity,
      child: Swiper(
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: PNetworkImage(
              imageList[index],
              fit: BoxFit.fill,
            ),
          );
        },
        viewportFraction: 0.8,
        scale: 0.8,
        itemCount: imageList.length,
        layout: SwiperLayout.DEFAULT,
        loop: true,
        onTap: (value) {
          //return onTap(value);
        },
        // pagination: new SwiperPagination(builder: new SwiperCustomPagination(
        //     builder: (BuildContext context, SwiperPluginConfig config) {
        //   return new ConstrainedBox(
        //     child: Align(
        //       alignment: Alignment.bottomCenter,
        //       child: new DotSwiperPaginationBuilder(
        //               color: Colors.white,
        //               activeColor: Colors.red.shade600,
        //               size: 10.0,
        //               activeSize: 15.0)
        //           .build(context, config),
        //     ),
        //     constraints: new BoxConstraints.expand(height: 50.0),
        //   );
        // })),
      ),
    );
  }

  Widget _buildCategoryBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 180,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: categoryImg.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(12),
                height: 180,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                padding: const EdgeInsets.all(12),
                child: Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(categoryImg[index]),
                              fit: BoxFit.cover),
                        ),
                        alignment: Alignment.bottomCenter,
                      ),
                      _sizedBox(h: 20),
                      Text(
                        categoryTitle[index],
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
                children: [
              TextSpan(
                  text: ' meat ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              TextSpan(text: 'for the everyday'),
            ])),
        _sizedBox(h: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          height: 60,
          child: Row(
            children: [
              Flexible(
                  child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "search",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                    hintStyle: TextStyle(fontSize: 18)),
              )),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: _sizedBox(
                  w: 55,
                  h: 55,
                  child: RaisedButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 26,
                      ),
                      onPressed: () {}),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget drawerTile({String label, Function onTap}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 48),
      child: ListTile(
        title: Text(
          label,
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.start,
        ),
        onTap: onTap,
        trailing: Icon(Icons.arrow_forward_ios, size: 18),
      ),
    );
  }
}

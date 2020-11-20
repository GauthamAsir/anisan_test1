import 'package:anisan/constants/MyColors.dart';
import 'package:anisan/constants/sizeConfig.dart';
import 'package:anisan/state/auth/auth.dart';
import 'package:anisan/views/screens/splash/SplashScreen.dart';
import 'package:anisan/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<NavigatorState> _globalKey = GlobalKey();

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.black87, // Color for Android
        statusBarBrightness:
            Brightness.dark // Dark == white status bar -- for IOS.
        ));

    Sizes().init(context);
    return WillPopScope(
      key: _globalKey,
      onWillPop: () async {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: MyColors.primaryColor, // Color for Android
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness:
                Brightness.light // Dark == white status bar -- for IOS.
            ));

        Navigator.pop(context);
        return Future<bool>.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.black87,
          brightness: Brightness.dark,
          title: Text('My Account'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  child: Container(
                    margin: EdgeInsets.all(6),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.edit),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  height: Sizes.screenHeight * 0.2,
                  width: Sizes.screenHeight * 0.2,
                  child: CircleAvatar(
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: Sizes.screenHeight * 0.2,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'User Name',
                style: TextStyle(fontSize: 21),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'User Phone Number',
                style: TextStyle(fontSize: 21),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                alignment: Alignment.center,
                height: Sizes.screenHeight * 0.16,
                width: Sizes.screenWidth * 0.16,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2),
                    shape: BoxShape.circle),
                child: Text(
                  'Total Orders',
                  textAlign: TextAlign.center,
                ),
              ),
              Text('Orders'),
              SizedBox(
                height: 50,
              ),
              Text('Wallet Balance'),
              SizedBox(
                height: 30,
              ),
              Button(
                  buttonText: 'Log Out',
                  onPressed: () {
                    Auth.signOut();
                    Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => SplashScreen()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

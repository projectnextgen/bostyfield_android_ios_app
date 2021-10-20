import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bostyfields_app/screens/home.dart';
import 'package:bostyfields_app/screens/bookings.dart';
import 'package:bostyfields_app/screens/fieldaccess.dart';
import 'package:bostyfields_app/screens/login.dart';
import 'package:bostyfields_app/screens/myaccount.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}
class _ContactUsState extends State<ContactUs>{
  bool _isLoading = false;
  bool _android = false;
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  var _kGooglePlex;
  var _controller;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    // ignore: deprecated_member_use
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }
  void loadmap(){
    if(Platform.isAndroid){
      setState(() {
        _android = true;
      });
      Completer<GoogleMapController> _controller = Completer();
      final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(52.601486, -1.948315),
      zoom: 16.4746,
      );
    }
  }

  @override
  void initState(){
    super.initState();
    loadmap();
    _loadUserData();
  }

  String? name;

  _loadUserData() async{
    setState(() {
      _isLoading = true;
    });
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);

    if(user != null) {
      setState(() {
        name = user['firstname'];
      });

      setState(() {
        _isLoading = false;
      });

    }
  }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
              title: Text('BostyFields.co.uk',style: GoogleFonts.prompt(fontWeight: FontWeight.w500)),
            backgroundColor: Colors.green[600],
          ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.lightGreen[600],
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/logo.png'),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  child: Text('Hi, $name', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                ),
                ListTile(
                  title: Text('Bookings'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => Bookings()
                      ),
                    );// Do some stuff.
                  },
                ),
                ListTile(
                  title: Text('Field Access'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => FieldAccess()
                      ),
                    );// Do some stuff.
                  },
                ),
                ListTile(
                  title: Text('Book a Walk'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => Home()
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('My Account'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => MyAccount()
                      ),
                    );// Do some stuff.
                  },
                ),
                ListTile(
                  title: Text('Contact Us'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ContactUs()
                      ),
                    );// Do some stuff.
                  },
                ),
                ListTile(
                  title: Text('Logout'),
                  onTap: () {
                    logout();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: Container(
              child: _isLoading ? Center(child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.green[600]!))) :
              SingleChildScrollView(
                child: Column(
                children: <Widget> [
                  Card(
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 10),
                    child:
                    Center(child:Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Email: sara@bostyfields.co.uk", textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            "Phone: 07501 349292", textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            "Follow us:", textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              height: 1.2,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _selection(),
                            child: Card(
                              color: Colors.green[600],
                              margin: EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 10),
                              child:
                              Center(child:Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Facebook", textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        height: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ),
                  ),
                  _android ? SizedBox(
                    width: MediaQuery.of(context).size.width,  // or use fixed size like 200
                    height: MediaQuery.of(context).size.height,
                    child: GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ) : GestureDetector(
                    onTap: () => _mapselection(),
                    child: Card(
                      color: Colors.green[600],
                      margin: EdgeInsets.only(top: 20, left: 70, right: 70, bottom: 10),
                      child:
                      Center(child:Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Find us", textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
        );
      }
void _selection() async{
  const _url = 'https://facebook.com/bostyfields';
  await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}

void _mapselection() async{
  const _url = 'https://www.google.com/maps/place/Bosty+Fields/@52.6014763,-1.9509523,17z/data=!3m1!4b1!4m5!3m4!1s0x4870a18bdd3d7e0b:0x258fd9d6e8bf4001!8m2!3d52.6014731!4d-1.9487636';
  await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}

void logout() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('access_token');
    localStorage.remove('token_type');
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>Login()));
    }
}
final _htmlContent = """
      <div class="col-lg-12 p-0 border bookingcolumn">
      	<div class='serviceimagecontainer'>							
					  <div class="pb-4 border-bottom">
						  <h2>CONTACT US</h2>
					  </div>
				</div>
				<div class='serviceimagecontainer1'>								
            <h2>Email: sara@bostyfields.co.uk</h2>
            <h2>Phone: 07501 349292</h2>
            <h3>Follow us:</h3>
            <a href="1">
              <div class="button">
                <h3>Facebook</h3>
              </div>
            </a>
				</div>		
			</div>
    """;
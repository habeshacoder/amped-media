import 'package:ampedmedia_flutter/dashboard.dart';
import 'package:ampedmedia_flutter/provider/audiobooks.dart';
import 'package:ampedmedia_flutter/provider/auth.dart';
import 'package:ampedmedia_flutter/provider/books.dart';
import 'package:ampedmedia_flutter/provider/channelcreationprovider.dart';
import 'package:ampedmedia_flutter/provider/channels.dart';
import 'package:ampedmedia_flutter/provider/materialcreationprovider.dart';
import 'package:ampedmedia_flutter/provider/profiletypederminer.dart';
import 'package:ampedmedia_flutter/provider/publisherprofileprovider.dart';
import 'package:ampedmedia_flutter/provider/readerprofileprovider.dart';
import 'package:ampedmedia_flutter/provider/report_provider.dart';
import 'package:ampedmedia_flutter/provider/tokenhandler.dart';
import 'package:ampedmedia_flutter/provider/podcasts.dart';
import 'package:ampedmedia_flutter/view/onbordingview.dart';
import 'package:ampedmedia_flutter/view/profile/chooseprofile.dart';
import 'package:ampedmedia_flutter/view/profile/createprofile.dart';
import 'package:ampedmedia_flutter/view/signinup.dart';
import 'package:ampedmedia_flutter/view/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  print('main method......');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Onboarding Example';

  @override
  Widget build(BuildContext context) {
    // Provider.of<Auth>(context,listen: false).isAuth;
    print('my app next to main..............');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Books(),
        ),
        ChangeNotifierProvider(
          create: (context) => PublisherProfileProvder(),
        ),
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        // ignore: missing_required_param

        ChangeNotifierProvider(
          create: (context) => Audiobooks(),
        ),
        ChangeNotifierProvider(
          create: (context) => Podcasts(),
        ),
        ChangeNotifierProvider(
          create: (context) => Channels(),
        ),

        ChangeNotifierProvider(
          create: (context) => TokenHandler(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileTypeDeterminer(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChannelCreationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => materialCreationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReportProvider(),
        ),
      ],
      child: Consumer<Auth>(builder: (context, auth, child) {
        return MaterialApp(
          routes: {
            SignInOut.routeName: (context) => SignInOut(),
            ChooseProfile.routeName: (context) => ChooseProfile(),
            CreateProfile.routeName: (context) => CreateProfile(),
            DashBoard.routeName: (context) => DashBoard(),
          },
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(),
          home: FutureBuilder(
            future: auth.getIsfirstTime,
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? SplashSCreen()
                    : snapshot.data == false
                        ? DashBoard()
                        : OnbordingView(),
          ),
        );
      }),
    );
  }
}

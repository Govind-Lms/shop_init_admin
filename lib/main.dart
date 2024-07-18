import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shop_init_admin/firebase_options.dart';
import 'package:shop_init_admin/src/consts/my_theme.dart';
import 'package:shop_init_admin/src/core/state/product_info/product_info_bloc.dart';
import 'package:shop_init_admin/src/core/state/user_info/seller_info_bloc.dart';
import 'package:shop_init_admin/src/presentations/views/dashboard/components/view_banner.dart';
import 'package:shop_init_admin/src/presentations/views/bottom_navs/orderlist_screen.dart';
import 'package:shop_init_admin/src/presentations/views/dashboard/stocks_details.dart';
import 'package:shop_init_admin/src/presentations/views/dashboard/upload_page.dart';
import 'package:shop_init_admin/src/presentations/views/bottom_navs/account_screen.dart';
import 'package:shop_init_admin/src/presentations/views/bottom_navs/category_screen.dart';
import 'package:shop_init_admin/src/presentations/views/bottom_navs/dashboard_screen.dart';
import 'package:shop_init_admin/src/presentations/views/nav_screen.dart';
import 'package:shop_init_admin/src/presentations/views/product/add/add_product.dart';
import 'package:shop_init_admin/src/presentations/views/product/view/categorized_screen.dart';

import 'src/presentations/views/bottom_navs/user_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  await setup();
  runApp(const MyApp());
}

setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.requestPermission();
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xff6f4f37),
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xfffff7f1),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductInfoBloc()),
        BlocProvider(create: (context) => SellerInfoBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.light,
        darkTheme: MyTheme.dark,
        themeMode: ThemeMode.light,
        initialRoute: '/',
        routes: {
          // '/onboarding' : (context) => const OnBoardingScreen(),
          '/' : (context) => const BottomNavScreen(),
          '/dashboard': (context) => DashboardScreen(),
          '/categorized': (context) => CategorizedScreen(),
          '/category': (context) => const CategoryScreen(),
          '/stockDetails': (context) => const StocksDetailsPage(),
          '/topSelling': (context) => const TopSellingPart(),
          '/addProduct': (context) => const AddProductItem(),
          '/account': (context) => const AccountScreen(),
          '/orderLists': (context) => const OrderListScreen(),
          '/users': (context) => const UserScreen(),
          '/viewBanners' : (_)=> const ViewBannerPage(),
        },
      ),
    );
  }
}

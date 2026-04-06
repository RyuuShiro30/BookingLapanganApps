import 'package:flutter/material.dart';
import '../features/home/screens/home_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/booking/screens/booking_screen.dart';
import '../features/auth/screens/register_screen.dart';

class AppRoutes {

  static const String login = "/login";
  static const String register = "/register";
  static const String home = "/home";
  static const String booking = "/booking";

  static Map<String, WidgetBuilder> routes = {
    login: (context) => LoginScreen(),
    home: (context) => const HomeScreen(),
    booking: (context) => const BookingScreen(),
    register: (context) => const RegisterScreen(),
  };
}
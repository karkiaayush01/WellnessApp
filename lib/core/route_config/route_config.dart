import 'package:flutter/material.dart';
import 'package:wellness/core/route_config/route_name.dart';
import 'package:wellness/features/add_items/add_category.dart';
import 'package:wellness/features/add_items/add_health_tips.dart';
import 'package:wellness/features/add_items/add_quote.dart';
import 'package:wellness/features/dashboard/admin_dashboard.dart';
import 'package:wellness/features/dashboard/explore_screen.dart';
import 'package:wellness/features/auth/login_screen.dart';
import 'package:wellness/features/topic_selector/topic_selector.dart';
import 'package:wellness/product/product_screen.dart';

class RouteConfig {
  RouteConfig._();

  static Route<dynamic> generateRoute(RouteSettings settings){
    final String? screenName = settings.name;
    final dynamic arg = settings.arguments;
    switch (screenName) {
      case RouteName.dashboardScreen:
        return MaterialPageRoute(
          builder: (_) =>
              ExploreScreen(),
        );
      case RouteName.productScreen:
        return MaterialPageRoute(
            builder: (_) =>
              ProductScreen(),
        );
      case RouteName.adminDashboard:
        return MaterialPageRoute(
          builder: (_) =>
            AdminDashboard(),
        );
      case RouteName.topicSelect:
        return MaterialPageRoute(
            builder: (_) => TopicSelector()
        );
      case RouteName.addCategory:
        return MaterialPageRoute(
          builder: (_) => AddCategory()
        );
      case RouteName.addQuote:
        return MaterialPageRoute(
          builder: (_) => AddQuote()
        );
      case RouteName.addHealthTips:
        return MaterialPageRoute(
          builder: (_) => AddHealthTips()
        );
      case RouteName.defaultScreen:
      default:
          return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../ui/views/calculate/calculate_view.dart';
import '../../../ui/views/favorites/favorites_view.dart';
import '../../../ui/views/home/home_view.dart';
import '../../../ui/views/startup/startup_view.dart';

class Routes {
  static const String startupView = '/';
  static const String homeView = '/home-view';
  static const String calculateCurrencyScreen = '/calculate-currency-screen';
  static const String favoritesView = '/favorites-view';
  static const all = <String>{
    startupView,
    homeView,
    calculateCurrencyScreen,
    favoritesView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.calculateCurrencyScreen, page: CalculateCurrencyScreen),
    RouteDef(Routes.favoritesView, page: FavoritesView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    StartupView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => StartupView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    CalculateCurrencyScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => CalculateCurrencyScreen(),
        settings: data,
      );
    },
    FavoritesView: (data) {
      final args = data.getArgs<FavoritesViewArguments>(
        orElse: () => FavoritesViewArguments(),
      );
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => FavoritesView(key: args.key),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// FavoritesView arguments holder class
class FavoritesViewArguments {
  final Key key;
  FavoritesViewArguments({this.key});
}

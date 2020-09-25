import 'package:auto_route/auto_route_annotations.dart';
import 'package:kanyimax/src/ui/views/startup/startup_view.dart';
import 'package:kanyimax/src/ui/views/home/home_view.dart';
import 'package:kanyimax/src/ui/views/calculate/calculate_view.dart';
import 'package:kanyimax/src/ui/views/favorites/favorites_view.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AdaptiveRoute(page: StartupView, initial: true),
    AdaptiveRoute(page: HomeView),
    AdaptiveRoute(page: CalculateCurrencyScreen),
    AdaptiveRoute(page: FavoritesView)
  ],
)
class $Router {}

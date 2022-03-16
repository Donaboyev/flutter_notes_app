// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import '../ui/ui.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.HomeScreen(),
          transitionsBuilder: _i2.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    NoteDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<NoteDetailsRouteArgs>(
          orElse: () => const NoteDetailsRouteArgs());
      return _i2.CustomPage<dynamic>(
          routeData: routeData,
          child: _i1.NoteDetailsScreen(key: args.key, note: args.note),
          transitionsBuilder: _i2.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    SearchRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.SearchScreen(),
          transitionsBuilder: _i2.TransitionsBuilders.slideTop,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeRoute.name, path: '/'),
        _i2.RouteConfig(NoteDetailsRoute.name, path: '/details'),
        _i2.RouteConfig(SearchRoute.name, path: '/search')
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.NoteDetailsScreen]
class NoteDetailsRoute extends _i2.PageRouteInfo<NoteDetailsRouteArgs> {
  NoteDetailsRoute({_i3.Key? key, _i1.Note? note})
      : super(NoteDetailsRoute.name,
            path: '/details', args: NoteDetailsRouteArgs(key: key, note: note));

  static const String name = 'NoteDetailsRoute';
}

class NoteDetailsRouteArgs {
  const NoteDetailsRouteArgs({this.key, this.note});

  final _i3.Key? key;

  final _i1.Note? note;

  @override
  String toString() {
    return 'NoteDetailsRouteArgs{key: $key, note: $note}';
  }
}

/// generated route for
/// [_i1.SearchScreen]
class SearchRoute extends _i2.PageRouteInfo<void> {
  const SearchRoute() : super(SearchRoute.name, path: '/search');

  static const String name = 'SearchRoute';
}

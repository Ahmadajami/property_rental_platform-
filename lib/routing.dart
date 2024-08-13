
import 'package:airbnb/core/providers/secure_sharedpref/secure_sharedpref.dart';
import 'package:airbnb/features/auth/screens/login_screen.dart';
import 'package:airbnb/features/auth/screens/signup_screen.dart';
import 'package:airbnb/features/home/screens/home_screen.dart';
import 'package:airbnb/features/property/screens/all_property.dart';
import 'package:airbnb/features/settings/screens/setting_screen.dart';
import 'package:airbnb/features/user_property/screens/add_property.dart';
import 'package:airbnb/features/user_property/screens/user_property.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'features/auth/controller/auth_controller.dart';
import 'features/property/screens/property_details.dart';

final _parentKey = GlobalKey<NavigatorState>();
final _shellsKey = GlobalKey<NavigatorState>();

final   List<PersistentRouterTabConfig> tabs=[
  PersistentRouterTabConfig(
    item:  ItemConfig(
      activeColorSecondary: Colors.black,
      activeForegroundColor: Colors.white,
      icon: const Icon(Icons.home),
      title: "Home",
    ),
  ),
  PersistentRouterTabConfig(
    item: ItemConfig(
      activeColorSecondary: Colors.black,
      activeForegroundColor: Colors.white,
      icon: const Icon(Icons.search),
      title: "Search",
    ),
  ),
  PersistentRouterTabConfig(
    item: ItemConfig(
      activeColorSecondary: Colors.black,
      activeForegroundColor: Colors.white,
      icon: const Icon(Icons.villa),
      title: "My Property",
    ),
  ),
  PersistentRouterTabConfig(
    item: ItemConfig(
      activeColorSecondary: Colors.black,
      activeForegroundColor: Colors.white,
      icon: const Icon(Icons.settings),
      title: "Settings",
    ),
  ),
];

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: LoginScreen.loginRoute,
    navigatorKey: _parentKey,
    routes: [
      GoRoute(
        path: LoginScreen.loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path:SignupScreen.signUpRoute,
        builder: (context, state) => const SignupScreen(),
      ),
      StatefulShellRoute.indexedStack(

        builder: (context, state, navigationShell) =>
            PersistentTabView.router(
              gestureNavigationEnabled: true,
              tabs: tabs,
              navBarBuilder: (navBarConfig) => Style2BottomNavBar(
                navBarConfig: navBarConfig,
              ),
              navigationShell: navigationShell,

            ),
        branches: [
          // The route branch for 1st Tab
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: "/home",
                name: "home",
                builder: (context, state) =>  const HomeScreen(),
                routes: [
                  /// When you use the navigator Key that of the root navigator, this and all the sub routes will be pushed to the root navigator (-> without the navbar)
                  GoRoute(
                    parentNavigatorKey: _parentKey,
                    path: "details/:id",
                    name: "details",
                    builder: (context, state) =>  PropertyDetails(propertyID:  state.pathParameters['id']!,),
                  ),
                ],
              ),
            ],
          ),
          // The route branch for 2nd Tab
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: "/all",
                name: 'all',
                builder: (context, state) => const AllProperty(),
                routes: [
                  GoRoute(
                    path: "details/:id",
                    parentNavigatorKey: _parentKey,
                    builder: (context, state) =>  PropertyDetails(propertyID: state.pathParameters['id']!,),
                  ),
                ],
              ),
            ],
          ),
          // The route branch for 3rd Tab
          StatefulShellBranch(
            navigatorKey: _shellsKey,
            routes: <RouteBase>[
              GoRoute(
                  path: "/MyProperty",
                  builder: (context, state) => const MyProperty(),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _parentKey,
                      path: "addProp",
                      builder: (context,state)=> const AddPropertyScreen(),
                    )
                  ]
              ),
            ],
          ),
          // The route branch for 4th Tab
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: "/settings",
                builder: (context, state) => const SettingScreen(),
              ),
            ],
          ),
        ],

      )
    ],
    redirect: (context, state) {
      final isLoginPage=state.fullPath==LoginScreen.loginRoute;
      final isSignupPage= state.fullPath==SignupScreen.signUpRoute;
      final model=ref.read(authStoreProvider).model;
      if(isLoginPage)
        {
          if(ref.watch(authStreamProvider).isLoading  |ref.watch(authStreamProvider).hasError)
            {
              return model != null ?"/home":null;
            }
          return  ref.watch(authStreamProvider).whenOrNull(data: (data) =>data.model != null ? "/home":null);
        }
      if(isSignupPage)
      {
        ref.watch(authStreamProvider).whenOrNull(data: (data) =>print("benn triggerd"));
        return null;
      }
      return model == null ? "/" :null;
    },
  );
});


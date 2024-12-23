import 'package:fitness/routing/router_constants.dart';
import 'package:fitness/screen/authentication/view/auth_screen.dart';
import 'package:fitness/screen/main_screen.dart';
import 'package:fitness/screen/qr_scan/qr_scan.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouterConstants.home.path,
    routes: [
      GoRoute(
        name: RouterConstants.home.name,
        path: RouterConstants.home.path,
        pageBuilder: (context, state) => const MaterialPage(child: MainScreen()),
        routes: [
          GoRoute(
            name: RouterConstants.qrCode.name,
            path: RouterConstants.qrCode.path,
            pageBuilder: (context, state) => const MaterialPage(child: QrScannerWidget()),
          ),
        ],
      ),
      GoRoute(
        name: RouterConstants.login.name,
        path: RouterConstants.login.path,
        pageBuilder: (context, state) => const MaterialPage(child: AuthScreen()),
      ),
    ],
  );
}

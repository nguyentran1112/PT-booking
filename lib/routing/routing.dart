import 'package:fitness/routing/page_not_found.dart';
import 'package:fitness/routing/router_constants.dart';
import 'package:fitness/screen/authentication/view/auth_screen.dart';
import 'package:fitness/screen/feedback/feedback_screen.dart';
import 'package:fitness/screen/main_screen.dart';
import 'package:fitness/screen/partner/partner_detail_screen.dart';
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
        pageBuilder: (context, state) =>
            const MaterialPage(child: MainScreen()),
        routes: [
          GoRoute(
            name: RouterConstants.qrCode.name,
            path: RouterConstants.qrCode.path,
            pageBuilder: (context, state) =>
                const MaterialPage(child: QrScannerWidget()),
          ),
          GoRoute(
              path: RouterConstants.partnerDetail.path,
              name: RouterConstants.partnerDetail.name,
              builder: (context, state) {
                final id = state.pathParameters['id'] ?? '';
                if (id.isEmpty) {
                  return const PageNotFound();
                }
                return PartnerDetailScreen(id: id);
              },
              routes: [
                GoRoute(
                  path: RouterConstants.feedback.path,
                  name: RouterConstants.feedback.name,
                  builder: (context, state) {
                    final id = state.pathParameters['id'] ?? '';
                    if (id.isEmpty) {
                      return const PageNotFound();
                    }
                    return FeedbackScreen(userId: id);
                  },
                ),
              ]
          ),
        ],
      ),
      GoRoute(
        name: RouterConstants.login.name,
        path: RouterConstants.login.path,
        builder: (context, state) => const AuthScreen(),
      ),
    ],

    errorPageBuilder: (context, state) {
      return const MaterialPage(child: PageNotFound());
    },
  );
}

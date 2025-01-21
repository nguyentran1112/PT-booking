import 'package:fitness/routing/page_not_found.dart';
import 'package:fitness/routing/router_constants.dart';
import 'package:fitness/screen/authentication/view/auth_screen.dart';
import 'package:fitness/screen/feedback/feedback_screen.dart';
import 'package:fitness/screen/main_screen.dart';
import 'package:fitness/screen/partner/partner_detail_screen.dart';
import 'package:fitness/screen/partner/update_pt_profile/update_pt_profile.dart';
import 'package:fitness/screen/profile/profile_detail/profile_detail_page.dart';
import 'package:fitness/screen/profile/profile_edit/profile_edit_page.dart';
import 'package:fitness/screen/profile/profile_page.dart';
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
                GoRoute(
                  path: RouterConstants.profilePTEdit.path,
                  name: RouterConstants.profilePTEdit.name,
                  builder: (context, state) {
                    final id = state.pathParameters['id'] ?? '';
                    if (id.isEmpty) {
                      return const PageNotFound();
                    }
                    return UpdatePtProfile(userId: id);
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
      GoRoute(
        name: RouterConstants.profile.name,
        path: RouterConstants.profile.path,
        pageBuilder: (context, state) => const MaterialPage(child: ProfilePage()),
      ),
      GoRoute(
        name: RouterConstants.profileDetail.name,
        path: RouterConstants.profileDetail.path,
        pageBuilder: (context, state) => const MaterialPage(child: ProfileDetailPage()),
      ),
      GoRoute(
        name: RouterConstants.profileEdit.name,
        path: RouterConstants.profileEdit.path,
        pageBuilder: (context, state) => const MaterialPage(child: ProfileEditPage()),
      ),
    ],

    errorPageBuilder: (context, state) {
      return const MaterialPage(child: PageNotFound());
    },
  );
}

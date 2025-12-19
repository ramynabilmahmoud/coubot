// import 'package:auto_route/auto_route.dart';
// import 'package:coubot/config/routes/app_router.gr.dart';
// import 'package:coubot/main.dart';

// /// Check if first name and second name of user exists
// class CheckUserDetailsGuard extends AutoRouteGuard {
//   @override
//   void onNavigation(NavigationResolver resolver, StackRouter router) {
//     final user = supabaseClient.auth.currentUser;
//     router.push(AuthWrapper());
//     if (supabaseClient.auth.currentUser != null) {
//       if (user!.userMetadata != null) {
//         // router.push(
//         //   AddAdditionalDetailsRoute(
//         //     checkForEmptyFieldsAndRoute: const {
//         //       AppStrings.firstAndSecondNameEmpty: true,
//         //       'route': AppPaths.appLayoutWrapper,
//         //     },
//         //   ),
//         // );
//       }
//     } else {
//       resolver.next();
//     }
//   }
// }

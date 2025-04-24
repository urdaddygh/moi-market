// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class CustomNavigatorBar extends StatelessWidget {
//   const CustomNavigatorBar({
//     required this.currentPageIndex,
//     required this.onItemTapped,
//     super.key,
//   });
//
//   final int currentPageIndex;
//   final Function(int) onItemTapped;
//
//   @override
//   Widget build(BuildContext context) {
//     return FloatingNavbar(
//       fontSize: MediaQuery.of(context).size.width <= 360 ? 11 : 12,
//       backgroundColor: Theme.of(context).own().bottomNavigatorBarColor,
//       borderRadius: 15,
//       selectedBackgroundColor: Colors.transparent,
//       selectedItemColor: Theme.of(context).own().navBarActiveColor,
//       unselectedItemColor: Style.navigatorBarInactiveColor,
//       margin: const EdgeInsets.symmetric(horizontal: Style.defaultSpacing),
//       padding: const EdgeInsets.symmetric(vertical: 14),
//       currentIndex: currentPageIndex,
//       items: [
//         FloatingNavbarItem(
//           icon: const SvgIcon(path: 'assets/svgs/home_main.svg', color: Style.greyColor),
//           title: AppLocalizations.of(context)!.main,
//           customWidget: currentPageIndex == 0
//               ? Lottie.asset(
//                   'assets/lootie/home.json',
//                   repeat: false,
//                 )
//               : null,
//         ),
//         FloatingNavbarItem(
//             icon: const SvgIcon(path: 'assets/svgs/transport.svg', color: Style.greyColor),
//             title: AppLocalizations.of(context)!.routes,
//             customWidget: currentPageIndex == 1
//                 ? Lottie.asset(
//                     'assets/lootie/transport.json',
//                     repeat: false,
//                   )
//                 : null,
//             // cornerSubtitle: Positioned(
//             //   top: -7.5,
//             //   left: 5,
//             //   child: Text(
//             //     'Beta',
//             //     overflow: TextOverflow.ellipsis,
//             //     textAlign: TextAlign.center,
//             //     style: TextStyle(
//             //       color: currentPageIndex == 1 ? Theme.of(context).own().redColor : Style.navigatorBarInactiveColor,
//             //       fontSize: 10,
//             //       fontWeight: FontWeight.w600,
//             //     ),
//             //   ),
//             // ) //AppLocalizations.of(context)!.beta,
//             ),
//         FloatingNavbarItem(
//           icon: const SvgIcon(path: 'assets/svgs/services.svg', color: Style.greyColor),
//           title: AppLocalizations.of(context)!.services,
//           customWidget: currentPageIndex == 2
//               ? Lottie.asset(
//                   'assets/lootie/services.json',
//                   repeat: false,
//                 )
//               : null,
//         ),
//         FloatingNavbarItem(
//           icon: const SvgIcon(path: 'assets/svgs/profile.svg', color: Style.greyColor),
//           title: AppLocalizations.of(context)!.profile,
//           customWidget: currentPageIndex == 3
//               ? Lottie.asset(
//                   'assets/lootie/profile.json',
//                   repeat: false,
//                 )
//               : null,
//           cornerSubtitle: Consumer<MyAppealsModel>(
//             builder: (context, value, child) {
//               if (value.hasUnreadAppeals) {
//                 return Positioned(
//                   top: -2.5,
//                   left: 10,
//                   child: CircleAvatar(
//                     backgroundColor: Theme.of(context).own().redColor,
//                     radius: 4,
//                   ),
//                 );
//               }
//               return const SizedBox();
//             },
//           ),
//         ),
//       ],
//       onTap: onItemTapped,
//     );
//   }
// }

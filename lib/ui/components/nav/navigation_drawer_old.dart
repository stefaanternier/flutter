import 'package:flutter/material.dart';


//todo delete
class ARLearnNavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
//     return StoreConnector<AppState, NavigationViewModel>(
//       converter: NavigationViewModel.fromStore,
//       builder: (context, vm) {
//         List<Widget> top = [
//           UserAccountsDrawerHeader(
//             accountEmail: Text("${vm.email == null ? "" : vm.email}"),
//             accountName: Text("${vm.name}"),
//             currentAccountPicture: (vm.email == null || vm.email == '')
//                 ? null
//                 : CircleAvatar(
//                     backgroundColor: Theme.of(context).cardColor,
//                     backgroundImage: NetworkImage(vm.accountPicture)),
//           )
//         ];
//         List<Widget> currentGame = [];
//         if (vm.showCurrentGame()) {
//           currentGame = [
//             ListTile(
//               leading: Icon(Icons.gamepad),
//               title: Text('${vm.currentGameTitle}'),
//               onTap: () {
//                 vm.onPageClicked(PageType.game);
//                 Navigator.pop(context);
//               },
//             ),
//             Divider(),
//           ];
//         }
//         List<Widget> restOfDrawer = [
//           Visibility(
//             visible: !vm.anon,
//             child: ListTile(
//               leading: Icon(Icons.person),
//               title: Text(AppLocalizations.of(context).translate('games.myGames')),
//               onTap: () {
//                 vm.onPageClicked(PageType.myGames);
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.list),
//             title: Text(AppLocalizations.of(context).translate('library.library')),
//             onTap: () {
//               vm.onPageClicked(PageType.featured);
//               // Navigator.pop(context);
//
//
//             },
//           ),
//           Visibility(
//             visible: !UniversalPlatform.isWeb,
//             child: ListTile(
//               leading: Icon(FontAwesomeIcons.qrcode),
//               title: Text(AppLocalizations.of(context).translate('scan.scan')),
//               onTap: () {
//                 vm.onPageClicked(PageType.scanGame);
//                 Navigator.pop(context);
//               },
//             ),
//           ),
// //          ListTile(
// //            leading: Icon(FontAwesomeIcons.userFriends),
// //            title: Text('Friends'),
// //            onTap: () {
// //              Navigator.pop(context);
// //            },
// //          ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.exit_to_app),
//             title: vm.isAuthenticated
//                 ? (vm.anon ? Text(AppLocalizations.of(context).translate('login.anonlogout')) : Text(AppLocalizations.of(context).translate('login.logout')))
//                 : Text(AppLocalizations.of(context).translate('login.login')),
//             onTap: () {
//               Navigator.pop(context);
//               if (vm.isAuthenticated) {
//                 if (vm.anon) {
//                   print('erase on server');
//                   vm.onAnonErase();
//                   // vm.onLogoutClicked();
//                 } else {
//                   vm.onLogoutClicked();
//                 }
//
//               } else {
//                 vm.onPageClicked(PageType.login);
//               }
//             },
//           ),
//
// //          Divider(),
// //          ListTile(
// //            leading: Icon(Icons.report_problem),
// //            title: Text('outgoing'),
// //            onTap: () {
// //              vm.onPageClicked(PageType.dev1);
// //              Navigator.pop(context);
// //            },
// //          ),
//         ];
//         return Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [top, currentGame, restOfDrawer].expand((x) => x).toList(),
//           ),
//         );
//       },
//     );
  }
}

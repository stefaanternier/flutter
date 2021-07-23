import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/actions/actions.dart';
import 'package:youplay/actions/games.dart';
import 'package:youplay/actions/ui.dart';
import 'package:youplay/selectors/selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/state/authentication_state.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/selectors/authentication_selectors.dart';
import 'package:youplay/store/selectors/ui_selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';

import '../../../localizations.dart';
import '../../../screens/util/navigation_drawer.viewmodel.dart';


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

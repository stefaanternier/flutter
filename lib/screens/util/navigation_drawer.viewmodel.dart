
//todo delete
//
// class NavigationViewModel {
//   String name;
//   String email;
//
//   String accountPicture;
//   bool isAuthenticated;
//   bool anon;
//
// //  bool showCurrentGame;
//   String currentGameTitle;
//   String currentRunTitle;
//   final Function(PageType) onPageClicked;
//   final Function() onLogoutClicked;
//   final Function() onAnonErase;
//
//
//   NavigationViewModel({
//         required this.name,
//         required this.email,
//         required this.accountPicture,
//         required this.isAuthenticated,
//         required this.anon,
//         required this.currentGameTitle,
//         required this.currentRunTitle,
//         required this.onPageClicked,
//         required this.onLogoutClicked,
//         required this.onAnonErase
//       });
//
//   bool showCurrentGame() {
//     return this.currentGameTitle != "" && currentRunTitle != "";
//   }
//
//   static NavigationViewModel fromStore(Store<AppState> store) {
//     AuthenticationState authenticationState = authenticationInfo(store.state);
//     return NavigationViewModel(
//         name: authenticationState.name == null ? "" : authenticationState.name,
//         email: authenticationState.email == null ? "" : authenticationState.email,
//         accountPicture: authenticationState.pictureUrl,
//         isAuthenticated: authenticationState.authenticated,
//         anon: authenticationState.anon,
//         currentGameTitle: currentGameTitleSelector(store.state.currentGameState),
//         currentRunTitle: currentRunSelector(store.state.currentRunState)?.title ?? "",
//         onPageClicked: (PageType page) {
//           store.dispatch(new SetPage(page: page));
//
//         },
//         onAnonErase: () {
//           store.dispatch(new EraseAnonAccount());
//         },
//         onLogoutClicked: () {
//           store.dispatch(new SignOutAction());
//         }
//         );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/ui/components/buttons/cust_raised_button.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';

import '../../localizations.dart';

enum CreateStatus { email, password, displayName }

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  CreateStatus status = CreateStatus.email;
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController pwController = TextEditingController(text: '');
  TextEditingController displayNameController = TextEditingController(text: '');
  String email = '';
  String password = '';
  String displayName = '';
  String feedback = '';
  RegExp regExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          toolbarHeight: 250,
          title: Text("Maak account"),
        ),
        drawer: ARLearnNavigationDrawerContainer(),
        body: switchState(context));
  }

  Widget switchState(BuildContext context) {
    if (status == CreateStatus.password) {
      return collectPassword(context);
    }
    if (status == CreateStatus.displayName) {
      return collectName(context);
    }
    return collectEmail(context);
  }

  Widget collectEmail(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            // Use email input type for emails.
            decoration: new InputDecoration(
                hintText: 'you@example.com',
                labelText: AppLocalizations.of(context)
                    .translate('makeaccount.emailAddress')),
            onTap: () {
              //widget.onPressed(true);
            },
            onEditingComplete: () {
              //widget.onPressed(false);
              FocusScope.of(context).unfocus();
            },
            onChanged: (String text) {
              setState(() {
                email = text;
                if (regExp.hasMatch(text)) {
                  feedback = 'ok';
                } else {
                  feedback = 'formaat is fout';
                }
              });
              //widget.changeEmail(text);
            },
          ),
          CustomRaisedButton(
              disabled: !regExp.hasMatch(email),
              onPressed: () {
                setState(() {
                  status = CreateStatus.password;
                });
              },
              title: AppLocalizations.of(context).translate('makeaccount.next'))
        ],
      ),
    );
  }

  Widget collectPassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new TextFormField(
            controller: pwController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: _obscureText,
            validator: (val) =>
                (val?.length ?? 0) < 6 ? 'Password too short.' : null,

            // Use email input type for emails.
            decoration: new InputDecoration(
                labelText: AppLocalizations.of(context)
                    .translate('makeaccount.password'),
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: _toggle,
                )),
            onTap: () {
              //widget.onPressed(true);
            },
            onEditingComplete: () {
              //widget.onPressed(false);
              FocusScope.of(context).unfocus();
            },
            onChanged: (String text) {
              setState(() {
                password = text;
              });
              //widget.changeEmail(text);
            },
          ),
          CustomRaisedButton(
              disabled: password.length < 6,
              onPressed: () {
                setState(() {
                  status = CreateStatus.displayName;
                });
              },
              title: AppLocalizations.of(context).translate('makeaccount.next'))
        ],
      ),
    );
  }

  Widget collectName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new TextFormField(
            controller: displayNameController,
            keyboardType: TextInputType.text,
            // Use email input type for emails.
            decoration: new InputDecoration(
                labelText: AppLocalizations.of(context)
                    .translate('makeaccount.whatsyourname')),
            onTap: () {
              //widget.onPressed(true);
            },
            onEditingComplete: () {
              //widget.onPressed(false);
              FocusScope.of(context).unfocus();
            },
            onChanged: (String text) {
              setState(() {
                displayName = text;
              });
              //widget.changeEmail(text);
            },
          ),
          new StoreConnector<AppState, Store<AppState>>(
              converter: (store) => store,
              builder: (context, store) {
                return CustomRaisedButton(
                    disabled: displayName.length < 3,
                    onPressed: () {
                      store.dispatch(new CreateAccount(
                          email: email,
                          password: password,
                          displayName: displayName));
                    },
                    title: AppLocalizations.of(context)
                        .translate('makeaccount.makeaccount'));
              })
        ],
      ),
    );
  }
}

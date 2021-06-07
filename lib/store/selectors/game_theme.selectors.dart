import 'dart:collection';

import 'package:reselect/reselect.dart';
import 'package:youplay/store/state/app_state.dart';

final allThemesSelector = (AppState state) => state.themIdToTheme;

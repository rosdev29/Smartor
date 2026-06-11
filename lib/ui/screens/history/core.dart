

import 'package:calc_pro/core/constants/constants.dart';
import 'package:calc_pro/core/di/injector.dart';
import 'package:calc_pro/core/extensions/context_extension.dart';
import 'package:calc_pro/core/strings/generated/l10n.dart';
import 'package:calc_pro/data/models/history.dart';
import 'package:calc_pro/logic/blocs/history/history_bloc.dart';
import 'package:calc_pro/logic/cubits/premium/premium_cubit.dart';
import 'package:calc_pro/ui/widgets/notification_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ads_plugin/flutter_ads_plugin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'src/history_screen.dart';
part 'src/loading.dart';
part 'src/list_history.dart';
part 'src/delete_button.dart';
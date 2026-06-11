part of '../core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.input = ''});

  final String input;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = getIt<HomeBloc>();

  @override
  void initState() {
    _bloc.add(InitialEvent(input: widget.input));
    super.initState();
    AdvancedInAppReview()
        .setMinDaysBeforeRemind(7)
        .setMinDaysAfterInstall(2)
        .setMinLaunchTimes(2)
        .setMinSecondsBeforeShowDialog(4)
        .monitor();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ThemeCubit>().state;
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            leading: _HistoryButton(bloc: _bloc),
            title: Shimmer.fromColors(
              baseColor: Color(0xFFFFD700),
              highlightColor: Colors.white,
              child: GradientText(
                S.current.app_name,
                colors: [
                  Color(0xFFFFD700),
                  Color(0xFFFFC107),
                  Color(0xFFFFF8E1),
                  Color(0xFFFFA000),
                ],
              ),
            ),
            actions: [
              _ToolsButton(bloc: _bloc),
              PremiumWidget(),
              SizedBox(width: 8.w)
            ],
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: _CalculationMonitoring(bloc: _bloc)),
              Divider(),
              _Keyboard(bloc: _bloc),
            ],
          ),
        ));
  }
}

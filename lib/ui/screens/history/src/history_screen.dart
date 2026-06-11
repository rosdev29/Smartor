part of '../core.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _bloc = getIt<HistoryBloc>();

  @override
  void initState() {
    _bloc.add(InitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isShowAd = context.watch<PremiumCubit>().state.isShowAd;
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text(S.current.history),
            actions: [
              _DeleteButton(bloc: _bloc),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    _ListHistory(bloc: _bloc),
                    _Loading(bloc: _bloc),
                  ],
                ),
              ),
              if (isShowAd)
                const FlutterAdsBanner(androidId: Constants.bannerAndroidId),
            ],
          ),
        ));
  }
}

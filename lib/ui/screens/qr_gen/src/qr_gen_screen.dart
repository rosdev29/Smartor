part of '../core.dart';

class QrGenScreen extends StatefulWidget {
  const QrGenScreen({super.key});

  @override
  State<QrGenScreen> createState() => _QrGenScreenState();
}

class _QrGenScreenState extends State<QrGenScreen> {
  final _bloc = getIt<QrGenBloc>();
  final _controller = TextEditingController();

  @override
  void initState() {
    _bloc.add(InitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text(S.current.qr_gen),
            actions: [
              _About(),
              SizedBox(width: 8.w),
            ],
          ),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: S.current.text,
                            style: context.textTheme.bodyMedium),
                        TextSpan(
                            text: ' *',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: Colors.red,
                            )),
                      ])),
                    ),
                    SizedBox(height: 8.h),
                    _Input(controller: _controller, bloc: _bloc),
                    SizedBox(height: 12.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: S.current.version,
                            style: context.textTheme.bodyMedium),
                        TextSpan(
                            text: ' *',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: Colors.red,
                            )),
                      ])),
                    ),
                    _Version(bloc: _bloc),
                    SizedBox(height: 32.h),
                    _QrView(bloc: _bloc),
                  ],
                ),
              ),
              _Loading(bloc: _bloc),
            ],
          ),
        ));
  }
}

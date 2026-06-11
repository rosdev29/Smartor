part of '../core.dart';

class _QrView extends StatelessWidget {
  const _QrView({required this.bloc});

  final QrGenBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QrGenBloc, QrGenState>(
        bloc: bloc,
        buildWhen: (previous, current) => current is ResultState,
        builder: (context, state) {
          if (state is ResultState && state.text.isNotEmpty) {
            final qrKey = GlobalKey();
            return Column(
              children: [
                RepaintBoundary(
                  key: qrKey,
                  child: QrImageView(
                    data: state.text,
                    version: state.version,
                    size: context.width * 0.6,
                    backgroundColor: Colors.white,
                    eyeStyle: QrEyeStyle(
                      color: Colors.black,
                      eyeShape: QrEyeShape.square,
                    ),
                    dataModuleStyle: QrDataModuleStyle(
                        color: Colors.black,
                        dataModuleShape: QrDataModuleShape.square),
                  ),
                ),
                SizedBox(height: 32.h),
                GradientElevatedButton(
                  onPressed: () => bloc.add(GenerateQrEvent(qrKey: qrKey)),
                  style: GradientElevatedButton.styleFrom(
                      backgroundGradient: const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                        Color(0xFFFFF300),
                        Color(0xFFFFD202),
                        Color(0xFFFE8A02),
                      ])),
                  child: Text(
                    S.current.generate,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          }
          return SizedBox.shrink();
        });
  }
}

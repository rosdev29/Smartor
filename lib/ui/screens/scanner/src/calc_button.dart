part of '../core.dart';

class _CalcButton extends StatelessWidget {
  const _CalcButton({required this.bloc});

  final ScannerBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerBloc, ScannerState>(
        bloc: bloc,
        buildWhen: (previous, current) => current is ListRectSelectedState,
        builder: (context, state) {
          if (state is ListRectSelectedState && state.listRect.isNotEmpty) {
            return InkWell(
              onTapDown: (_) => bloc.add(ShowCalculatorEvent()),
              borderRadius: BorderRadius.circular(6.r),
              child: Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.cover,
                    )),
              ),
            );
          }
          return const SizedBox.shrink();
        });
  }
}

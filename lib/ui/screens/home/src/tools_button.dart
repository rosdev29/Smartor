part of '../core.dart';

class _ToolsButton extends StatefulWidget {
  const _ToolsButton({required this.bloc});

  final HomeBloc bloc;

  @override
  State<_ToolsButton> createState() => _ToolsButtonState();
}

class _ToolsButtonState extends State<_ToolsButton> {
  final _controller = SuperTooltipController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      _ToolItem(
          onTap: () {
            _controller.hideTooltip();
            widget.bloc.add(NavigateEvent(
                routeName: AppRouter.cameraScreen,
                arguments: AppRouter.translateScreen));
          },
          asset: 'translate',
          title: S.current.translate),
      _ToolItem(
          onTap: () {
            _controller.hideTooltip();
            widget.bloc.add(NavigateEvent(routeName: AppRouter.qrCodeScreen));
          },
          asset: 'qr-scan',
          title: S.current.qr_scanner),
      _ToolItem(
          onTap: () {
            _controller.hideTooltip();
            widget.bloc.add(NavigateEvent(routeName: AppRouter.viewPdfScreen));
          },
          asset: 'pdf',
          title: S.current.view_pdf),
      _ToolItem(
          onTap: () {
            _controller.hideTooltip();
            widget.bloc.add(NavigateEvent(routeName: AppRouter.qrGenScreen));
          },
          asset: 'generate_qr',
          title: S.current.qr_gen),
      _ToolItem(
          onTap: () {
            _controller.hideTooltip();
            widget.bloc.add(NavigateEvent(routeName: AppRouter.barcodeScreen));
          },
          asset: 'barcode',
          title: S.current.barcode),
      _ToolItem(
          onTap: () {
            _controller.hideTooltip();
            widget.bloc.add(NavigateEvent(routeName: AppRouter.viewDocxScreen));
          },
          asset: 'docx',
          title: S.current.view_docx),
    ];

    return AnimButton(
        onTap: () {
          _controller.showTooltip();
        },
        child: SuperTooltip(
            controller: _controller,
            elevation: 10,
            backgroundColor: Colors.white10,
            hasShadow: false,
            borderRadius: 4.w,
            arrowTipDistance: 20.w,
            arrowLength: 24.w,
            content: GridView(
              padding: EdgeInsets.all(8.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20.w,
                crossAxisSpacing: 20.w,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: children,
            ),
            child: Image.asset(
              'assets/images/tools.png',
              width: 24.w,
              height: 24.w,
            )));
  }
}

class _ToolItem extends StatelessWidget {
  const _ToolItem(
      {required this.onTap, required this.asset, required this.title});

  final VoidCallback onTap;
  final String asset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AnimButton(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/$asset.png',
                  width: 44.w,
                  height: 44.w,
                ),
              )),
        ),
        SizedBox(height: 8.h),
        Text(title,
            style: context.textTheme.labelSmall?.copyWith(
              fontSize: 10.sp,
            )),
      ],
    );
  }
}

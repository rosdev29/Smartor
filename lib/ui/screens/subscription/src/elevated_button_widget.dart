part of '../core.dart';

class _ElevatedButtonWidget extends StatelessWidget {
  const _ElevatedButtonWidget({required this.onPressed, required this.title});

  final void Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    final titleMedium = context.textTheme.titleSmall;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue),
          onPressed: onPressed,
          child: Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            style: titleMedium!.copyWith(
                color: Colors.white, height: 1, fontWeight: FontWeight.w500),
          )),
    );
  }
}

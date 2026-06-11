part of '../core.dart';

class _PurchaseListTitleWidget extends StatelessWidget {
  const _PurchaseListTitleWidget(
      {required this.title,
      required this.content,
      required this.image});

  final String title;
  final String content;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const StadiumBorder(side: BorderSide.none),
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: context.textTheme.bodyMedium),
      subtitle: Text(
        content,
        style: context.textTheme.labelSmall,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Image.asset(
        image,
        width: 40.sp,
        height: 40.sp,
      ),
    );
  }
}

import 'package:isar/isar.dart';

part 'history.g.dart';

@collection
class History {
  Id id = DateTime.now().millisecondsSinceEpoch;
  String value;
  History(this.value);
}

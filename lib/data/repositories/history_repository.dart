import 'package:calc_pro/data/models/history.dart';
import 'package:isar/isar.dart';

abstract interface class HistoryRepository {
  Future<int> insert({required History history});

  Future<List<History>> getList({required int offset});

  Future<bool> delete({required int id});

  Future<void> deleteAll();
}

class HistoryRepositoryImpl implements HistoryRepository {
  final Isar _isar;

  const HistoryRepositoryImpl({required Isar isar}) : _isar = isar;

  @override
  Future<bool> delete({required int id}) =>
      _isar.writeTxn(() => _isar.historys.delete(id));

  @override
  Future<void> deleteAll() => _isar.writeTxn(() => _isar.historys.clear());

  @override
  Future<List<History>> getList({required int offset}) =>
      _isar.txn(() => _isar.historys.where(sort: Sort.desc).anyId().offset(offset).findAll());

  @override
  Future<int> insert({required History history}) =>
      _isar.writeTxn(() => _isar.historys.put(history));
}

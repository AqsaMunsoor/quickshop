part of '../configs.dart';

final _dateTimeWords = DateFormat('MMM. dd, yyyy HH:mmaaa');

extension SuperDate on DateTime {
  String get dateTimeWords => _dateTimeWords.format(toLocal());
}

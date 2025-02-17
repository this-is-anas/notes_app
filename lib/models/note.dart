import 'package:isar/isar.dart';

// this line is needed to genereate the file
part 'note.g.dart';
// then run: dart run build_runner build

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}
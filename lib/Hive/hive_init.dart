import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:time_table/models/event.dart';

Future initHive() async {
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  if (!Hive.isAdapterRegistered(TimeOfDayAdapter().typeId)) {
    Hive.registerAdapter(TimeOfDayAdapter());
  }
  if (!Hive.isAdapterRegistered(EventAdapter().typeId)) {
    Hive.registerAdapter(EventAdapter());
  }
}

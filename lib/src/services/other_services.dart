import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class OtherServices {
  static final dev = Logger();
  static Future<void> cekAndDelete() async {
    final appStorage = await getTemporaryDirectory();
    // // if (appStorage.existsSync()) {
    final fileList = appStorage.listSync();
    dev.i("${fileList}ini file list");
    if (fileList.isNotEmpty) {
      dev.i("ada file");
      // print(fileList);
      for (var i = 0; i < fileList.length; i++) {
        final file = fileList[i];
        dev.i(file.path);
        if (file.toString().contains(".jpg") ||
            file.toString().contains(".png") ||
            file.toString().contains(".jpeg") ||
            file.toString().contains(".JPG") ||
            file.toString().contains(".PNG") ||
            file.toString().contains(".JPEG")) {
          dev.i("delete");
          await file.delete(recursive: true);
        }
      }
    } else {
      dev.i("tidak ada file");
      // print(fileList);
    }
  }
}

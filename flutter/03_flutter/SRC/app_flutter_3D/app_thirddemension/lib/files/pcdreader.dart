import 'package:app_thirddemension/files/filesystem.dart';
import 'package:ditredi/ditredi.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class PCDReader {
  late String path;

  final String _dumPath =
      '/Users/twchong/workspace/myGithub/basic_study/flutter/03_flutter/SRC/app_flutter_3D/app_thirddemension/pcd';
  FileSystem mFiles = FileSystem();

  PCDReader({
    required this.path,
  });

  Future<List<String>> _readFromFile() async {
    setBasePath();

    mFiles.setLocalPath(path);
    mFiles.setFileName('pointcloud_log.pcd');

    Stream<String> fileLines = mFiles.readSync();

    return fileLines.toList();
  }

  Future<List<Point3D>> read(String filename) async {
    List<Point3D> pc = [];
    final strs = await _readFromFile();

    if (strs.isNotEmpty) {
      print(strs.length);
      for (var x = 0; x < 10; x++) {
        for (var y = 0; y < 10; y++) {
          for (var z = 0; z < 10; z++) {
            pc.add(Point3D(vector.Vector3(
              x.toDouble(),
              y.toDouble(),
              z.toDouble(),
            )));
          }
        }
      }
    }

    return pc;
  }

  void setBasePath() {
    if (path.isEmpty) {
      path = _dumPath;
    }
  }
}

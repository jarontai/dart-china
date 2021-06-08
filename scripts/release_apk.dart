import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:yaml/yaml.dart';
import 'package:path/path.dart' as path;

const appName = 'dart_china';
const version = 'version';
const apkPath = 'build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk';

main(List<String> args) async {
  final parser = ArgParser()
    ..addOption(version, abbr: 'v', help: 'version num', valueHelp: 'VERSION');
  final argResults = parser.parse(args);

  final dir = Directory(path.join(Directory.current.path, appName));
  final pubspec = File(path.join(dir.path, 'pubspec.yaml'));
  print(dir.path);
  print(pubspec.path);

  if (dir.existsSync() && pubspec.existsSync()) {
    final yaml = pubspec.readAsStringSync();
    final doc = loadYaml(yaml);
    final version = doc['version'];
    if (version != null) {
      final apkFile = File(path.join(dir.path, apkPath));
      if (apkFile.existsSync()) {
        apkFile.deleteSync();
      }

      final process = await Process.start(
        'flutter',
        ['build', 'apk', '--target=lib/main_prod.dart', '--split-per-abi'],
        workingDirectory: dir.path,
      );
      process.stdout.listen((event) {
        print(utf8.decode(event));
      }, onDone: () async {
        final apkFile = File(path.join(dir.path, apkPath));
        if (apkFile.existsSync()) {
          final finalApk =
              apkFile.path.replaceAll('app-', '$appName-$version-');
          apkFile.copySync(finalApk);
          print('Finish build: $finalApk');
        }
      });
      process.stderr.listen((event) {
        print(utf8.decode(event));
      });
    } else {
      print('Pubspec file invalid');
    }
  }
}

import 'package:dbus/dbus.dart';
import 'package:file_picker/src/file_picker.dart';

import 'package:file_picker/src/file_picker_result.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:file_picker/src/utils.dart';
import 'package:file_picker/src/flatpak/dbus/file_chooser_dbus.dart';
import 'package:file_picker/src/flatpak/dbus/response_dbus.dart';
import 'package:file_picker/src/flatpak/filters.dart';

late final dbusClient = DBusClient.session();

class FilePickerFlatpak extends FilePicker {
  @override
  Future<FilePickerResult?> pickFiles({
    String? dialogTitle,
    String? initialDirectory,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    Function(FilePickerStatus)? onFileLoading,
    bool allowCompression = true,
    bool allowMultiple = false,
    bool withData = false,
    bool withReadStream = false,
    bool lockParentWindow = false,
  }) async {
    final handle = await OrgFreedesktopPortalFileChooser(dbusClient, "org.freedesktop.portal.Desktop", path: DBusObjectPath("/org/freedesktop/portal/desktop"))
        .callOpenFile(
      "",
      dialogTitle ?? "Open File",
      {
        "multiple": DBusBoolean(allowMultiple),
        "modal": DBusBoolean(lockParentWindow),
        "filters": filters(type, allowedExtensions),
      },
    );
    final response = await OrgFreedesktopPortalRequest(dbusClient, "org.freedesktop.portal.Desktop", path: DBusObjectPath(handle)).response.first;
    if (response.response != 0) return null;
    final List<String> filePaths = (response.results["uris"] as DBusArray).mapString().map((e) => Uri.parse(e).toFilePath()).toList();

    final List<PlatformFile> platformFiles = await filePathsToPlatformFiles(
      filePaths,
      withReadStream,
      withData,
    );

    return FilePickerResult(platformFiles);
  }

  @override
  Future<String?> getDirectoryPath({
    String? dialogTitle,
    bool lockParentWindow = false,
    String? initialDirectory,
  }) async {
    final handle = await OrgFreedesktopPortalFileChooser(dbusClient, "org.freedesktop.portal.Desktop", path: DBusObjectPath("/org/freedesktop/portal/desktop"))
        .callOpenFile(
      "",
      dialogTitle ?? "Open folder",
      {
        "modal": DBusBoolean(lockParentWindow),
        "directory": DBusBoolean(true),
      },
      allowInteractiveAuthorization: true
    );
    final response = await OrgFreedesktopPortalRequest(dbusClient, "org.freedesktop.portal.Desktop", path: DBusObjectPath(handle)).response.first;
    if (response.response != 0) return null;
    return (response.results["uris"] as DBusArray).mapString().map((e) => Uri.parse(e).toFilePath()).first;
  }
}
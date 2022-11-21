// This file was generated using the following command and may be overwritten.
// dart-dbus generate-remote-object org.freedesktop.portal.FileChooser.xml

import 'package:dbus/dbus.dart';

class OrgFreedesktopPortalFileChooser extends DBusRemoteObject {
  OrgFreedesktopPortalFileChooser(DBusClient client, String destination, {DBusObjectPath path = const DBusObjectPath.unchecked('/')}) : super(client, name: destination, path: path);

  /// Gets org.freedesktop.portal.FileChooser.version
  Future<int> getversion() async {
    var value = await getProperty('org.freedesktop.portal.FileChooser', 'version', signature: DBusSignature('u'));
    return (value as DBusUint32).value;
  }

  /// Invokes org.freedesktop.portal.FileChooser.OpenFile()
  Future<String> callOpenFile(String parent_window, String title, Map<String, DBusValue> options, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.portal.FileChooser', 'OpenFile', [DBusString(parent_window), DBusString(title), DBusDict.stringVariant(options)], replySignature: DBusSignature('o'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return (result.returnValues[0] as DBusObjectPath).value;
  }

  /// Invokes org.freedesktop.portal.FileChooser.SaveFile()
  Future<String> callSaveFile(String parent_window, String title, Map<String, DBusValue> options, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.portal.FileChooser', 'SaveFile', [DBusString(parent_window), DBusString(title), DBusDict.stringVariant(options)], replySignature: DBusSignature('o'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return (result.returnValues[0] as DBusObjectPath).value;
  }

  /// Invokes org.freedesktop.portal.FileChooser.SaveFiles()
  Future<String> callSaveFiles(String parent_window, String title, Map<String, DBusValue> options, {bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.portal.FileChooser', 'SaveFiles', [DBusString(parent_window), DBusString(title), DBusDict.stringVariant(options)], replySignature: DBusSignature('o'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return (result.returnValues[0] as DBusObjectPath).value;
  }
}

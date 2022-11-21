import 'package:dbus/dbus.dart';
import 'package:file_picker/src/file_picker.dart';

DBusValue filters(FileType type, List<String>? allowedExtensions) {
  // [('Images', [(0, '*.ico'), (1, 'image/png')]), ('Text', [(0, '*.txt')])]
  return DBusArray.variant([
    if (type == FileType.image || type == FileType.media) DBusStruct([
      DBusString("Images"),
      DBusArray.variant([
        DBusStruct([
          DBusUint32(1),
          DBusString("image/*"),
        ]),
      ]),
    ]),
    if (type == FileType.video || type == FileType.media) DBusStruct([
      DBusString("Videos"),
      DBusArray.variant([
        DBusStruct([
          DBusUint32(1),
          DBusString("video/*"),
        ]),
      ]),
    ]),
    if (type == FileType.audio || type == FileType.media) DBusStruct([
      DBusString("Audio"),
      DBusArray.variant([
        DBusStruct([
          DBusUint32(1),
          DBusString("audio/*"),
        ]),
      ]),
    ]),
    if (type == FileType.media) DBusStruct([
      DBusString("All Media"),
      DBusArray.variant([
        DBusStruct([
          DBusUint32(1),
          DBusString("video/*"),
        ]),
        DBusStruct([
          DBusUint32(1),
          DBusString("audio/*"),
        ]),
        DBusStruct([
          DBusUint32(1),
          DBusString("image/*"),
        ]),
      ]),
    ]),
    if (type == FileType.any) DBusStruct([
      DBusString("All Files"),
      DBusArray.variant([
        DBusStruct([
          DBusUint32(0),
          DBusString("*"),
        ]),
      ]),
    ]),
    if (allowedExtensions != null) DBusStruct([
      DBusString("Custom"),
      DBusArray.variant(allowedExtensions.map((extension) => DBusStruct([
        DBusUint32(0),
        DBusString("*.$extension"),
      ]))),
    ]),

  ]);
} 
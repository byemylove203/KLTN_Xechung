import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
//import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.room,
  }) : super(key: key);

  final types.Room room;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleImageSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Chọn ảnh'),
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     // Navigator.pop(context);
                //     // _handleFileSelection();
                //   },
                //   child: const Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text('File'),
                //   ),
                // ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Huỷ'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // void _handleFileSelection() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.any,
  //   );

  //   if (result != null && result.files.single.path != null) {
  //     _setAttachmentUploading(true);
  //     final name = result.files.single.name;
  //     final filePath = result.files.single.path!;
  //     final file = File(filePath);

  //     try {
  //       final reference = FirebaseStorage.instance.ref(name);
  //       await reference.putFile(file);
  //       final uri = await reference.getDownloadURL();

  //       final message = types.PartialFile(
  //         mimeType: lookupMimeType(filePath),
  //         name: name,
  //         size: result.files.single.size,
  //         uri: uri,
  //       );

  //       FirebaseChatCore.instance.sendMessage(message, widget.room.id);
  //       _setAttachmentUploading(false);
  //     } finally {
  //       _setAttachmentUploading(false);
  //     }
  //   }
  // }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          widget.room.id,
        );
        _setAttachmentUploading(false);
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleMessageTap(types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        final client = http.Client();
        final request = await client.get(Uri.parse(message.uri));
        final bytes = request.bodyBytes;
        final documentsDir = (await getApplicationDocumentsDirectory()).path;
        localPath = '$documentsDir/${message.name}';

        if (!File(localPath).existsSync()) {
          final file = File(localPath);
          await file.writeAsBytes(bytes);
        }
      }

      await OpenFile.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  Widget _buildAvatar(types.Room room) {
    var color = Colors.transparent;

    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(right: 16),
          child: CircleAvatar(
            backgroundColor: hasImage ? Colors.transparent : color,
            backgroundImage: hasImage ? NetworkImage(room.imageUrl!) : null,
            radius: 20,
            child: !hasImage
                ? Text(
                    name.isEmpty ? '' : name[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  )
                : null,
          ),
        ),
        Text(
          name,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildAvatar(widget.room),
        backgroundColor: Colors.black,
        elevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: StreamBuilder<types.Room>(
        initialData: widget.room,
        stream: FirebaseChatCore.instance.room(widget.room.id),
        builder: (context, snapshot) {
          return StreamBuilder<List<types.Message>>(
            initialData: const [],
            stream: FirebaseChatCore.instance.messages(snapshot.data!),
            builder: (context, snapshot) {
              return SafeArea(
                bottom: false,
                child: Chat(
                  l10n: const ChatL10nEn(
                    inputPlaceholder: 'Nhắn tin...',
                  ),
                  showUserAvatars: true,
                  isAttachmentUploading: _isAttachmentUploading,
                  messages: snapshot.data ?? [],
                  onAttachmentPressed: _handleAtachmentPressed,
                  onMessageTap: _handleMessageTap,
                  onPreviewDataFetched: _handlePreviewDataFetched,
                  onSendPressed: _handleSendPressed,
                  theme: const DefaultChatTheme(
                    // seenIcon: Text(
                    //   "seen",
                    //   style: TextStyle(color: Colors.yellow),
                    // ),
                    userNameTextStyle: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        height: 1.333),
                    backgroundColor: Colors.black,
                  ),
                  user: types.User(
                    id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
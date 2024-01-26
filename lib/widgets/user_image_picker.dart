import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    required this.onPickImage,
    super.key,
  });

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

File? _pickedImageFile;

class _UserImagePickerState extends State<UserImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: _pickedImageFile != null
              ? FileImage(
                  _pickedImageFile!,
                )
              : null,
        ),
        TextButton.icon(
          onPressed: _pickImageFromCamera,
          icon: const Icon(Icons.image),
          label: Text(
            'Add image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }

  void _pickImageFromCamera() async {
    var pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
    widget.onPickImage(_pickedImageFile!);
  }
}

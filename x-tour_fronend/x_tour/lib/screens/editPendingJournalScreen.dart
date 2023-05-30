import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditPendingJournalScreen extends StatefulWidget {
  @override
  __EditPendingJournalScreenState createState() => __EditPendingJournalScreenState();
}

class __EditPendingJournalScreenState extends State<EditPendingJournalScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _linkController;
  File? _selectedImage;
  bool _isPosting = false;
  String? _titleError;
  String? _descriptionError;
  String? _linkError;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _linkController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  String? _validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    return null;
  }

  String? _validateLink(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a link';
    }
    return null;
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage == null) return;

    final path = File(pickedImage.path);

    setState(() {
      _selectedImage = path;
    });

    Navigator.of(context).pop(); // Dismiss the bottom sheet
  }

  Widget _buildImagePreview() {
    return Container(
      height: 150,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            width: 200, // Adjusted width for better visibility
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: FileImage(_selectedImage!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 15,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedImage = null;
                });
              },
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _buildgetMode(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: Icon(
                  Icons.photo_library,
                  color: Colors.white,
                ),
                label: Text('Gallery'),
              ),
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                label: Text('Camera'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handlePost() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final link = _linkController.text;

    setState(() {
      _titleError = _validateTitle(title);
      _descriptionError = _validateDescription(description);
      _linkError = _validateLink(link);

      if (_titleError == null &&
          _descriptionError == null &&
          _linkError == null) {
        _isPosting = true;
      }
    });

    if (_titleError == null &&
        _descriptionError == null &&
        _linkError == null) {
      // Perform your post logic here

      // Simulate posting delay
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isPosting = false;
      });

      // Show a snackbar or navigate to a new page to indicate successful posting
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text('Post successful!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: const Text('Create Journal')),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _isPosting ? null : _handlePost,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    errorText: _titleError,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    errorText: _descriptionError,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _linkController,
                  decoration: InputDecoration(
                    labelText: 'Link',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    errorText: _linkError,
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: GestureDetector(
                    onTap: () => _buildgetMode(context),
                    child: Container(
                      child: Stack(
                        children: [
                          DottedBorder(
                            strokeWidth: 2,
                            color: Colors.blue,
                            dashPattern: [4, 4],
                            borderType: BorderType.Circle,
                            radius: Radius.circular(8),
                            child: Container(
                              width: 120,
                              height: 120,
                            ),
                          ),
                          Positioned(
                            top: 30,
                            left: 40,
                            child: Text(
                              'Image',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Positioned(
                            top: 60,
                            left: 40,
                            child: Icon(
                              Icons.add,
                              size: 48,
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                if (_selectedImage != null) _buildImagePreview(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

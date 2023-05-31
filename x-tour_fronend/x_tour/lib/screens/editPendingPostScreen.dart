import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditPendingPostScreen extends StatefulWidget {
  @override
  _EditPendingPostScreenState createState() => _EditPendingPostScreenState();
}

class _EditPendingPostScreenState extends State<EditPendingPostScreen> {
  String? _storyError;
  String? _descriptionError;
  late TextEditingController _storyController;
  late TextEditingController _descriptionController;
  List<File> _selectedImages = [];
  bool _isPosting = false;

  @override
  void initState() {
    super.initState();
    _storyController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _storyController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? _validateStory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your story';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    return null;
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage == null) return;

    final path = File(pickedImage.path);

    setState(() {
      _selectedImages.add(path);
    });
  }

  Widget _buildImagePreview() {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _selectedImages.length,
        itemBuilder: (context, index) {
          final imageFile = _selectedImages[index];
          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8.0),
                width: 200, // Adjusted width for better visibility
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: FileImage(imageFile),
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
                      _selectedImages.removeAt(index);
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
          );
        },
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
    final story = _storyController.text;
    final description = _descriptionController.text;

    setState(() {
      _storyError = _validateStory(story);
      _descriptionError = _validateDescription(description);
      if (_storyError == null && _descriptionError == null) {
        _isPosting = true;
      }
    });

    if (_storyError == null && _descriptionError == null) {
      // Perform your post logic here

      // Simulate posting delay
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isPosting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post successful!')),
      );
    }
    ;

    // Show a snackbar or navigate to a new page to indicate successful posting
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Create Post')),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _isPosting ? null : _handlePost,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _storyController,
              decoration: InputDecoration(
                  labelText: 'Story',
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
                  errorText: _storyError),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: 'Add a description...',
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
                  errorText: _descriptionError),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Column(children: [
                SizedBox(
                  height: 100,
                ),
                GestureDetector(
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
                        const Positioned(
                          top: 30,
                          left: 40,
                          child: Text(
                            'Image',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        const Positioned(
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
              ]),
            ),
            const SizedBox(height: 16.0),
            if (_selectedImages.isNotEmpty)
              Expanded(
                child: _buildImagePreview(),
              )
            // else
            //   const Text('No images selected'),
          ],
        ),
      ),
    );
  }
}

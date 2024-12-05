import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final List<Map<String, String>> projects = [
    {
      'title': 'Aplikasi E-Commerce',
      'description': 'Aplikasi belanja online berbasis Flutter.',
      'image': 'assets/e-commerce.jpg',
    },
    {
      'title': 'Sistem Pengelolaan Data',
      'description': 'Aplikasi pengelolaan data menggunakan Python dan SQL.',
      'image': 'assets/data.jpg',
    },
    {
      'title': 'Website Portfolio',
      'description': 'Website personal dengan HTML, CSS, dan JavaScript.',
      'image': 'assets/logo.jpg',
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredProjects = projects
        .where((project) =>
            project['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Projects'),
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearchDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showAddProjectDialog(context);
            },
          ),
        ],
      ),
      body: filteredProjects.isEmpty
          ? const Center(
              child: Text('No projects found.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: filteredProjects.length,
              itemBuilder: (context, index) {
                final project = filteredProjects[index];
                final imagePath = project['image']!;
                final isAsset = imagePath.startsWith('assets/');

                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          title: Text(
                            project['title']!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: isAsset
                                    ? Image.asset(
                                        imagePath,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(imagePath),
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                project['description']!,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ).animate().scale(duration: 300.ms).fadeIn();
                      },
                    );
                  },
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          child: isAsset
                              ? Image.asset(
                                  imagePath,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(imagePath),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                project['description']!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDeleteConfirmationDialog(context, index);
                          },
                        ),
                      ],
                    ),
                  ).animate().slideX(
                      duration: 500.ms, begin: -1.0, curve: Curves.easeOut),
                );
              },
            ),
    );
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String query = '';
        return AlertDialog(
          title: const Text('Search Projects'),
          content: TextField(
            decoration: const InputDecoration(
              hintText: 'Enter project title',
            ),
            onChanged: (value) {
              query = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  searchQuery = query;
                });
                Navigator.pop(context);
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }

  void showAddProjectDialog(BuildContext context) {
    String newTitle = '';
    String newDescription = '';
    File? newImage;

    final picker = ImagePicker();

    Future<void> pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          newImage = File(pickedFile.path);
        });
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Project'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Project Title'),
                  onChanged: (value) {
                    newTitle = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  onChanged: (value) {
                    newDescription = value;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => pickImage(),
                  child: const Text('Select Image'),
                ),
                if (newImage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.file(
                      newImage!,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newTitle.isNotEmpty &&
                    newDescription.isNotEmpty &&
                    newImage != null) {
                  setState(() {
                    projects.add({
                      'title': newTitle,
                      'description': newDescription,
                      'image': newImage!.path,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('hapus Project'),
          content: const Text('apakah anda yakin ingin menghapus project ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  projects.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

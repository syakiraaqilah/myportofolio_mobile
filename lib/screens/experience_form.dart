import 'dart:typed_data';
import 'package:material_ui/material_ui.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/left_drawer.dart';
import '../theme.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startedAtController = TextEditingController();
  final _endedAtController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  final List<String> _categories = [
    'Full-Time',
    'Part-Time',
    'Internship',
    'Freelance',
    'Volunteer',
    'Research',
    'Other',
  ];
  String _category = 'Full-Time';

  DateTime? _startedAt;
  DateTime? _endedAt;
  bool _isOngoing = false;

  XFile? _thumbnail;
  Uint8List? _thumbnailBytes;

  int _resetCount = 0;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _startedAtController.dispose();
    _endedAtController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) return; 
    final bytes = await file.readAsBytes();
    if (!mounted) return;
    setState(() {
      _thumbnail = file;
      _thumbnailBytes = bytes;
    });
  }

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final firstDate = isStart ? DateTime(1990) : (_startedAt ?? DateTime(1990));
    final lastDate = DateTime(now.year + 5);

    // initialDate harus berada di antara firstDate dan lastDate
    DateTime initial = (isStart ? _startedAt : _endedAt) ?? now;
    if (initial.isBefore(firstDate)) initial = firstDate;
    if (initial.isAfter(lastDate)) initial = lastDate;

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked == null || !mounted) return;

    setState(() {
      if (isStart) {
        _startedAt = picked;
        _startedAtController.text = _formatDate(picked);
        if (_endedAt != null && _endedAt!.isBefore(picked)) {
          _endedAt = null;
          _endedAtController.clear();
        }
      } else {
        _endedAt = picked;
        _endedAtController.text = _formatDate(picked);
      }
    });
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _nameController.clear();
      _descriptionController.clear();
      _startedAtController.clear();
      _endedAtController.clear();
      _category = _categories.first;
      _startedAt = null;
      _endedAt = null;
      _isOngoing = false;
      _thumbnail = null;
      _thumbnailBytes = null;
      _resetCount++;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Experience added successfully!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${_nameController.text.trim()}"),
                Text('Description: ${_descriptionController.text.trim()}'),
                Text('Category: $_category'),
                Text('Started at: ${_startedAtController.text}'),
                Text('Ended at: ${_isOngoing ? "Present" : _endedAtController.text}'),
                const SizedBox(height: 8),
                if (_thumbnailBytes != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(_thumbnailBytes!, height: 120),
                  )
                else
                  const Text('Documentation: no photo'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                _resetForm();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDateField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required VoidCallback onTap,
    required String? Function(String?) validator,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        readOnly: true, 
        enabled: enabled,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          suffixIcon: const Icon(Icons.calendar_today_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Experience Form',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.ink,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Experience Name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Add experience's name",
                    labelText: "Experience's Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Experience's name must not be empty!";
                    }
                    return null;
                  },
                ),
              ),

              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Add experience's description",
                    labelText: "Experience's Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Experience's description must not be empty!";
                    }
                    return null;
                  },
                ),
              ),

              // === Category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  key: ValueKey('category-$_resetCount'),
                  decoration: InputDecoration(
                    labelText: "Experience's Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _category,
                  items: _categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() => _category = newValue!);
                  },
                ),
              ),

              // === Started At ===
              _buildDateField(
                label: 'Started At',
                hint: 'Select start date',
                controller: _startedAtController,
                onTap: () => _pickDate(isStart: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Start date must not be empty!';
                  }
                  return null;
                },
              ),

              // === Ended At ===
              _buildDateField(
                label: 'Ended At',
                hint: 'Select end date',
                controller: _endedAtController,
                enabled: !_isOngoing,
                // End date hanya bisa dipilih kalau start sudah ada
                onTap: () {
                  if (_startedAt == null) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(const SnackBar(
                          content: Text('Pick the start date first!')));
                    return;
                  }
                  _pickDate(isStart: false);
                },
                validator: (value) {
                  if (_isOngoing) return null;
                  if (value == null || value.isEmpty) {
                    return "End date must not be empty (or check 'Currently ongoing')";
                  }
                  return null;
                },
              ),

              // === Currently ongoing ===
              CheckboxListTile(
                value: _isOngoing,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('Currently ongoing'),
                onChanged: (bool? value) {
                  setState(() {
                    _isOngoing = value ?? false;
                    if (_isOngoing) {
                      _endedAt = null;
                      _endedAtController.clear();
                    }
                  });
                },
              ),

              // === Thumbnail ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_thumbnailBytes != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(_thumbnailBytes!, height: 150),
                        ),
                      ),
                    OutlinedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.add_a_photo_outlined),
                      label: Text(_thumbnailBytes == null ? 'Add a photo' : 'Change photo'),
                    ),
                  ],
                ),
              ),

              // === Save ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(AppColors.muted),
                    ),
                    onPressed: _submit,
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
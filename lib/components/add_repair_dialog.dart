// lib/components/add_repair_dialog.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:csp_project_app/data/location_data_provider.dart';
import 'package:csp_project_app/data/repair.dart';

class AddRepairDialog extends StatefulWidget {
  const AddRepairDialog({super.key});

  @override
  State<AddRepairDialog> createState() => _AddRepairDialogState();
}

class _AddRepairDialogState extends State<AddRepairDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedStatus = 'Scheduled'; // Default status

  final List<String> _statusOptions = ['Scheduled', 'Pending', 'Completed'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submitRepair() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a date")),
        );
        return;
      }

      final newRepair = Repair(
        title: _titleController.text,
        description: _descriptionController.text,
        date: DateFormat('MMM d, yyyy').format(_selectedDate!),
        status: _selectedStatus,
      );

      // Add to provider
      context.read<LocationDataProvider>().addRepair(newRepair);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Repair schedule added!")),
      );
      Navigator.pop(context); // Close dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "Add Repair Schedule",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Title (e.g., Pipe Leak)",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? "Title is required" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? "Description is required" : null,
              ),
              const SizedBox(height: 12),
              // Status Dropdown
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: _statusOptions.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedStatus = newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 12),
              // Date Picker
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date chosen'
                          : 'Date: ${DateFormat('MMM d, yyyy').format(_selectedDate!)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: const Text('Choose Date'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _submitRepair,
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
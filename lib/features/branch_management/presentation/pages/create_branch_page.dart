import 'package:flutter/material.dart';

class CreateBranchPage extends StatefulWidget {
  const CreateBranchPage({super.key});

  @override
  State<CreateBranchPage> createState() => _CreateBranchPageState();
}

class _CreateBranchPageState extends State<CreateBranchPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _districtController = TextEditingController();
  final _cityController = TextEditingController();
  final _contactNumberController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _zipCodeController.dispose();
    _districtController.dispose();
    _cityController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement Bloc logic to create branch
      final name = _nameController.text;
      final address = _addressController.text;
      final zipCode = _zipCodeController.text;
      final district = _districtController.text;
      final city = _cityController.text;
      final contactNumber = _contactNumberController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Creating Branch: $name, Addr: $address, Zip: $zipCode, Dist: $district, City: $city, Contact: $contactNumber',
          ),
        ),
      ); // Navigate back after successful creation (mock)
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Branch')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Branch Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.business),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a branch name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _zipCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Zip Code',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.map),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _districtController,
                  decoration: const InputDecoration(
                    labelText: 'District',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_city),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_city),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contactNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Create Branch',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

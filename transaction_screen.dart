import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/account.dart';
import '../helpers/db_helper.dart';

class TransactionScreen extends StatefulWidget {
  final bool isSupplier;
  const TransactionScreen({Key? key, required this.isSupplier}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  File? pickedImage;

  Future pickImage() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 60);
    if (image == null) return;
    setState(() {
      pickedImage = File(image.path);
    });
  }

  void save() async {
    if (!_formKey.currentState!.validate()) return;
    final acc = Account(name: _name.text.trim(), amount: double.parse(_amount.text.trim()), isSupplier: widget.isSupplier, imagePath: pickedImage?.path);
    await DBHelper.insertAccount(acc);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isSupplier ? 'Add Supplier' : 'Add Customer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _name, decoration: const InputDecoration(labelText: 'Name'), validator: (v) => v==null||v.isEmpty?'Required':null),
              TextFormField(controller: _amount, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Amount (positive for receivable, negative for payable)'), validator: (v) => v==null||v.isEmpty?'Required':null),
              const SizedBox(height: 12),
              ElevatedButton.icon(onPressed: pickImage, icon: const Icon(Icons.camera_alt), label: const Text('Take Memo Photo')),
              if (pickedImage != null) Image.file(pickedImage!, height: 140),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: save, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'customer_screen.dart';
import 'supplier_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('হাল খাতা')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Customer Accounts'),
                subtitle: const Text('কাস্টমারদের হিসাব দেখুন'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerScreen())),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.store),
                title: const Text('Supplier Accounts'),
                subtitle: const Text('সাপ্লায়ারের হিসাব দেখুন'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SupplierScreen())),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
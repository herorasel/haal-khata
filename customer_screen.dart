import 'package:flutter/material.dart';
import '../models/account.dart';
import '../helpers/db_helper.dart';
import 'transaction_screen.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  List<Account> accounts = [];

  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future refresh() async {
    accounts = await DBHelper.getAccounts(isSupplier: false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionScreen(isSupplier: false))).then((_) => refresh()),
      ),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, i) {
          final a = accounts[i];
          return ListTile(
            title: Text(a.name),
            subtitle: Text('Balance: ৳${a.amount.toStringAsFixed(2)}'),
            onTap: () {},
          );
        },
      ),
    );
  }
}
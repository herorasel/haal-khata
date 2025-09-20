class Account {
  final int? id;
  final String name;
  final double amount;
  final bool isSupplier;
  final String? imagePath;

  Account({this.id, required this.name, required this.amount, required this.isSupplier, this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'isSupplier': isSupplier ? 1 : 0,
      'imagePath': imagePath,
    };
  }

  static Account fromMap(Map<String, dynamic> m) {
    return Account(
      id: m['id'],
      name: m['name'],
      amount: m['amount'],
      isSupplier: m['isSupplier'] == 1,
      imagePath: m['imagePath'],
    );
  }
}
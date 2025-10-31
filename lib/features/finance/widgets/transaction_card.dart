import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final hasImage = transaction.photoURL.isNotEmpty;

    final leading = hasImage
        ? ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: transaction.photoURL,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: 56,
          height: 56,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(strokeWidth: 2),
        ),
        errorWidget: (context, url, error) =>
        const Icon(Icons.broken_image),
      ),
    )
        : const CircleAvatar(child: Icon(Icons.image_not_supported));

    return ListTile(
      leading: leading,
      title: Text(transaction.name),
      subtitle: Text(transaction.reason),
      trailing: Text('${transaction.amount.toStringAsFixed(2)} ₽'),
    );
  }
}

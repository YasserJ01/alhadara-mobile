import 'package:alhadara/core/constants/colors.dart';
import 'package:alhadara/features/wallet/domain/entities/transaction_entity.dart';
import 'package:flutter/material.dart';

// class TransactionItem extends StatelessWidget {
//   final String title;
//   final String amount;
//   final String date;

//   const TransactionItem({
//     required this.title,
//     required this.amount,
//     required this.date,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 amount,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: amount.startsWith('-') ? Colors.red : Colors.green,
//                 ),
//               ),
//               Text(
//                 date,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//           const Divider(
//             height: 20,
//             color: Color.fromARGB(255, 135, 133, 133),
//           ),
//         ],
//       ),
//     );
//   }
// }

class TransactionItem extends StatelessWidget {
  final String title;
  final String amount;
  final String date;
  final TransactionEntity? transactionDetails;

  const TransactionItem({
    required this.title,
    required this.amount,
    required this.date,
    this.transactionDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 14,
                  color: amount.startsWith('-') ? Colors.red : Colors.green,
                ),
              ),
              Text(
                date.substring(0, 16),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          if (transactionDetails != null)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () =>
                    _showTransactionDetails(context, transactionDetails!),
                child: const Text(
                  'View Details',
                  style: TextStyle(color: AppColors.mainColor),
                ),
              ),
            ),
          const Divider(
            height: 20,
            color: Color.fromARGB(255, 135, 133, 133),
          ),
        ],
      ),
    );
  }

  void _showTransactionDetails(
      BuildContext context, TransactionEntity details) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        title: const Text(
          'Transaction Details',
          style: TextStyle(
              color: AppColors.mainColor, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildDetailRow('Reference ID', details.referenceId),
              _buildDetailRow('Transaction Type', details.transactionType),
              // _buildDetailRow('Sender Name', details.senderName!),
              //  _buildDetailRow('Receiver Name', details.receiverName),
              _buildDetailRow('Amount', details.amount),
              _buildDetailRow(
                  'Date', details.createdAt.toString().substring(0, 16)),
              _buildDetailRow('Status', details.status),
              _buildDetailRow('Description', details.description),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: AppColors.mainColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Color.fromARGB(255, 101, 96, 96)),
            ),
          ),
        ],
      ),
    );
  }
}

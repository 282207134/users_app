import 'package:flutter/material.dart';

// 定义 StatefulWidget
class LoadingDialog extends StatefulWidget {
  final String messageText;

  LoadingDialog({
    super.key,
    required this.messageText,
  });

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

// 定义与 StatefulWidget 关联的 State 类
class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.black87,
      child: Container(
        margin: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const SizedBox(width: 5),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                widget.messageText, // 使用 widget 来访问 StatefulWidget 的属性
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

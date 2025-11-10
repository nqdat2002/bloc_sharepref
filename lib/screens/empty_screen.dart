import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onRefresh;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;

  const EmptyScreen({
    super.key,
    this.title = 'Không có dữ liệu',
    this.subtitle = 'Thử tải lại hoặc quay về trang trước.',
    this.icon = Icons.inbox_outlined,
    this.onRefresh,
    this.onPrimaryAction,
    this.onSecondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    final primary = onPrimaryAction ??
        () {
          // default: nếu có thể back thì về trang trước, nếu không thì về root
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        };

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red.shade50,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Icon(icon, size: 56, color: Colors.red.shade700),
                ),
                const SizedBox(height: 18),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red.shade700.withOpacity(0.8)),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onRefresh != null)
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                        ),
                        onPressed: onRefresh,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Tải lại'),
                      ),
                    if (onRefresh != null) const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red.shade700,
                        side: BorderSide(color: Colors.red.shade200),
                      ),
                      onPressed: primary,
                      child: const Text('Quay lại'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (onSecondaryAction != null)
                  TextButton(
                    onPressed: onSecondaryAction,
                    child: Text(
                      'Tìm kiếm nội dung khác',
                      style: TextStyle(color: Colors.red.shade700),
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

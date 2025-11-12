import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> favorites = ['Favorite A', 'Favorite B', 'Favorite C'];

    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.red.shade700,
        elevation: 0,
      ),
      body: favorites.isEmpty
          ? Center(
              child: Text('Không có mục yêu thích', style: TextStyle(color: Colors.red.shade700)),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: favorites.length,
              separatorBuilder: (_, __) => const Divider(height: 0),
              itemBuilder: (context, index) {
                final item = favorites[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red.shade100,
                    child: Icon(Icons.favorite, color: Colors.red.shade700),
                  ),
                  title: Text(item),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Xoá $item (demo)')));
                    },
                  ),
                  onTap: () {},
                );
              },
            ),
    );
  }
}
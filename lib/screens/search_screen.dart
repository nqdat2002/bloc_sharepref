import 'dart:async';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _allItems = [
    'Apple',
    'Banana',
    'Cherry',
    'Durian',
    'Dragonfruit',
    'Grapes',
    'Mango',
    'Orange',
    'Pineapple',
    'Strawberry',
    'Watermelon',
  ];
  final List<String> _recent = [];
  List<String> _results = [];
  Timer? _debounce;
  bool _isLoading = false;

  void _onChanged(String q) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () => _search(q));
  }

  void _search(String q) async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 250)); // simulate work

    final term = q.trim().toLowerCase();
    final results = term.isEmpty
        ? <String>[]
        : _allItems.where((e) => e.toLowerCase().contains(term)).toList();

    setState(() {
      _results = results;
      _isLoading = false;
    });
  }

  void _submit(String q) {
    final trimmed = q.trim();
    if (trimmed.isEmpty) return;

    if (!_recent.contains(trimmed)) {
      _recent.insert(0, trimmed);
      if (_recent.length > 8) _recent.removeLast();
    }

    _search(trimmed);
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _controller,
      onChanged: _onChanged,
      onSubmitted: _submit,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Tìm kiếm...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _controller.text.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  _onChanged('');
                },
              ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildRecent() {
    if (_recent.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent', style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                setState(() {
                  _recent.clear();
                });
              },
              child: Text('Clear', style: TextStyle(color: Colors.red.shade700)),
            ),
          ],
        ),
        Wrap(
          spacing: 8,
          children: _recent
              .map((r) => ActionChip(
                    backgroundColor: Colors.red.shade50,
                    label: Text(r),
                    onPressed: () {
                      _controller.text = r;
                      _submit(r);
                    },
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildResults() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_controller.text.isEmpty && _results.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Nhập từ khóa để tìm kiếm',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
      );
    }

    if (_results.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Không tìm thấy kết quả',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: _results.length,
      separatorBuilder: (_, __) => const Divider(height: 0),
      itemBuilder: (context, index) {
        final item = _results[index];
        return ListTile(
          title: Text(item),
          leading: const Icon(Icons.location_on_outlined),
          onTap: () {
            // handle selection (navigate or show detail)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Selected: $item')),
            );
            if (!_recent.contains(item)) {
              setState(() {
                _recent.insert(0, item);
                if (_recent.length > 8) _recent.removeLast();
              });
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // rebuild to show clear icon when controller changes
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.red.shade700,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildSearchField(),
              _buildRecent(),
              const SizedBox(height: 8),
              Expanded(child: _buildResults()),
            ],
          ),
        ),
      ),
    );
  }
}
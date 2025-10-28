import 'package:flutter/material.dart';

class MoneyTrackerList<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Duration duration;

  const MoneyTrackerList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  State<MoneyTrackerList<T>> createState() => _MoneyTrackerListState<T>();
}

class _MoneyTrackerListState<T> extends State<MoneyTrackerList<T>> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<T> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
  }

  @override
  void didUpdateWidget(covariant MoneyTrackerList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newItems = widget.items;

    if (newItems.length > _items.length) {
      final newItem = newItems.firstWhere(
        (item) => !_items.contains(item),
        orElse: () => newItems.last,
      );
      final index = newItems.indexOf(newItem);
      _items.insert(index, newItem);
      _listKey.currentState?.insertItem(index, duration: widget.duration);
    } else if (newItems.length < _items.length) {
      for (int i = 0; i < _items.length; i++) {
        if (i >= newItems.length || _items[i] != newItems[i]) {
          final removedItem = _items.removeAt(i);
          _listKey.currentState?.removeItem(
            i,
            (context, animation) =>
                _buildAnimatedItem(removedItem, i, animation),
            duration: widget.duration,
          );
          break;
        }
      }
    }
  }

  Widget _buildAnimatedItem(T item, int index, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
      child: FadeTransition(
        opacity: animation,
        child: widget.itemBuilder(context, item, index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) =>
          _buildAnimatedItem(_items[index], index, animation),
    );
  }
}

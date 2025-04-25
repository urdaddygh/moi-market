import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/default_custom_wrapper.dart';
import 'package:moi_market/features/home/presentation/widgets/item_card.dart';
import 'package:moi_market/features/home/presentation/widgets/requisites_wrapper.dart';
import 'package:moi_market/features/home/presentation/widgets/triple_tab_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  List<String> _items = [];
  bool _isLoadingMore = false;
  bool _hasMore = true;
  int _page = 1;
  final int _limit = 10;

  @override
  void initState() {
    super.initState();
    _loadInitial();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        if (!_isLoadingMore && _hasMore) {
          _loadMore();
        }
      }
    });
  }

  Future<void> _loadInitial() async {
    final newItems = await _fetchItems();
    setState(() {
      _items = newItems;
    });
  }

  Future<void> _loadMore() async {
    setState(() => _isLoadingMore = true);
    _page++;

    final newItems = await _fetchItems();
    setState(() {
      _isLoadingMore = false;
      if (newItems.length < _limit) _hasMore = false;
      _items.addAll(newItems);
    });
  }

  Future<List<String>> _fetchItems() async {
    // Здесь будет твой API-запрос с учетом _page и _limit
    await Future.delayed(Duration(seconds: 2)); // имитируем задержку
    if (_page >= 3) return []; // после 3-й страницы считаем что ничего нет
    return List.generate(_limit, (index) => 'Item ${_page * _limit + index + 1}');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultCustomWrapper(
        headerTitle: 'Мои группы',
        body: Column(
          children: [
            const SizedBox(height: Style.bigSpacing),
            const RequisitesWrapper(
              phone: '+996 500 500 500',
            ),
            const SizedBox(height: Style.bigSpacing),
            Expanded(
              /// 🔧 ОБЯЗАТЕЛЬНО! Даёт ограничение по высоте
              child: RentTripleTab(
                firstTitle: 'Все',
                secondTitle: 'Активные',
                thirdTitle: 'Неактивные',
                firstTab: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => ItemCard(),
                ),
                secondTab: Container(color: Style.primarySecondColor),
                thirdTab: Container(color: Style.primarySecondColor),
              ),
            ),
          ],
        ));
  }
}

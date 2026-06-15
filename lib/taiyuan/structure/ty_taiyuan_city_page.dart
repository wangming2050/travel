import 'package:flutter/material.dart';

import '../ty_city_page.dart';
import 'ty_taiyuan_food.dart';
import 'ty_taiyuan_intro.dart';
import 'ty_taiyuan_routes.dart';
import 'ty_taiyuan_spots.dart';

class TaiyuanCityPage extends StatelessWidget {
  const TaiyuanCityPage({super.key});

  static const _heroBg = [
    (color: Color(0xFF1a1028), emoji: '🏯'),
    (color: Color(0xFF0f1a14), emoji: '🌲'),
    (color: Color(0xFF1a0d08), emoji: '🍲'),
    (color: Color(0xFF081420), emoji: '🗺️'),
  ];

  @override
  Widget build(BuildContext context) {
    return const CityPage(
      tabs: [
        TaiyuanIntroTab(),
        TaiyuanSpotsTab(),
        TaiyuanFoodTab(),
        TaiyuanRoutesTab(),
      ],
      heroBackgrounds: _heroBg,
    );
  }
}

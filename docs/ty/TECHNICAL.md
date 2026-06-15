# 家乡介绍 App - 技术文档
open -a Simulator && sleep 5 && flutter run

## 技术选型

| 项 | 选型 | 说明 |
|----|------|------|
| 框架 | Flutter 3.x | 跨平台移动端，Dart 语言 |
| 状态管理 | `StatefulWidget` + `setState` | 页面级状态，无额外依赖，简单够用 |
| 国际化 | `flutter_localizations` + 自定义 Map | 3 语言翻译表，零代码生成 |
| 图片 | Flutter 渐变渲染（离线） | 无需网络，后续可替换 `Image.asset` |
| 代码风格 | Dart 3 Records | `(int, String, String, ...)` 元组类型简化数据传递 |

**依赖清单** (`pubspec.yaml`)：

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  flutter_localizations:
    sdk: flutter
```

仅 2 个外部依赖，无第三方包。

## 项目结构

```
lib/
├── main.dart              # 入口：组装太原 App
├── app.dart               # App 壳：主题 / 多语言注册 / 全局 Locale 状态
├── city_page.dart         # 城市页面框架：Hero + Tab栏 + PageView 滑动
│
├── shared/                # ★ 共用组件层（所有城市通用，请勿加城市专属代码）
│   ├── colors.dart        #   AppColors 全局颜色常量
│   ├── widgets.dart       #   GoldPill / DimPill / SectionTitle
│   │                      #   StatTile / StatsRow / InfoTile / InfoGrid
│   │                      #   TextBlock / HapticTap / PlaceholderImage
│   │                      #   SpotCard / FoodCard（含热度点动画）
│   ├── hero_header.dart   #   CityHeroHeader（动态背景+🌐按钮）
│   ├── tab_row.dart       #   CityTabRow（滑动指示器跟随 PageController）
│   ├── detail_sheet.dart  #   showSpotDetail / showFoodDetail + _DetailSheet
│   └── lang_sheet.dart    #   showLangSheet + _LangSheet（语言选择）
│
├── taiyuan/               # ★ 太原专属层（作者: testerwm）
│   ├── taiyuan_intro.dart #   介绍 Tab — 7 个板块
│   ├── taiyuan_spots.dart #   景点 Tab — 6 横滑卡片 + 7 列表项
│   ├── taiyuan_food.dart  #   美食 Tab — 10 道 2 列网格
│   └── taiyuan_routes.dart#   路线 Tab — 5 条路线 + 可展开步骤
│
└── l10n/                  # 翻译层（所有城市共用 key 前缀区分）
    ├── app_localizations.dart      # AppLocalizations + Delegate
    ├── app_localizations_zh.dart   # 中文（约 50 通用键 + 250 内容键）
    ├── app_localizations_en.dart   # 英文
    └── app_localizations_ko.dart   # 韩文
```

## 架构分层

```
┌──────────────┐
│  main.dart   │  组装层：选择城市 → 传入 tabs + heroBackgrounds
├──────────────┤
│ city_page.dart│  框架层：Hero + Tab栏 + PageView（不含任何城市数据）
├──────────────┤
│  shared/     │  组件层：15+ 可复用 Widget，通过参数接收数据
├──────────────┤
│ taiyuan/     │  数据层：l10n key 引用 + 组件拼装
├──────────────┤
│  l10n/       │  翻译层：key-value 文本映射，3 语言
└──────────────┘
```

## 核心设计模式

### 1. 城市页框架 (`city_page.dart`)

```dart
CityPage(
  tabs: [TaiyuanIntroTab(), TaiyuanSpotsTab(), ...],  // 4 个 Tab 内容
  heroBackgrounds: [(color, emoji), ...],              // 每个 Tab 的背景
)
```

### 2. 详情弹窗 (`detail_sheet.dart`)

通过 l10n key 前缀查找翻译，景点和美食共用同一套底 sheet 组件：

```dart
showSpotDetail(context, 'spotJinci', '🏯');
// → 查找 spotJinci / spotJinciDesc / spotJinciHours / spotJinciLoc / spotJinciTip
```

### 3. 翻译架构 (`l10n/`)

```dart
AppLocalizations.of(context)['key']  // 根据当前 locale 返回对应语言文本
```

通用键（`heroBack`, `tabIntro` 等）和城市专属键（`spotJinci`, `foodDaoxiao` 等）混在同一 Map，通过命名前缀区分。

## 新增城市指南

以添加「成都」为例：

1. 创建 `lib/chengdu/` 目录
2. 复制 `lib/taiyuan/` 下 4 个文件，搜索替换 `taiyuan` → `chengdu`
3. 修改每个文件中的 l10n key 引用为自己的 key
4. 在 3 个 `app_localizations_*.dart` 末尾追加成都专属翻译键
5. 创建 `lib/main_chengdu.dart`：

```dart
class _ChengduApp extends StatelessWidget {
  static const _bg = [(color: ..., emoji: '🐼'), ...];
  @override
  Widget build(BuildContext c) => MyApp(home: CityPage(
    tabs: const [ChengduIntroTab(), ...],
    heroBackgrounds: _bg,
    provinceKey: 'chengduProvince',  // 替换为自己的 key
    cityKey: 'chengduName',
  ));
}
```

## 文件命名规范

| 规则 | 示例 |
|------|------|
| 共用组件 | `lib/shared/<功能名>.dart` |
| 城市 Tab | `lib/<城市>/<城市>_<tab名>.dart` |
| 每个文件头注释 | 文件路径 / 用途 / 作者 / 创建日期 / 说明 |
| 翻译 key 前缀 | `spot<Name>` / `food<Name>` / `route<N><Name>` |

---

> 文档维护: testerwm | 更新: 2026-06-09

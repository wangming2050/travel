lib/
├── main.dart                          # 启动入口
├── ty/
│   ├── ty_app.dart                    # App 壳（MaterialApp/主题/多语言）
│   ├── ty_home_page.dart              # 首页（16城市卡片列表）
│   ├── ty_city_page.dart              # 城市页框架（Hero/Tab/PageView）
│   ├── ty_taiyuan_app.dart            # 太原 App wrapper
│   │
│   ├── ty_l10n/                       # 📖 国际化
│   │   ├── ty_app_localizations.dart  #   翻译代理
│   │   ├── ty_app_localizations_zh.dart
│   │   ├── ty_app_localizations_en.dart
│   │   └── ty_app_localizations_ko.dart
│   │
│   ├── ty_shared/                     # 🧩 共享组件
│   │   ├── ty_colors.dart             #   晋商色系
│   │   ├── ty_hero_header.dart        #   Hero 头部
│   │   ├── ty_tab_row.dart            #   Tab 栏
│   │   ├── ty_detail_sheet.dart       #   详情弹窗
│   │   ├── ty_lang_sheet.dart         #   语言切换弹窗
│   │   ├── ty_widgets.dart            #   通用 Widget
│   │   ├── ty_ai_assistant_sheet.dart #   🤖 AI 助手 UI
│   │   ├── ty_ai_service.dart         #   AI API 服务
│   │   └── ty_ai_config.dart          #   AI 配置/提示词
│   │
│   └── ty_taiyuan/                    # 🏯 太原专属
│       ├── ty_taiyuan_city_page.dart  #   太原城市页入口
│       ├── ty_taiyuan_intro.dart      #   介绍 Tab
│       ├── ty_taiyuan_spots.dart      #   景点 Tab
│       ├── ty_taiyuan_food.dart       #   美食 Tab
│       └── ty_taiyuan_routes.dart     #   路线 Tab
│
assets/ty_taiyuan/video/
└── ty_taiyuan.mp4                     # 太原宣传视频

designs/ty-ui-optimization/            # 🎨 设计稿
├── taiyuan_app_complete_v3.html
├── taiyuan_app_complete_v4.html
├── taiyuan_page1_with_ai.html
└── taiyuan_travel_ui_v2.html

proxy/                                 # 🔧 AI 代理服务器（独立进程）
├── lib/config.dart                    #   DeepSeek API Key
├── lib/server.dart                    #   Shelf 代理
└── pubspec.yaml



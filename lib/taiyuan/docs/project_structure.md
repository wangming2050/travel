# 太原城市展示 - 项目梳理文档 / 타이위안 도시 소개 - 프로젝트 정리 문서

> 文档维护 / 문서 관리: testerwm | 更新 / 업데이트: 2026-06-11

---

## 一、项目概述 / 1. 프로젝트 개요

"我和我的家乡" 是一款展示中国城市风貌的 Flutter 移动端 App。项目采用**多城市扩展架构**，首期实现太原（Taiyuan）城市页面，后续团队成员可各自添加自己的家乡城市。

"나와 나의 고향"은 중국 도시의 모습을 소개하는 Flutter 모바일 앱입니다. **다중 도시 확장 아키텍처**를 채택하여, 1차로 타이위안 도시 페이지를 구현했으며, 이후 팀원들이 각자 자신의 고향 도시를 추가할 수 있습니다.

| 项目 / 항목 | 说明 / 설명 |
|-------------|-------------|
| 框架 / 프레임워크 | Flutter 3.x + Dart |
| 支持平台 / 지원 플랫폼 | iOS / Android / macOS / Windows / Linux / Web |
| 语言 / 언어 | 中文 / English / 한국어 三语即时切换 / 3개 언어 실시간 전환 |
| 设计风格 / 디자인 스타일 | 浅色主题 — 晋商色系（汾河砖红 × 黄土米白 × 古建深墨） / 라이트 테마 — 진상인 색상 계열 (펀허 강변 벽돌 붉은색 × 황토 베이지 × 고건축 짙은 먹색) |

---

## 二、目录结构 / 2. 디렉토리 구조

```
lib/
├── main.dart                              # 🚀 启动入口 — 城市选择首页 / 시작 진입점 — 도시 선택 홈
│
├── taiyuan/                               # 🏯 太原模块根目录 / 타이위안 모듈 루트
│   │
│   ├── ty_app.dart                        # App 壳 — MaterialApp、主题、多语言注册 / 앱 셸 — MaterialApp, 테마, 다국어 등록
│   ├── ty_taiyuan_app.dart                # 太原 App 入口包装器 / 타이위안 앱 진입 래퍼
│   ├── ty_city_page.dart                  # 城市页通用框架 — Hero + Tab 栏 + PageView / 도시 페이지 공통 프레임워크
│   │
│   ├── structure/                         # 📄 太原城市页（Tab 组装） / 타이위안 도시 페이지 (탭 조립)
│   │   ├── ty_taiyuan_city_page.dart      #   太原城市页入口 — 组装 4 个 Tab + Hero 背景 / 타이위안 도시 페이지 진입점
│   │   ├── ty_taiyuan_intro.dart          #   介绍 Tab — 视频 + 统计 + 标签 + 扩展内容 / 소개 탭 — 영상 + 통계 + 태그 + 확장 콘텐츠
│   │   ├── ty_taiyuan_spots.dart          #   景点 Tab — 6 横向卡片 + 7 列表项 / 명소 탭 — 가로 카드 6개 + 리스트 7개
│   │   ├── ty_taiyuan_food.dart           #   美食 Tab — 10 道美食 2 列网格 / 음식 탭 — 10가지 음식 2열 그리드
│   │   └── ty_taiyuan_routes.dart         #   路线 Tab — 5 条路线 + 可展开时间线步骤 / 코스 탭 — 5개 코스 + 확장 가능한 타임라인
│   │
│   ├── shared/                            # 🧩 共享组件（所有城市通用） / 공유 컴포넌트 (모든 도시 공통)
│   │   ├── ty_colors.dart                 #   全局色系 — AppColors（砖红/米白/深墨/铜金） / 전역 색상 — 벽돌 붉은색/베이지/짙은 먹색/구리 금색
│   │   ├── ty_widgets.dart                #   通用 Widget 库（15+ 组件） / 공통 위젯 라이브러리 (15개+ 컴포넌트)
│   │   ├── ty_hero_header.dart            #   Hero 头部 — 缩放式城市标题 + emoji 图标 / 히어로 헤더 — 스케일링 도시 제목 + 이모지 아이콘
│   │   ├── ty_tab_row.dart                #   Tab 栏 — 红色滑动指示器 / 탭 바 — 붉은색 슬라이딩 인디케이터
│   │   ├── ty_detail_sheet.dart           #   详情底弹窗 — 景点/美食共用 / 상세 하단 시트 — 명소/음식 공용
│   │   ├── ty_lang_sheet.dart             #   语言选择底弹窗 — 中/英/韩 / 언어 선택 하단 시트 — 중/영/한
│   │   ├── ty_ai_assistant_sheet.dart     #   🤖 AI 旅行助手 UI — 流式对话界面 / AI 여행 도우미 UI — 스트리밍 대화 인터페이스
│   │   ├── ty_ai_service.dart             #   AI 聊天 API 服务（SSE 流式） / AI 채팅 API 서비스 (SSE 스트리밍)
│   │   └── ty_ai_config.dart              #   AI 配置 — DeepSeek 提示词（三语） / AI 설정 — DeepSeek 프롬프트 (3개 언어)
│   │
│   ├── l10n/                              # 📖 国际化翻译表 / 국제화 번역 테이블
│   │   ├── ty_app_localizations.dart      #   翻译代理 — AppLocalizations + Delegate / 번역 프록시
│   │   ├── ty_app_localizations_zh.dart   #   中文翻译 (~300+ key) / 중국어 번역
│   │   ├── ty_app_localizations_en.dart   #   英文翻译 / 영어 번역
│   │   └── ty_app_localizations_ko.dart   #   韩文翻译 / 한국어 번역
│   │
│   ├── proxy/                             # 🔧 AI 代理服务器（独立 Dart 进程） / AI 프록시 서버 (독립 Dart 프로세스)
│   │   ├── server.dart                    #   Shelf HTTP 代理 — 转发请求 + 注入 API Key / Shelf HTTP 프록시 — 요청 전달 + API 키 주입
│   │   ├── config.dart                    #   DeepSeek API Key + 端口配置 / DeepSeek API 키 + 포트 설정
│   │   └── pubspec.yaml                   #   依赖: shelf, shelf_cors_headers / 의존성: shelf, shelf_cors_headers
│   │
│   ├── designs/                           # 🎨 UI 设计稿（静态 HTML） / UI 디자인 시안 (정적 HTML)
│   │   └── taiyuan_design/
│   │       ├── taiyuan_app_complete_v4.html    # 完整 App 设计 v4 / 완전한 앱 디자인 v4
│   │       ├── taiyuan_app_complete_v3.html    # 完整 App 设计 v3 / 완전한 앱 디자인 v3
│   │       ├── taiyuan_travel_ui_v2.html       # 旅行 UI 设计 v2 / 여행 UI 디자인 v2
│   │       ├── taiyuan_page1_with_ai.html      # 带 AI 助手的页面设计 / AI 도우미 포함 페이지 디자인
│   │       ├── ui_design_v1.html               # UI 设计初版 / UI 디자인 초판
│   │       ├── ai_planning_v1.html             # AI 功能规划 / AI 기능 기획
│   │       ├── language_switcher_sketch.html   # 语言切换器原型 / 언어 전환기 프로토타입
│   │       └── visual_enhance.html             # 视觉增强示意 / 시각적 개선 예시
│   │
│   └── docs/                              # 📝 文档 / 문서
│       └── taiyuan/
│           ├── project_structure.md        #   本文档 / 본 문서
│           ├── REQUIREMENTS.md             #   需求文档 / 요구사항 문서
│           └── TECHNICAL.md                #   技术文档 / 기술 문서
│
├── beijing/                               # 🏛️ 北京模块（其他成员） / 베이징 모듈 (다른 팀원)
│   ├── beijing_entry.dart
│   ├── screens/
│   ├── services/
│   ├── utils/
│   └── widgets/
│
├── linyi/                                 # 🌾 临沂模块（待开发） / 린이 모듈 (개발 예정)
│
assets/
└── videos/
    ├── taiyuan.mp4                        # 太原宣传片（~17MB） / 타이위안 홍보 영상
    ├── beijing.mp4                        # 北京宣传片（~20MB） / 베이징 홍보 영상
    └── linyi.mp4                          # 临沂宣传片（~13MB） / 린이 홍보 영상
```

---

## 三、架构分层 / 3. 아키텍처 계층

```
┌────────────────────┐
│     main.dart      │  入口层 — 城市选择首页 + 6 城市卡片（视频背景）
│                    │  진입 계층 — 도시 선택 홈 + 6개 도시 카드 (영상 배경)
├────────────────────┤
│    ty_app.dart     │  框架层 — MaterialApp、三语注册、全局主题
│                    │  프레임워크 계층 — MaterialApp, 3개 언어 등록, 전역 테마
├────────────────────┤
│  ty_city_page.dart │  页面层 — 通用城市页框架（Hero + Tab + PageView + 🌐按钮）
│                    │  페이지 계층 — 공통 도시 페이지 프레임워크
├────────────────────┤
│   shared/          │  组件层 — 15+ 可复用 Widget，通过参数驱动
│                    │  컴포넌트 계층 — 15개+ 재사용 가능한 위젯, 매개변수로 구동
├────────────────────┤
│   structure/       │  组装层 — 太原 4 个 Tab 页面 + Hero 背景配置
│                    │  조립 계층 — 타이위안 4개 탭 페이지 + 히어로 배경 설정
├────────────────────┤
│   l10n/            │  翻译层 — key-value 文本映射表，3 语言支持
│                    │  번역 계층 — 키-값 텍스트 매핑 테이블, 3개 언어 지원
└────────────────────┘
```

**核心设计思想 / 핵심 설계 사상**：`shared/` 中的组件**不含任何城市专属数据**，所有内容通过 l10n key 引用和构造函数参数传入。新增城市只需编写 `structure/` 层和追加翻译 key。

`shared/`의 컴포넌트는 **어떠한 도시 전용 데이터도 포함하지 않으며**, 모든 콘텐츠는 l10n 키 참조와 생성자 매개변수를 통해 전달됩니다. 새 도시를 추가할 때는 `structure/` 계층만 작성하고 번역 키만 추가하면 됩니다.

---

## 四、模块详解 / 4. 모듈 상세 설명

### 4.1 入口层 / 진입 계층 — [main.dart](lib/main.dart)

| 项目 / 항목 | 说明 / 설명 |
|-------------|-------------|
| 启动函数 / 시작 함수 | `main() => runApp(const TaiyuanApp())` |
| 首页组件 / 홈 컴포넌트 | `TyHomePage` — 城市选择首页 / 도시 선택 홈 |
| 头部 / 헤더 | "我和我的家乡 / 나와 나의 고향" 居中标题 / 중앙 정렬 제목 |
| 城市卡片 / 도시 카드 | 6 个卡片（太原/北京/临沂/温州/哈尔滨/其他），视频背景 / 6개 카드, 영상 배경 |
| 导航逻辑 / 내비게이션 로직 | 太原 → `TaiyuanCityPage`，北京 → `BeijingEntry` |

### 4.2 App 壳 / 앱 셸 — [ty_app.dart](lib/taiyuan/ty_app.dart)

| 项目 / 항목 | 说明 / 설명 |
|-------------|-------------|
| 类名 / 클래스명 | `MyApp`（StatefulWidget） |
| 默认语言 / 기본 언어 | 韩语 (`ko`)，可通过 `🌐` 按钮切换 / 한국어, `🌐` 버튼으로 전환 가능 |
| 支持语言 / 지원 언어 | `zh` / `en` / `ko` |
| 主题 / 테마 | Material 3，`seedColor: AppColors.red`（砖红 / 벽돌 붉은색） |
| 静态方法 / 정적 메서드 | `MyApp.setLocale(context, locale)` 全局切换语言 / 전역 언어 전환 |

### 4.3 太原 App 包装 / 타이위안 앱 래퍼 — [ty_taiyuan_app.dart](lib/taiyuan/ty_taiyuan_app.dart)

```dart
class TaiyuanApp extends StatelessWidget {
  const TaiyuanApp();
  Widget build(BuildContext context) => const MyApp(home: TyHomePage());
}
```

### 4.4 城市页框架 / 도시 페이지 프레임워크 — [ty_city_page.dart](lib/taiyuan/ty_city_page.dart)

通用城市页面框架，是 `shared/` 与 `structure/` 的**组装中枢**。

공통 도시 페이지 프레임워크이며, `shared/`와 `structure/`의 **조립 중추**입니다.

| 组件区域 / 컴포넌트 영역 | 说明 / 설명 |
|--------------------------|-------------|
| `CityHeroHeader` | 顶部 Hero — 省份标签 + 城市名 + 副标题 + Tab 对应 emoji / 상단 히어로 — 성 라벨 + 도시명 + 부제목 + 탭별 이모지 |
| `CityTabRow` | Tab 栏 — 4 个 Tab（介绍/景点/美食/路线）+ 红色滑动指示器 / 탭 바 — 4개 탭 (소개/명소/음식/코스) + 붉은색 슬라이딩 인디케이터 |
| `PageView` | 内容区 — 左右滑动切换 Tab，`AnimatedSwitcher` 过渡动画 / 콘텐츠 영역 — 좌우 스와이프로 탭 전환, 애니메이션 전환 |
| `🌐 语言按钮 / 언어 버튼` | 可拖动位置的圆形按钮，点击弹出语言选择面板 / 드래그 가능한 원형 버튼, 클릭 시 언어 선택 패널 |
| `activeTab` | 静态 `ValueNotifier<int>` — 跨 Tab 通知（控制视频播放） / 정적 ValueNotifier — 탭 간 알림 (영상 재생 제어) |

**构造参数 / 생성자 매개변수**：
```dart
CityPage(
  tabs: [...],              // 4 个 Tab Widget / 4개 탭 위젯
  heroBackgrounds: [...],    // 每个 Tab 对应的 (颜色, emoji) / 각 탭별 (색상, 이모지)
  provinceKey: 'heroProvince',  // l10n key 覆盖 / l10n 키 오버라이드
  cityKey: 'heroCityName',
  subtitleKey: 'heroSubtitle',
)
```

### 4.5 共享组件层 / 공유 컴포넌트 계층 — [shared/](lib/taiyuan/shared/)

#### 4.5.1 色系 / 색상 — [ty_colors.dart](lib/taiyuan/shared/ty_colors.dart)

| 类别 / 분류 | 颜色 / 색상 | 色值 / 색상값 | 用途 / 용도 |
|-------------|------------|--------------|------------|
| 背景 / 배경 | `bg` | `#F2EDE4` | 米白·宣纸底 / 쌀베이지·선지 바탕 |
| 卡片 / 카드 | `bgCard` | `#FFFFFF` | 卡片白 / 카드 흰색 |
| 暖卡 / 웜 카드 | `bgCard2` | `#F8F3EC` | 暖卡片底 / 따뜻한 카드 배경 |
| 标题文字 / 제목 텍스트 | `ink` | `#1E1810` | 古建深墨 / 고건축 짙은 먹색 |
| 正文 / 본문 | `ink2` | `#3D3528` | 次级墨 / 보조 먹색 |
| 辅助文字 / 보조 텍스트 | `ink3` | `#5E5248` | 辅助文字 / 보조 문자 |
| 标签 / 라벨 | `ink4` | `#6E6256` | 小字标签 / 작은 글씨 라벨 |
| 主强调 / 주강조 | `red` | `#B84C2E` | 晋砖红 / 진 붉은 벽돌색 |
| 亮强调 / 밝은 강조 | `red2` | `#D4613C` | 亮砖红 / 밝은 벽돌색 |
| 次强调 / 부강조 | `gold` | `#9B7A3A` | 晋商铜金 / 진상인 구리 금색 |
| 亮金 / 밝은 금색 | `gold2` | `#C4A04E` | 亮金 / 밝은 금색 |
| 边框 / 테두리 | `border` / `border2` | 10%/6% 墨 | 边框 / 테두리 |
| 金色边框 / 금색 테두리 | `goldBorder` | 28% 金 | 金色边框 / 금색 테두리 |
| 金色底 / 금색 배경 | `goldBg` | 10% 金 | 金色半透明底 / 금색 반투명 배경 |
| 红色底 / 붉은색 배경 | `redBg` | 10% 红 | 红色半透明底 / 붉은색 반투명 배경 |
| 阴影 / 그림자 | `shadowLight` / `shadowMid` | 8%/12% 墨 | 卡片阴影 / 카드 그림자 |

#### 4.5.2 通用 Widget / 공통 위젯 — [ty_widgets.dart](lib/taiyuan/shared/ty_widgets.dart)

提供 **15+ 可复用组件** / **15개 이상의 재사용 가능한 컴포넌트**：

| 组件 / 컴포넌트 | 用途 / 용도 |
|----------------|-------------|
| `cardDecoration()` | 白色卡片 + 阴影 + 细边框装饰函数 / 흰색 카드 + 그림자 + 얇은 테두리 데코레이션 함수 |
| `AccentPill` / `GoldPill` | 金色强调标签 / 금색 강조 라벨 |
| `DimPill` | 灰色弱标签 / 회색 약라벨 |
| `SectionTitle` | 区块标题文字 / 섹션 제목 텍스트 |
| `StatTile` | 单个统计数据卡片 / 단일 통계 데이터 카드 |
| `StatsRow` | 三个统计卡片横排 / 3개 통계 카드 가로 배치 |
| `InfoTile` | 信息展示卡片（标签+值） / 정보 표시 카드 (라벨+값) |
| `InfoGrid` | 2 列信息网格 / 2열 정보 그리드 |
| `TextBlock` | 白色卡片文本块 / 흰색 카드 텍스트 블록 |
| `HapticTap` | 带触觉反馈的点击包装器 / 햅틱 피드백 포함 탭 래퍼 |
| `PlaceholderImage` | emoji 渐变占位图 / 이모지 그라데이션 플레이스홀더 |
| `SpotCard` | 景点卡片（横向滚动） — 130px 宽 / 명소 카드 (가로 스크롤) — 130px 너비 |
| `FoodCard` | 美食卡片（网格） — 含热度点动画 / 음식 카드 (그리드) — 인기 점수 애니메이션 포함 |
| `RouteStepDot` | 路线步骤编号圆圈 / 코스 단계 번호 원 |
| `DashedLine` | 时间线虚线 / 타임라인 점선 |

#### 4.5.3 Hero 头部 / 히어로 헤더 — [ty_hero_header.dart](lib/taiyuan/shared/ty_hero_header.dart)

- 基于设计稿 260px 基准等比缩放（`screenW / 260`） / 디자인 시안 260px 기준 비례 스케일링
- 左侧：省份 Pill 标签 + 城市名（大字）+ 副标题 / 왼쪽: 성 필 라벨 + 도시명 (큰 글씨) + 부제목
- 右侧：大号 emoji 图标（可点击唤起 AI 助手） / 오른쪽: 큰 이모지 아이콘 (클릭 시 AI 도우미 호출)
- 每个 Tab 对应不同 color + emoji，切换时 `AnimatedContainer` 过渡 / 각 탭별 다른 색상 + 이모지, 전환 시 부드러운 애니메이션

#### 4.5.4 Tab 栏 / 탭 바 — [ty_tab_row.dart](lib/taiyuan/shared/ty_tab_row.dart)

- 非激活 Tab 颜色：`#A89E90`（浅灰棕） / 비활성 탭 색상: 연한 회갈색
- 激活 Tab：砖红色 + Bold / 활성 탭: 벽돌 붉은색 + Bold
- 红色指示条跟随 `PageController.page` 实时滑动 / 붉은색 인디케이터 바가 PageController.page를 따라 실시간 슬라이딩
- 底部细分隔线 / 하단 미세 구분선

#### 4.5.5 详情弹窗 / 상세 하단 시트 — [ty_detail_sheet.dart](lib/taiyuan/shared/ty_detail_sheet.dart)

- 景点和美食共用 `_DetailSheet` 组件 / 명소와 음식이 `_DetailSheet` 컴포넌트를 공유
- 通过 l10n key 前缀自动查找对应翻译 / l10n 키 접두사로 자동 번역 검색：
  - `showSpotDetail(c, 'spotJinci', '🏯')` → 查找 `spotJinci` / `spotJinciDesc` / `spotJinciHours` / `spotJinciLoc` / `spotJinciTip`
  - `showFoodDetail(c, 'foodDaoxiao', '🍜')` → 查找 `foodDaoxiao` / `foodDaoxiaoDesc` / `foodDaoxiaoRec` / `foodDaoxiaoPrice`
- 布局：emoji 图标 → 标题 → 描述文本 → 行信息（图标 + 标签 + 内容） / 레이아웃: 이모지 아이콘 → 제목 → 설명 텍스트 → 행 정보 (아이콘 + 라벨 + 내용)

#### 4.5.6 语言切换 / 언어 전환 — [ty_lang_sheet.dart](lib/taiyuan/shared/ty_lang_sheet.dart)

- 底部弹出面板 / 하단 팝업 패널
- 三个选项：🇨🇳 中文 / 🇺🇸 English / 🇰🇷 한국어
- 当前语言高亮（金色边框 + 勾选图标） / 현재 언어 하이라이트 (금색 테두리 + 체크 아이콘)
- 选中后通过 `MyApp.setLocale()` 全局切换 / 선택 후 `MyApp.setLocale()`로 전역 전환

#### 4.5.7 AI 旅行助手 / AI 여행 도우미 — [ty_ai_assistant_sheet.dart](lib/taiyuan/shared/ty_ai_assistant_sheet.dart)

- **唤起方式 / 호출 방법**：点击 CityHeroHeader 右侧 emoji 图标 / CityHeroHeader 오른쪽 이모지 아이콘 클릭
- **弹窗高度 / 팝업 높이**：屏幕 78%（最大 560px，最小 360px） / 화면의 78% (최대 560px, 최소 360px)
- **交互流程 / 인터랙션 흐름**：
  1. 显示问候语（三语） / 인사말 표시 (3개 언어)
  2. 4 个快捷操作按钮（美食推荐/景点介绍/城市历史/旅行路线） / 4개 빠른 동작 버튼 (음식 추천/명소 소개/도시 역사/여행 코스)
  3. 用户输入问题 → 流式输出回复（打字机效果） / 사용자 질문 입력 → 스트리밍 답변 출력 (타자기 효과)
  4. 加载中显示动画点 / 로딩 중 애니메이션 점 표시
  5. 错误时显示红色提示条（可关闭） / 오류 시 붉은색 알림 바 표시 (닫기 가능)
- **UI 组件 / UI 컴포넌트**：`_MessageRow`（用户/AI 气泡 / 사용자/AI 말풍선）、`_Avatar`、`_ActionChip`、`_LoadingDots`

#### 4.5.8 AI API 服务 / AI API 서비스 — [ty_ai_service.dart](lib/taiyuan/shared/ty_ai_service.dart)

| 项目 / 항목 | 说明 / 설명 |
|-------------|-------------|
| 流式聊天 / 스트리밍 채팅 | `chatStream(messages)` → `Stream<String>`（SSE 解析 / SSE 파싱） |
| 非流式 / 비스트리밍 | `chat(messages)` → `Future<String>` |
| 请求格式 / 요청 형식 | OpenAI-compatible，自动注入 system prompt / OpenAI 호환, 시스템 프롬프트 자동 주입 |
| 模型 / 모델 | `deepseek-chat` |
| 参数 / 매개변수 | `temperature: 0.7`, `max_tokens: 2000` |
| 代理地址 / 프록시 주소 | Android 模拟器 `10.0.2.2:8080`，其他 `localhost:8080` / Android 에뮬레이터, 기타 |
| 异常类型 / 예외 타입 | `TyAiException`（超时/网络/API 错误三语提示 / 타임아웃/네트워크/API 오류 3개 언어 안내） |

#### 4.5.9 AI 配置 / AI 설정 — [ty_ai_config.dart](lib/taiyuan/shared/ty_ai_config.dart)

- 三语系统提示词（中文/英文/韩文） / 3개 언어 시스템 프롬프트 (중국어/영어/한국어)
- 每种语言提示词涵盖：美食介绍、景点介绍、历史文化、路线推荐 / 각 언어 프롬프트 커버: 음식 소개, 명소 소개, 역사 문화, 코스 추천
- 约束：简洁友好、不透露 AI 身份、适当 emoji / 제약: 간결하고 친근하게, AI 신분 노출 금지, 적절한 이모지 사용

### 4.6 太原专属内容 / 타이위안 전용 콘텐츠 — [structure/](lib/taiyuan/structure/)

#### 4.6.1 城市页入口 / 도시 페이지 진입점 — [ty_taiyuan_city_page.dart](lib/taiyuan/structure/ty_taiyuan_city_page.dart)

```dart
class TaiyuanCityPage extends StatelessWidget {
  static const _heroBg = [
    (color: Color(0xFF1a1028), emoji: '🏯'),  // 介绍 — 古城 / 소개 — 고성
    (color: Color(0xFF0f1a14), emoji: '🌲'),  // 景点 — 自然 / 명소 — 자연
    (color: Color(0xFF1a0d08), emoji: '🍲'),  // 美食 — 暖色 / 음식 — 따뜻한 색
    (color: Color(0xFF081420), emoji: '🗺️'),  // 路线 — 地图 / 코스 — 지도
  ];
  // 组装: CityPage(tabs: [TaiyuanIntroTab, ..., TaiyuanRoutesTab], heroBackgrounds: _heroBg)
}
```

#### 4.6.2 介绍 Tab / 소개 탭 — [ty_taiyuan_intro.dart](lib/taiyuan/structure/ty_taiyuan_intro.dart)

**内容布局（垂直滚动列表） / 콘텐츠 레이아웃 (세로 스크롤 리스트)**：

| 板块 / 섹션 | 组件 / 컴포넌트 | 内容 / 콘텐츠 |
|------------|---------------|-------------|
| 城市视频 / 도시 영상 | `_VideoCard` | 循环播放 `taiyuan.mp4`，支持暂停/全屏/横屏 / 반복 재생, 일시정지/전체화면/가로모드 지원 |
| 数据统计 / 데이터 통계 | `StatsRow` | 人口 551万 / 역사 2500+년 / 명소 4A+ |
| 城市简介 / 도시 소개 | `TextBlock` | 太原概述文本 / 타이위안 개요 텍스트 |
| 城市标签 / 도시 태그 | `Wrap` | 6 个标签（国家历史文化名城/龙城/晋阳古都/...） / 6개 태그 |
| 气候信息 / 기후 정보 | `InfoGrid` | 最佳季节 5-6月·9-10月 / 연평균 기온 ~9.5°C |
| 历史沿革 / 역사 연혁 | `SectionTitle` + `TextBlock` | 2500+ 年建城史 / 2500년+ 도시 역사 |
| 气候特征 / 기후 특징 | `SectionTitle` + `TextBlock` | 暖温带大陆性季风气候 / 온대 대륙성 계절풍 기후 |
| 面食文化 / 면식 문화 | `SectionTitle` + `TextBlock` | 280+ 种面食 / 280종+ 면요리 |
| 交通贴士 / 교통 팁 | `SectionTitle` + `TextBlock` | 机场/高铁/地铁/公交 / 공항/고속철/지하철/버스 |

**视频功能 / 영상 기능**：
- 自动循环播放，静音 / 자동 반복 재생, 음소거
- 底部覆盖层：播放/暂停按钮 + "锦绣太原" 标题 + 全屏按钮 / 하단 오버레이: 재생/일시정지 버튼 + "锦绣太原" 제목 + 전체화면 버튼
- 暂停时中心显示大播放按钮 / 일시정지 시 중앙에 큰 재생 버튼 표시
- 全屏模式支持：横竖屏切换、进度条拖拽、3 秒自动隐藏控件 / 전체화면 모드: 가로/세로 전환, 진행 바 드래그, 3초 후 자동 컨트롤 숨김
- 切换到其他 Tab 时自动暂停（通过 `CityPage.activeTab` ValueNotifier） / 다른 탭 전환 시 자동 일시정지

#### 4.6.3 景点 Tab / 명소 탭 — [ty_taiyuan_spots.dart](lib/taiyuan/structure/ty_taiyuan_spots.dart)

| 区域 / 영역 | 布局 / 레이아웃 | 数量 / 개수 | 内容 / 콘텐츠 |
|------------|---------------|-----------|-------------|
| 热门景点 / 인기 명소 | 横向滚动卡片 / 가로 스크롤 카드 | 6 个 / 6개 | 晋祠(5A·¥80)、山西博物院(4A·免费/무료)、永祚寺双塔(4A·¥35)、蒙山大佛(4A·¥50)、中国煤炭博物馆(4A·¥60)、崛围山(免费/무료) |
| 城市景观 / 도시 경관 | 竖向列表 / 세로 리스트 | 7 个 / 7개 | 天龙山石窟(4.6)、汾河公园(4.5)、柳巷·钟楼街(4.7)、晋阳湖公园(4.4)、山西民俗博物馆(4.5)、太山龙泉寺(4.6)、太原植物园(4.7) |

- 点击任一景点 → `showSpotDetail()` 弹出详情底弹窗 / 아무 명소 클릭 → 상세 하단 시트 팝업
- 详情包含：描述、开放时间、地址、游玩建议 / 상세 내용: 설명, 운영 시간, 주소, 관광 팁
- `HapticTap` 触觉反馈 / 햅틱 피드백

#### 4.6.4 美食 Tab / 음식 탭 — [ty_taiyuan_food.dart](lib/taiyuan/structure/ty_taiyuan_food.dart)

| 布局 / 레이아웃 | 数量 / 개수 | 内容 / 콘텐츠 |
|---------------|-----------|-------------|
| 2 列网格 / 2열 그리드 | 10 道 / 10가지 | 刀削面/도삭면、过油肉/궈유러우、头脑/두뇌탕、羊杂割/양자거、剔尖/티젠、莜面栲栳栳/유면 카오라오라오、糖醋丸子/탕추완쯔、太原酱肉/타이위안 장러우、太原老豆腐/타이위안 라오더우푸、猫耳朵/마오얼둬 |

- 每张卡片：`PlaceholderImage`（emoji 渐变） + 名称 + 副标题 + 热度评分（1-5 星动画） / 각 카드: 이모지 그라데이션 + 이름 + 부제목 + 인기 점수 (1-5성 애니메이션)
- 热度动画：星星逐个淡入 + 缩放 / 인기 애니메이션: 별이 하나씩 페이드인 + 스케일
- 点击 → `showFoodDetail()` 弹出详情底弹窗（描述 + 推荐店铺 + 人均价格） / 클릭 → 상세 하단 시트 (설명 + 추천 맛집 + 1인당 가격)

#### 4.6.5 路线 Tab / 코스 탭 — [ty_taiyuan_routes.dart](lib/taiyuan/structure/ty_taiyuan_routes.dart)

**5 条主题路线（水平 Chip 切换器 + 垂直内容区） / 5개 테마 코스 (가로 Chip 전환기 + 세로 콘텐츠 영역)**：

| 路线 / 코스 | 天数 / 일수 | 打卡点 / 체크포인트 | 预算 / 예산 | 主题 / 테마 |
|------------|-----------|-----------------|----------|-----------|
| 龙城印象 / 용성 인상 | 1天 / 1일 | 3处 / 3곳 | ¥150 | 博物院→双塔→汾河日落 / 박물관→쌍탑→펀허 석양 |
| 古建寻踪 / 고건축 탐방 | 1天 / 1일 | 3处 / 3곳 | ¥200 | 晋祠→天龙山石窟→太山龙泉寺 / 진치사→톈룽산 석굴→타이산 룽취안사 |
| 太原味道 / 타이위안 맛기행 | 半天 / 반나절 | 5种 / 5가지 | ¥120 | 头脑→刀削面→六味斋→羊杂割 / 두뇌탕→도삭면→류웨이자이→양자거 |
| 亲子探索 / 가족 탐험 | 1天 / 1일 | 3处 / 3곳 | ¥250 | 煤炭博物馆→植物园→晋阳湖公园 / 석탄 박물관→식물원→진양후 공원 |
| 山水之间 / 산수 사이 | 1天 / 1일 | 3处 / 3곳 | ¥120 | 蒙山大佛→崛围山→汾河晚渡 / 멍산 대불→줴웨이산→펀허 야경 |

**每条路线包含 / 각 코스 포함 내용**：
- 时间线步骤（可展开/折叠，带动画） / 타임라인 단계 (확장/접기 가능, 애니메이션 포함)
- 每步：步骤编号 + 时间 + 标题 + 描述 + 展开后显示交通方式 + 贴士 / 각 단계: 단계 번호 + 시간 + 제목 + 설명 + 확장 시 교통수단 + 팁
- 底部统计：天数 / 打卡点 / 预算 / 하단 통계: 일수 / 체크포인트 / 예산
- 📋 复制路线按钮 — 一键复制到剪贴板 / 📋 코스 복사 버튼 — 클릭 한 번으로 클립보드에 복사

### 4.7 国际化 / 국제화 — [l10n/](lib/taiyuan/l10n/)

| 文件 / 파일 | 行数 / 라인 | 说明 / 설명 |
|------------|-----------|-------------|
| `ty_app_localizations.dart` | 70 | 翻译代理类 + `LocalizationsDelegate` / 번역 프록시 클래스 |
| `ty_app_localizations_zh.dart` | ~385 | 中文翻译 (~300+ key) / 중국어 번역 |
| `ty_app_localizations_en.dart` | ~385 | 英文翻译 / 영어 번역 |
| `ty_app_localizations_ko.dart` | ~385 | 韩文翻译 / 한국어 번역 |

**核心 API / 핵심 API**：
```dart
final l10n = AppLocalizations.of(context);
l10n['spotJinci']        // → "晋祠" / "Jinci Temple" / "진츠 사원"
l10n['foodDaoxiaoDesc']  // → 中文长描述 / 영어 설명 / 한국어 설명
```

**翻译 Key 命名规范 / 번역 키 네이밍 규칙**：
- 通用键 / 공통 키：`tab*`, `hero*`, `stat*`, `nav*`, `lang*`, `detail*`, `ai*`
- 景点键 / 명소 키：`spot<Name>` / `spot<Name>Desc` / `spot<Name>Hours` / `spot<Name>Loc` / `spot<Name>Tip`
- 美食键 / 음식 키：`food<Name>` / `food<Name>Sub` / `food<Name>Desc` / `food<Name>Rec` / `food<Name>Price`
- 路线键 / 코스 키：`route*`, `route<N>*`

### 4.8 AI 代理服务器 / AI 프록시 서버 — [proxy/](lib/taiyuan/proxy/)

独立的 Dart 进程，作为 Flutter App 和 DeepSeek API 之间的中间层。

독립적인 Dart 프로세스로, Flutter 앱과 DeepSeek API 사이의 중간 계층 역할을 합니다.

```
Flutter App  →  proxy (:8080)  →  DeepSeek API (api.deepseek.com)
                   ↑
            注入 API Key / API 키 주입
```

| 文件 / 파일 | 说明 / 설명 |
|------------|-------------|
| `server.dart` | Shelf HTTP 服务器，路由分发、CORS、SSE 流式透传 / Shelf HTTP 서버, 라우팅, CORS, SSE 스트리밍 전달 |
| `config.dart` | DeepSeek API Key、Base URL、监听端口 / DeepSeek API 키, 기본 URL, 수신 포트 |
| `pubspec.yaml` | 依赖: shelf, shelf_router, shelf_cors_headers / 의존성 |

**端点 / 엔드포인트**：
- `GET /health` → 健康检查 / 헬스 체크
- `POST /v1/chat/completions` → OpenAI-compatible 聊天补全（支持流式 SSE） / OpenAI 호환 채팅 완성 (SSE 스트리밍 지원)

**启动 / 실행**：`cd proxy && dart run lib/server.dart`

### 4.9 设计稿 / 디자인 시안 — [designs/](lib/taiyuan/designs/)

8 个 HTML 设计稿文件，记录从 v1 到 v4 的 UI 迭代过程。

8개의 HTML 디자인 시안 파일, v1부터 v4까지의 UI 반복 과정을 기록합니다.

| 文件 / 파일 | 说明 / 설명 |
|------------|-------------|
| `ui_design_v1.html` | 初版 UI 设计 / 초판 UI 디자인 |
| `taiyuan_travel_ui_v2.html` | v2 旅行 UI / v2 여행 UI |
| `taiyuan_app_complete_v3.html` | v3 完整设计 / v3 완전한 디자인 |
| `taiyuan_app_complete_v4.html` | v4 最终设计（当前实现参考） / v4 최종 디자인 (현재 구현 참조) |
| `taiyuan_page1_with_ai.html` | AI 助手集成设计 / AI 도우미 통합 디자인 |
| `ai_planning_v1.html` | AI 功能规划 / AI 기능 기획 |
| `language_switcher_sketch.html` | 语言切换器原型 / 언어 전환기 프로토타입 |
| `visual_enhance.html` | 视觉增强示意 / 시각적 개선 예시 |

### 4.10 资源文件 / 리소스 파일

| 路径 / 경로 | 大小 / 크기 | 用途 / 용도 |
|------------|-----------|-------------|
| `assets/videos/taiyuan.mp4` | ~17MB | 太原宣传片（首页卡片 + 介绍 Tab） / 타이위안 홍보 영상 (홈 카드 + 소개 탭) |
| `assets/videos/beijing.mp4` | ~20MB | 北京宣传片 / 베이징 홍보 영상 |
| `assets/videos/linyi.mp4` | ~13MB | 临沂宣传片 / 린이 홍보 영상 |

---

## 五、数据流 / 5. 데이터 흐름

### 5.1 页面加载流程 / 페이지 로딩 흐름

```
main()
  └─ runApp(TaiyuanApp())
       └─ MyApp(home: TyHomePage())
            └─ 城市选择首页（6 个城市卡片） / 도시 선택 홈 (6개 도시 카드)
                 └─ 点击"太原" → Navigator.push → TaiyuanCityPage() / "타이위안" 클릭
                      └─ CityPage(tabs: [...], heroBackgrounds: [...])
                           ├─ CityHeroHeader  ← 从 l10n 读取标题 / l10n에서 제목 읽기
                           ├─ CityTabRow      ← 4 个 Tab 标签 / 4개 탭 라벨
                           └─ PageView
                                ├─ TaiyuanIntroTab  ← 读取 l10n + 视频 / l10n 읽기 + 영상
                                ├─ TaiyuanSpotsTab  ← 读取 l10n / l10n 읽기
                                ├─ TaiyuanFoodTab   ← 读取 l10n / l10n 읽기
                                └─ TaiyuanRoutesTab ← 读取 l10n / l10n 읽기
```

### 5.2 国际化切换流程 / 언어 전환 흐름

```
点击 🌐 → showLangSheet() / 🌐 클릭
  └─ 选择语言 → MyApp.setLocale(ctx, Locale('zh')) / 언어 선택
       └─ _MyAppState.setState() → 重建 MaterialApp / MaterialApp 재빌드
            └─ 所有 Widget rebuild → AppLocalizations.of() 返回新语言文本 / 모든 위젯 재빌드 → 새 언어 텍스트 반환
```

### 5.3 AI 对话流程 / AI 대화 흐름

```
点击 emoji 图标 → showTyAiAssistantSheet() / 이모지 아이콘 클릭
  └─ 创建 TyAiService(lang: 'zh') / TyAiService 생성
  └─ 显示问候语 / 인사말 표시
  └─ 用户输入 → _sendMessage() / 사용자 입력
       └─ TyAiService.chatStream(messages)
            └─ HTTP POST → proxy (:8080)
                 └─ 注入 API Key → DeepSeek API / API 키 주입
                      └─ SSE 流式返回 → 逐字更新 UI / SSE 스트리밍 반환 → 한 글자씩 UI 업데이트
```

---

## 六、关键设计模式 / 6. 핵심 설계 패턴

### 6.1 l10n Key 驱动的内容系统 / l10n 키 기반 콘텐츠 시스템

所有文本内容通过 l10n key 引用，组件**零硬编码中文** / 모든 텍스트 콘텐츠는 l10n 키로 참조되며, 컴포넌트에 **중국어 하드코딩이 전혀 없습니다**：

```dart
Text(l10n['spotJinci'])  // 根据当前语言返回 "晋祠" / "Jinci Temple" / "진츠 사원"
```

### 6.2 详情弹窗 Key 前缀约定 / 상세 하단 시트 키 접두사 규칙

```dart
showSpotDetail(c, 'spotJinci', '🏯');
// → 自动查找: spotJinci / spotJinciDesc / spotJinciHours / spotJinciLoc / spotJinciTip
showFoodDetail(c, 'foodDaoxiao', '🍜');
// → 自动查找: foodDaoxiao / foodDaoxiaoDesc / foodDaoxiaoRec / foodDaoxiaoPrice
```

### 6.3 PageView + Tab 联动 / PageView + Tab 연동

```
PageController.page 变化 / 페이지 변경
  ├─ → setState(_tab) → Tab 栏样式更新 / 탭 바 스타일 업데이트
  ├─ → AnimatedContainer → Hero 背景过渡 / 히어로 배경 전환
  └─ → CityPage.activeTab.value → 视频暂停/播放控制 / 영상 일시정지/재생 제어
```

### 6.4 等比缩放布局 / 비례 스케일링 레이아웃

Hero 头部基于设计稿 260px 宽等比缩放（`scale = screenW / 260`），确保不同屏幕尺寸下比例一致。

히어로 헤더는 디자인 시안 260px 너비 기준으로 비례 스케일링되어, 다양한 화면 크기에서 일관된 비율을 유지합니다.

---

## 七、新增城市指南 / 7. 새 도시 추가 가이드

以添加"成都"为例 / "청두" 추가 예시：

1. 创建 `lib/taiyuan/structure/ty_chengdu_*.dart`（4 个 Tab 文件） / 4개 탭 파일 생성
2. 编写 `ChengduCityPage` 组装 Tab 和 Hero 背景 / Tab과 Hero 배경 조립
3. 在 3 个 `ty_app_localizations_*.dart` 中追加成都翻译 key / 3개 언어 파일에 청두 번역 키 추가
4. 在 `main.dart` 中添加成都入口（可选） / main.dart에 청두 진입점 추가 (선택)
5. 添加成都视频到 `assets/videos/` / 청두 영상 추가

---

## 八、依赖清单 / 8. 의존성 목록

**Flutter 端 / Flutter 측** (`pubspec.yaml`):

| 依赖 / 의존성 | 版本 / 버전 | 用途 / 용도 |
|-------------|-----------|-------------|
| `video_player` | - | 城市视频播放 / 도시 영상 재생 |
| `flutter_localizations` | SDK | Material 组件国际化 / Material 컴포넌트 국제화 |
| `http` | - | AI 服务 HTTP 请求 / AI 서비스 HTTP 요청 |

**代理服务器 / 프록시 서버** (`proxy/pubspec.yaml`):

| 依赖 / 의존성 | 版本 / 버전 | 用途 / 용도 |
|-------------|-----------|-------------|
| `shelf` | ^1.4.0 | HTTP 服务器框架 / HTTP 서버 프레임워크 |
| `shelf_router` | ^1.1.0 | 路由分发 / 라우팅 분배 |
| `shelf_cors_headers` | ^0.1.5 | CORS 跨域支持 / CORS 크로스 도메인 지원 |

---

> 📝 文档维护 / 문서 관리: testerwm | 更新 / 업데이트: 2026-06-11

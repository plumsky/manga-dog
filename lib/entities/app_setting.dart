import 'package:objectbox/objectbox.dart';

// 枚举定义
enum ReaderViewMode { single, double, webtoon }
enum ZoomMode { fitWidth, fitHeight, original, custom }
enum TranslationFontStyle { comic, normal, bold, italic }

// 1. AppSettings 实体
@Entity()
class AppSetting {
  @Id(assignable: true)  // assignable: true 允许我们设置id为1
  int id = 1;  // 固定为1，因为只需要一个全局配置

  int themeModeIndex = 0;
  String language = 'zh-CN';
  bool firstLaunch = true;

  int viewMode = ReaderViewMode.single.index;
  int zoomMode = ZoomMode.fitWidth.index;
  bool autoHideControls = true;
  bool enablePageTurnAnimation = true;

  String sourceLanguage = 'auto';
  String targetLanguage = 'zh-CN';
  String translationEngine = 'google';
  bool enableAutoTranslate = false;
  bool enableOCR = true;
  int fontStyle = TranslationFontStyle.comic.index;
  int fontSize = 16;
  String fontColor = '#000000';

  double windowWidth = 1280.0;
  double windowHeight = 720.0;
  bool isMaximized = false;
  String? lastOpenedFolder;

  List<String> recentFolders = [];

  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  // 获取枚举值的方法
  ReaderViewMode get viewModeEnum => ReaderViewMode.values[viewMode];
  set viewModeEnum(ReaderViewMode mode) => viewMode = mode.index;

  ZoomMode get zoomModeEnum => ZoomMode.values[zoomMode];
  set zoomModeEnum(ZoomMode mode) => zoomMode = mode.index;

  TranslationFontStyle get fontStyleEnum => TranslationFontStyle.values[fontStyle];
  set fontStyleEnum(TranslationFontStyle style) => fontStyle = style.index;

  AppSetting({int? id}) {
    if (id != null) this.id = id;
  }
}

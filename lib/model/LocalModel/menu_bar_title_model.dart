class MenuBarTitleModel {
  String? _title;
  String? _iconPath;

  String? get title => _title;
  String? get iconPath => _iconPath;

  MenuBarTitleModel(String? title, String? iconPath) {
    _title = title;
    _iconPath = iconPath;
  }
}

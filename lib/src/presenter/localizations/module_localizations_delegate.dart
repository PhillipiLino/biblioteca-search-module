// coverage:ignore-file

import 'package:clean_architecture_utils/localizations.dart';
import 'package:flutter/material.dart';

import 'messages/messages_all.dart';
import 'module_localization.dart';

class SearchModuleLocalizationsDelegate
    extends LocalizationsDelegate<ModuleLocalizations> {
  const SearchModuleLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['pt', 'en'].contains(locale.languageCode);

  @override
  Future<ModuleLocalizations> load(Locale locale) => MultipleLocalizations.load(
      initializeMessages, locale, (l) => ModuleLocalizations.load(locale),
      setDefaultLocale: true);

  @override
  bool shouldReload(LocalizationsDelegate<ModuleLocalizations> old) => false;
}

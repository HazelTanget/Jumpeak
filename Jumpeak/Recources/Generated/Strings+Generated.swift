// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  /// Создать аккаунт
  public static let createAccount = Strings.tr("Localizable", "createAccount", fallback: "Создать аккаунт")
  /// Уже пользовались приложением?
  public static let doYouUseApp = Strings.tr("Localizable", "doYouUseApp", fallback: "Уже пользовались приложением?")
  /// Войти
  public static let enter = Strings.tr("Localizable", "enter", fallback: "Войти")
  /// Localizable.strings
  ///   Jumpeak
  /// 
  ///   Created by Денис Большачков on 10.04.2023.
  public static let helloText = Strings.tr("Localizable", "helloText", fallback: "Привет!\nЭто Jumpeak — место, где дейтятся студенты и работодатели")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  /// Can't get in?
  public static let cantGetIn = Strings.tr("Localizable", "cantGetIn", fallback: "Can't get in?")
  /// Confirm account
  public static let confirmAccount = Strings.tr("Localizable", "confirmAccount", fallback: "Confirm account")
  /// Create account
  public static let createAccount = Strings.tr("Localizable", "createAccount", fallback: "Create account")
  /// The final step is to create a strong password
  public static let createStrongPass = Strings.tr("Localizable", "createStrongPass", fallback: "The final step is to create a strong password")
  /// Have you used the app yet?
  public static let doYouUseApp = Strings.tr("Localizable", "doYouUseApp", fallback: "Have you used the app yet?")
  /// Email
  public static let email = Strings.tr("Localizable", "email", fallback: "Email")
  /// Sign in
  public static let enter = Strings.tr("Localizable", "enter", fallback: "Sign in")
  /// Enter your confirmation code, we’ve sent it to you
  public static let enterCode = Strings.tr("Localizable", "enterCode", fallback: "Enter your confirmation code, we’ve sent it to you")
  /// Enter your confirmation code in your mail
  public static let enterEmailWithPassCode = Strings.tr("Localizable", "enterEmailWithPassCode", fallback: "Enter your confirmation code in your mail")
  /// Localizable.strings
  ///   Jumpeak
  /// 
  ///   Created by Денис Большачков on 10.04.2023.
  public static let helloText = Strings.tr("Localizable", "helloText", fallback: "Hi!\nThis is Jumpeak - the place where meet students and employers")
  /// Imagine password
  public static let imaginePassword = Strings.tr("Localizable", "imaginePassword", fallback: "Imagine password")
  /// Next
  public static let next = Strings.tr("Localizable", "next", fallback: "Next")
  /// Password
  public static let password = Strings.tr("Localizable", "password", fallback: "Password")
  /// Passwords do not match
  public static let passwordDontMatch = Strings.tr("Localizable", "passwordDontMatch", fallback: "Passwords do not match")
  /// Strong
  public static let strong = Strings.tr("Localizable", "strong", fallback: "Strong")
  /// Похоже, этой почты нет в нашей базе
  public static let userDoesntExsist = Strings.tr("Localizable", "userDoesntExsist", fallback: "Похоже, этой почты нет в нашей базе")
  /// Weak
  public static let `weak` = Strings.tr("Localizable", "weak", fallback: "Weak")
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

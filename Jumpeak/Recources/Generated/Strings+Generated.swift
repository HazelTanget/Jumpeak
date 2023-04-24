// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  /// We’ve broken it down into
  /// steps, you can do some of them a little bit
  /// later, but you have to do
  /// all of them
  public static let brokenOnSteps = Strings.tr("Localizable", "brokenOnSteps", fallback: "We’ve broken it down into\nsteps, you can do some of them a little bit\nlater, but you have to do\nall of them")
  /// Can't get in?
  public static let cantGetIn = Strings.tr("Localizable", "cantGetIn", fallback: "Can't get in?")
  /// Choose an field. One or more
  public static let choseOneOrMore = Strings.tr("Localizable", "choseOneOrMore", fallback: "Choose an field. One or more")
  /// Choose which field you want to work in?
  public static let choseYourJob = Strings.tr("Localizable", "choseYourJob", fallback: "Choose which field you want to work in?")
  /// Confirm account
  public static let confirmAccount = Strings.tr("Localizable", "confirmAccount", fallback: "Confirm account")
  /// Create account
  public static let createAccount = Strings.tr("Localizable", "createAccount", fallback: "Create account")
  /// First you need to create
  /// your resume card, which will
  /// be seen by employers
  public static let createResume = Strings.tr("Localizable", "createResume", fallback: "First you need to create\nyour resume card, which will\nbe seen by employers")
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
  /// Enter name field
  public static let enterNameArea = Strings.tr("Localizable", "enterNameArea", fallback: "Enter name field")
  /// Localizable.strings
  ///   Jumpeak
  /// 
  ///   Created by Денис Большачков on 10.04.2023.
  public static let helloText = Strings.tr("Localizable", "helloText", fallback: "Hi!\nThis is Jumpeak - the place where meet students and employers")
  /// Imagine password
  public static let imaginePassword = Strings.tr("Localizable", "imaginePassword", fallback: "Imagine password")
  /// Let's start!
  public static let letsStart = Strings.tr("Localizable", "letsStart", fallback: "Let's start!")
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
  /// Welcome to the Jumpeak
  public static let welcomeToJumpeak = Strings.tr("Localizable", "welcomeToJumpeak", fallback: "Welcome to the Jumpeak")
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

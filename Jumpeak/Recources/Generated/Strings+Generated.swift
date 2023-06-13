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
  /// See what else you need to fill out to make your card visible to employers:
  public static let checkWhatNeedToBoss = Strings.tr("Localizable", "checkWhatNeedToBoss", fallback: "See what else you need to fill out to make your card visible to employers:")
  /// Choose an field. One or more
  public static let choseOneOrMore = Strings.tr("Localizable", "choseOneOrMore", fallback: "Choose an field. One or more")
  /// Choose which field you want to work in?
  public static let choseYourJob = Strings.tr("Localizable", "choseYourJob", fallback: "Choose which field you want to work in?")
  /// Made %@ out of %@ steps
  public static func completedSteps(_ p1: Any, _ p2: Any) -> String {
    return Strings.tr("Localizable", "completedSteps", String(describing: p1), String(describing: p2), fallback: "Made %@ out of %@ steps")
  }
  /// Confirm account
  public static let confirmAccount = Strings.tr("Localizable", "confirmAccount", fallback: "Confirm account")
  /// Create account
  public static let createAccount = Strings.tr("Localizable", "createAccount", fallback: "Create account")
  /// Create new project
  public static let createNewProject = Strings.tr("Localizable", "createNewProject", fallback: "Create new project")
  /// First you need to create
  /// your resume card, which will
  /// be seen by employers
  public static let createResume = Strings.tr("Localizable", "createResume", fallback: "First you need to create\nyour resume card, which will\nbe seen by employers")
  /// The final step is to create a strong password
  public static let createStrongPass = Strings.tr("Localizable", "createStrongPass", fallback: "The final step is to create a strong password")
  /// Загрузи свою фотографию. Так работодателям будет легче с тобой познакомиться
  public static let donwloadPhoto = Strings.tr("Localizable", "donwloadPhoto", fallback: "Загрузи свою фотографию. Так работодателям будет легче с тобой познакомиться")
  /// Может у тебя есть опыт работы или стажировки на этой или похожей профессии?
  public static let doYouHaveExp = Strings.tr("Localizable", "doYouHaveExp", fallback: "Может у тебя есть опыт работы или стажировки на этой или похожей профессии?")
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
  /// First step. Base info
  public static let firstStepBaseInfo = Strings.tr("Localizable", "firstStepBaseInfo", fallback: "First step. Base info")
  /// Localizable.strings
  ///   Jumpeak
  /// 
  ///   Created by Денис Большачков on 10.04.2023.
  public static let helloText = Strings.tr("Localizable", "helloText", fallback: "Hi!\nThis is Jumpeak - the place where meet students and employers")
  /// Imagine password
  public static let imaginePassword = Strings.tr("Localizable", "imaginePassword", fallback: "Imagine password")
  /// Этот шаг можно выполнить попозже, но он обязательный
  public static let itDefinetlyAction = Strings.tr("Localizable", "itDefinetlyAction", fallback: "Этот шаг можно выполнить попозже, но он обязательный")
  /// Let's start!
  public static let letsStart = Strings.tr("Localizable", "letsStart", fallback: "Let's start!")
  /// Next
  public static let next = Strings.tr("Localizable", "next", fallback: "Next")
  /// Нет ничего страшного, если у тебя ещё нет реального опыта работы
  public static let noProblemWithExp = Strings.tr("Localizable", "noProblemWithExp", fallback: "Нет ничего страшного, если у тебя ещё нет реального опыта работы")
  /// Пока нет
  public static let notYet = Strings.tr("Localizable", "notYet", fallback: "Пока нет")
  /// Open
  public static let `open` = Strings.tr("Localizable", "open", fallback: "Open")
  /// Password
  public static let password = Strings.tr("Localizable", "password", fallback: "Password")
  /// Passwords do not match
  public static let passwordDontMatch = Strings.tr("Localizable", "passwordDontMatch", fallback: "Passwords do not match")
  /// Second step. Portfolio
  public static let secondStepPorfolio = Strings.tr("Localizable", "secondStepPorfolio", fallback: "Second step. Portfolio")
  /// Пропустить
  public static let skip = Strings.tr("Localizable", "skip", fallback: "Пропустить")
  /// Steps menu
  public static let stepMenuTitle = Strings.tr("Localizable", "stepMenuTitle", fallback: "Steps menu")
  /// Strong
  public static let strong = Strings.tr("Localizable", "strong", fallback: "Strong")
  /// Расскажи об этом подробнее, это даст тебе преимущество перед другими студентами
  public static let tellMoreAboutIt = Strings.tr("Localizable", "tellMoreAboutIt", fallback: "Расскажи об этом подробнее, это даст тебе преимущество перед другими студентами")
  /// Похоже, этой почты нет в нашей базе
  public static let userDoesntExsist = Strings.tr("Localizable", "userDoesntExsist", fallback: "Похоже, этой почты нет в нашей базе")
  /// Вы уже зарегестрированны в нашей системе.
  public static let userWithEmailAlreadyExists = Strings.tr("Localizable", "userWithEmailAlreadyExists", fallback: "Вы уже зарегестрированны в нашей системе.")
  /// Weak
  public static let `weak` = Strings.tr("Localizable", "weak", fallback: "Weak")
  /// Welcome to the Jumpeak
  public static let welcomeToJumpeak = Strings.tr("Localizable", "welcomeToJumpeak", fallback: "Welcome to the Jumpeak")
  /// Да, есть!
  public static let yesIHave = Strings.tr("Localizable", "yesIHave", fallback: "Да, есть!")
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

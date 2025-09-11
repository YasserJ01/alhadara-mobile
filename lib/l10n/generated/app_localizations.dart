import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Project2'**
  String get appTitle;

  /// Welcome message on start screen
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Welcome subtitle on start screen
  ///
  /// In en, this message translates to:
  /// **'Enjoy the world\'s fastest and best education'**
  String get welcomeSubtitle;

  /// Sign in button text
  ///
  /// In en, this message translates to:
  /// **'SIGN IN'**
  String get signIn;

  /// Guest button text
  ///
  /// In en, this message translates to:
  /// **'AS A GUEST'**
  String get asAGuest;

  /// Login title
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Login subtitle
  ///
  /// In en, this message translates to:
  /// **'let\'s get started'**
  String get letsGetStarted;

  /// Phone number field label
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Forgot password link text
  ///
  /// In en, this message translates to:
  /// **'forgot password ?'**
  String get forgotPassword;

  /// Save password checkbox text
  ///
  /// In en, this message translates to:
  /// **'Save my password securely'**
  String get saveMyPasswordSecurely;

  /// Keep signed in checkbox text
  ///
  /// In en, this message translates to:
  /// **'Keep me signed in'**
  String get keepMeSignedIn;

  /// Biometric login checkbox text
  ///
  /// In en, this message translates to:
  /// **'Enable biometric login'**
  String get enableBiometricLogin;

  /// Sign up prompt text
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account ?'**
  String get dontHaveAccount;

  /// Sign up button text
  ///
  /// In en, this message translates to:
  /// **' SIGN UP'**
  String get signUp;

  /// Quick login section title
  ///
  /// In en, this message translates to:
  /// **'Quick Login'**
  String get quickLogin;

  /// Saved login button text
  ///
  /// In en, this message translates to:
  /// **'Saved Login'**
  String get savedLogin;

  /// Biometric login button text
  ///
  /// In en, this message translates to:
  /// **'Biometric'**
  String get biometric;

  /// Clear credentials button text
  ///
  /// In en, this message translates to:
  /// **'Clear saved credentials'**
  String get clearSavedCredentials;

  /// Error dialog title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Authenticate button
  ///
  /// In en, this message translates to:
  /// **'Authenticate'**
  String get authenticate;

  /// Biometric login dialog title
  ///
  /// In en, this message translates to:
  /// **'Biometric Login'**
  String get biometricLogin;

  /// Biometric authentication instruction
  ///
  /// In en, this message translates to:
  /// **'Use your biometric authentication to login'**
  String get useBiometricAuth;

  /// Clear credentials dialog title
  ///
  /// In en, this message translates to:
  /// **'Clear Saved Credentials'**
  String get clearSavedCredentialsTitle;

  /// Clear credentials confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear your saved login credentials?'**
  String get clearSavedCredentialsMessage;

  /// Clear button text
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// Phone number validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterPhoneNumber;

  /// Password validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// Language settings title
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettings;

  /// Select language instruction
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Arabic language option
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// User Recommendations
  ///
  /// In en, this message translates to:
  /// **'Recommendations'**
  String get recommendation;

  /// No description provided for @offers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offers;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @hadara.
  ///
  /// In en, this message translates to:
  /// **'Hadara'**
  String get hadara;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @wishlist.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlist;

  /// No description provided for @enrollments.
  ///
  /// In en, this message translates to:
  /// **'Enrollments'**
  String get enrollments;

  /// No description provided for @courses.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get courses;

  /// No description provided for @loyalty.
  ///
  /// In en, this message translates to:
  /// **'Loyalty Points'**
  String get loyalty;

  /// No description provided for @entrance.
  ///
  /// In en, this message translates to:
  /// **'Entrance Exam'**
  String get entrance;

  /// No description provided for @noProfileFound.
  ///
  /// In en, this message translates to:
  /// **'No Profile Found'**
  String get noProfileFound;

  /// No description provided for @noProfileFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have a profile yet. Would you like to create one?'**
  String get noProfileFoundMessage;

  /// No description provided for @createProfile.
  ///
  /// In en, this message translates to:
  /// **'Create Profile'**
  String get createProfile;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get birthDate;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @selectYourGender.
  ///
  /// In en, this message translates to:
  /// **'Select your gender'**
  String get selectYourGender;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @academicStatus.
  ///
  /// In en, this message translates to:
  /// **'Academic Status'**
  String get academicStatus;

  /// No description provided for @selectYourAcademicStatus.
  ///
  /// In en, this message translates to:
  /// **'Select your academic status'**
  String get selectYourAcademicStatus;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'female'**
  String get female;

  /// No description provided for @highSchool.
  ///
  /// In en, this message translates to:
  /// **'high school'**
  String get highSchool;

  /// No description provided for @notStudying.
  ///
  /// In en, this message translates to:
  /// **'not studying'**
  String get notStudying;

  /// No description provided for @undergraduate.
  ///
  /// In en, this message translates to:
  /// **'undergraduate'**
  String get undergraduate;

  /// No description provided for @graduate.
  ///
  /// In en, this message translates to:
  /// **'graduate'**
  String get graduate;

  /// No description provided for @continuing.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continuing;

  /// No description provided for @basicinfo.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicinfo;

  /// No description provided for @university.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get university;

  /// No description provided for @studyField.
  ///
  /// In en, this message translates to:
  /// **'Study Field'**
  String get studyField;

  /// No description provided for @selectYourUniversity.
  ///
  /// In en, this message translates to:
  /// **'Select your university'**
  String get selectYourUniversity;

  /// No description provided for @selectYourStudyField.
  ///
  /// In en, this message translates to:
  /// **'Select your study field'**
  String get selectYourStudyField;

  /// No description provided for @universityAndStudyField.
  ///
  /// In en, this message translates to:
  /// **'University & Study Field'**
  String get universityAndStudyField;

  /// No description provided for @pleaseSelectUniversity.
  ///
  /// In en, this message translates to:
  /// **'Please select a university'**
  String get pleaseSelectUniversity;

  /// No description provided for @pleaseSelectStudyField.
  ///
  /// In en, this message translates to:
  /// **'Please select a study field'**
  String get pleaseSelectStudyField;

  /// No description provided for @pleaseSelectBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Please select your birth date'**
  String get pleaseSelectBirthDate;

  /// No description provided for @pleaseSelectGender.
  ///
  /// In en, this message translates to:
  /// **'Please select your gender'**
  String get pleaseSelectGender;

  /// No description provided for @pleaseEnterAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter your address'**
  String get pleaseEnterAddress;

  /// No description provided for @pleaseSelectAcademicStatus.
  ///
  /// In en, this message translates to:
  /// **'Please select your academic status'**
  String get pleaseSelectAcademicStatus;

  /// No description provided for @yourInterests.
  ///
  /// In en, this message translates to:
  /// **'Your interests'**
  String get yourInterests;

  /// No description provided for @selectInterestsLimit.
  ///
  /// In en, this message translates to:
  /// **'Select up to 3 of your interests'**
  String get selectInterestsLimit;

  /// No description provided for @ratingInterest.
  ///
  /// In en, this message translates to:
  /// **'Rate your level of interest for each'**
  String get ratingInterest;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @errorPickingImage.
  ///
  /// In en, this message translates to:
  /// **'Error picking image'**
  String get errorPickingImage;

  /// No description provided for @errorTakingPhoto.
  ///
  /// In en, this message translates to:
  /// **'Error taking photo'**
  String get errorTakingPhoto;

  /// No description provided for @selectImageSource.
  ///
  /// In en, this message translates to:
  /// **'Select Image Source'**
  String get selectImageSource;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @uploadProfileImage.
  ///
  /// In en, this message translates to:
  /// **'Upload your profile image'**
  String get uploadProfileImage;

  /// No description provided for @selectImage.
  ///
  /// In en, this message translates to:
  /// **'Select Image'**
  String get selectImage;

  /// No description provided for @changeImage.
  ///
  /// In en, this message translates to:
  /// **'Change Image'**
  String get changeImage;

  /// No description provided for @uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get uploading;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @uploadingProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Uploading your profile picture...'**
  String get uploadingProfilePicture;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfo;

  /// No description provided for @academicInfo.
  ///
  /// In en, this message translates to:
  /// **'Academic Details'**
  String get academicInfo;

  /// No description provided for @yourBalance.
  ///
  /// In en, this message translates to:
  /// **'Your Balance'**
  String get yourBalance;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @deposit.
  ///
  /// In en, this message translates to:
  /// **'DEPOSIT'**
  String get deposit;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'WITHDRAW'**
  String get withdraw;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @transactionDetails.
  ///
  /// In en, this message translates to:
  /// **'Transaction Details'**
  String get transactionDetails;

  /// No description provided for @transactionType.
  ///
  /// In en, this message translates to:
  /// **'Transaction Type'**
  String get transactionType;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @methodSelection.
  ///
  /// In en, this message translates to:
  /// **'Please select a method first'**
  String get methodSelection;

  /// No description provided for @pleaseMakeValidSelection.
  ///
  /// In en, this message translates to:
  /// **'Please make a valid selection'**
  String get pleaseMakeValidSelection;

  /// No description provided for @bankTransferDetails.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer Details'**
  String get bankTransferDetails;

  /// No description provided for @moneyTransferDetails.
  ///
  /// In en, this message translates to:
  /// **'Money Transfer Details'**
  String get moneyTransferDetails;

  /// No description provided for @bankName.
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get bankName;

  /// No description provided for @accountName.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get accountName;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumber;

  /// No description provided for @company.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get company;

  /// No description provided for @receiver.
  ///
  /// In en, this message translates to:
  /// **'Receiver'**
  String get receiver;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @ifReadyToPayClickHere.
  ///
  /// In en, this message translates to:
  /// **'If you are ready to pay click here'**
  String get ifReadyToPayClickHere;

  /// No description provided for @confirmPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get confirmPayment;

  /// No description provided for @pleaseSelectTransactionScreenshot.
  ///
  /// In en, this message translates to:
  /// **'Please select a transaction screenshot'**
  String get pleaseSelectTransactionScreenshot;

  /// No description provided for @createDepositRequest.
  ///
  /// In en, this message translates to:
  /// **'Create Deposit Request'**
  String get createDepositRequest;

  /// No description provided for @depositRequestSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Deposit request submitted successfully!'**
  String get depositRequestSubmitted;

  /// No description provided for @transactionScreenshot.
  ///
  /// In en, this message translates to:
  /// **'Transaction Screenshot'**
  String get transactionScreenshot;

  /// No description provided for @noScreenshotSelected.
  ///
  /// In en, this message translates to:
  /// **'No screenshot selected'**
  String get noScreenshotSelected;

  /// No description provided for @addScreenshot.
  ///
  /// In en, this message translates to:
  /// **'Add Screenshot'**
  String get addScreenshot;

  /// No description provided for @changeScreenshot.
  ///
  /// In en, this message translates to:
  /// **'Change Screenshot'**
  String get changeScreenshot;

  /// No description provided for @transactionNumber.
  ///
  /// In en, this message translates to:
  /// **'Transaction Number'**
  String get transactionNumber;

  /// No description provided for @enterTransactionNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter transaction number'**
  String get enterTransactionNumber;

  /// No description provided for @transactionNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Transaction number is required'**
  String get transactionNumberRequired;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// No description provided for @amountRequired.
  ///
  /// In en, this message translates to:
  /// **'Amount is required'**
  String get amountRequired;

  /// No description provided for @pleaseEnterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get pleaseEnterValidAmount;

  /// No description provided for @submitting.
  ///
  /// In en, this message translates to:
  /// **'Submitting...'**
  String get submitting;

  /// No description provided for @submitRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit Request'**
  String get submitRequest;

  /// No description provided for @submittingDepositRequest.
  ///
  /// In en, this message translates to:
  /// **'Submitting your deposit request...'**
  String get submittingDepositRequest;

  /// No description provided for @noWishlistCourses.
  ///
  /// In en, this message translates to:
  /// **'No courses in your wishlist yet'**
  String get noWishlistCourses;

  /// No description provided for @startAddingCourses.
  ///
  /// In en, this message translates to:
  /// **'Start adding courses you love!'**
  String get startAddingCourses;

  /// No description provided for @failedToLoadWishlist.
  ///
  /// In en, this message translates to:
  /// **'Failed to load wishlist'**
  String get failedToLoadWishlist;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @viewCourse.
  ///
  /// In en, this message translates to:
  /// **'View course'**
  String get viewCourse;

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get student;

  /// No description provided for @enrollmentDate.
  ///
  /// In en, this message translates to:
  /// **'Enrollment Date'**
  String get enrollmentDate;

  /// No description provided for @addPayment.
  ///
  /// In en, this message translates to:
  /// **'ADD PAYMENT'**
  String get addPayment;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @makePayment.
  ///
  /// In en, this message translates to:
  /// **'Make Payment'**
  String get makePayment;

  /// No description provided for @remainingBalance.
  ///
  /// In en, this message translates to:
  /// **'Remaining Balance'**
  String get remainingBalance;

  /// No description provided for @paymentAmount.
  ///
  /// In en, this message translates to:
  /// **'Payment Amount'**
  String get paymentAmount;

  /// No description provided for @pleaseEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter amount'**
  String get pleaseEnterAmount;

  /// No description provided for @enterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter valid amount'**
  String get enterValidAmount;

  /// No description provided for @amountExceedsBalance.
  ///
  /// In en, this message translates to:
  /// **'Amount exceeds balance'**
  String get amountExceedsBalance;

  /// No description provided for @courseDetails.
  ///
  /// In en, this message translates to:
  /// **'Course Details'**
  String get courseDetails;

  /// No description provided for @startQuiz.
  ///
  /// In en, this message translates to:
  /// **'Start Quiz'**
  String get startQuiz;

  /// No description provided for @courseProgress.
  ///
  /// In en, this message translates to:
  /// **'Course Progress'**
  String get courseProgress;

  /// No description provided for @lessonsCount.
  ///
  /// In en, this message translates to:
  /// **'Lessons Count'**
  String get lessonsCount;

  /// No description provided for @amountPaid.
  ///
  /// In en, this message translates to:
  /// **'Amount Paid'**
  String get amountPaid;

  /// No description provided for @attendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendance;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @lessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get lessons;

  /// No description provided for @hall.
  ///
  /// In en, this message translates to:
  /// **'Hall'**
  String get hall;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @downloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading'**
  String get downloading;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait'**
  String get pleaseWait;

  /// No description provided for @couldNotOpenTelegram.
  ///
  /// In en, this message translates to:
  /// **'Could not open Telegram'**
  String get couldNotOpenTelegram;

  /// No description provided for @couldNotLoadImage.
  ///
  /// In en, this message translates to:
  /// **'Could not load image'**
  String get couldNotLoadImage;

  /// No description provided for @chooseDownloadMethod.
  ///
  /// In en, this message translates to:
  /// **'Choose download method'**
  String get chooseDownloadMethod;

  /// No description provided for @directDownload.
  ///
  /// In en, this message translates to:
  /// **'Direct Download'**
  String get directDownload;

  /// No description provided for @viaTelegram.
  ///
  /// In en, this message translates to:
  /// **'Via Telegram'**
  String get viaTelegram;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @homeworkAssignments.
  ///
  /// In en, this message translates to:
  /// **'Homework Assignments'**
  String get homeworkAssignments;

  /// No description provided for @noHomeworkAssigned.
  ///
  /// In en, this message translates to:
  /// **'No homework assigned for this lesson'**
  String get noHomeworkAssigned;

  /// No description provided for @classSchedule.
  ///
  /// In en, this message translates to:
  /// **'Class Schedule'**
  String get classSchedule;

  /// No description provided for @showAll.
  ///
  /// In en, this message translates to:
  /// **'Show All'**
  String get showAll;

  /// No description provided for @noLessonsScheduled.
  ///
  /// In en, this message translates to:
  /// **'No lessons scheduled for'**
  String get noLessonsScheduled;

  /// No description provided for @noLessonsFound.
  ///
  /// In en, this message translates to:
  /// **'No lessons found'**
  String get noLessonsFound;

  /// No description provided for @tapToViewHomework.
  ///
  /// In en, this message translates to:
  /// **'Tap to view homework'**
  String get tapToViewHomework;

  /// No description provided for @allLessonsCompleted.
  ///
  /// In en, this message translates to:
  /// **'All lessons completed'**
  String get allLessonsCompleted;

  /// No description provided for @homework.
  ///
  /// In en, this message translates to:
  /// **'Homework'**
  String get homework;

  /// No description provided for @mandatory.
  ///
  /// In en, this message translates to:
  /// **'Mandatory'**
  String get mandatory;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @deadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadline;

  /// No description provided for @maxScore.
  ///
  /// In en, this message translates to:
  /// **'Max Score'**
  String get maxScore;

  /// No description provided for @departments.
  ///
  /// In en, this message translates to:
  /// **'Departments'**
  String get departments;

  /// No description provided for @courseTypes.
  ///
  /// In en, this message translates to:
  /// **'Course Types'**
  String get courseTypes;

  /// No description provided for @offlineCachedDataFrom.
  ///
  /// In en, this message translates to:
  /// **'Offline - Showing cached data from'**
  String get offlineCachedDataFrom;

  /// No description provided for @offlineCachedData.
  ///
  /// In en, this message translates to:
  /// **'Offline - Showing cached data'**
  String get offlineCachedData;

  /// No description provided for @retryWhenOnline.
  ///
  /// In en, this message translates to:
  /// **'Retry when online'**
  String get retryWhenOnline;

  /// No description provided for @connectToInternet.
  ///
  /// In en, this message translates to:
  /// **'Connect to internet'**
  String get connectToInternet;

  /// No description provided for @workshops.
  ///
  /// In en, this message translates to:
  /// **'Workshops'**
  String get workshops;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

unit GoogleAdMob;
{$mode delphi}
{$modeswitch objectivec1}
{$modeswitch cvar}

// requirements of GoogleMobleAds framework
{$linkframework AdSupport}
{$linkframework AudioToolbox}
{$linkframework AVFoundation}
{$linkframework CoreBluetooth}
{$linkframework CoreGraphics}
{$linkframework CoreMedia}
{$linkframework CoreTelephony}
{$linkframework EventKit}
{$linkframework EventKitUI}
{$linkframework Foundation}
{$linkframework MediaPlayer}
{$linkframework MessageUI}
{$linkframework SafariServices}
{$linkframework StoreKit}
{$linkframework SystemConfiguration}
{$linkframework UIKit}

{$linkframework GoogleMobileAds}
//
//  GoogleMobileAds.h
//  Google Mobile Ads SDK
//
//  Copyright 2014 Google Inc. All rights reserved.
//
//  Coverted to FPC Objective-Pascal by Dmitry 'skalogryz' Boyarintsev 2016

interface

{$ifdef iphoneall}
uses iPhoneAll, StoreKit;
{$endif}

//  GADAdDelegate.h
type

  GADAdDelegate = objcprotocol
  optional
    /// Asks the delegate if the audio session category can be changed while displaying an ad. Return NO
    /// to prevent the Google Mobile Ads SDK from changing the audio session category. The default
    /// behavior if unimplemented is to return YES.
    function ad_shouldChangeAudioSessionToCategory(ad: id; audioSessionCategory: NSSTring): LongBool; message 'ad:houldChangeAudioSessionToCategory:';
  end;

//  GADAdNetworkExtras.h

  // An object implementing this protocol contains information set by the publisher on the client
  /// device for a particular ad network.
  ///
  /// Ad networks should create an 'extras' object implementing this protocol for their publishers to
  /// use.
  GADAdNetworkExtras = objcprotocol
  end;

//  GADAdSize.h

/// A valid GADAdSize is considered to be one of the predefined GADAdSize constants or a GADAdSize
/// constructed by GADAdSizeFromCGSize, GADAdSizeFullWidthPortraitWithHeight,
/// GADAdSizeFullWidthLandscapeWithHeight.
///
/// Do not create a GADAdSize manually. Use one of the kGADAdSize constants. Treat GADAdSize as an
/// opaque type. Do not access any fields directly. To obtain a concrete CGSize, use the function
/// CGSizeFromGADAdSize().

type
  /// Ad size.
  /// \see typedef GADAdSize
  GADAdSize = record
    size  : CGSize;       ///< The ad size. Don't modify this value directly.
    flags : NSUInteger;  ///< Reserved.
  end;

  // Standard Sizes

var
  /// iPhone and iPod Touch ad size. Typically 320x50.
  kGADAdSizeBanner : GADAdSize; cvar; external;
  /// Taller version of kGADAdSizeBanner. Typically 320x100.
  kGADAdSizeLargeBanner : GADAdSize; cvar; external;

  /// Medium Rectangle size for the iPad (especially in a UISplitView's left pane). Typically 300x250.
  kGADAdSizeMediumRectangle : GADAdSize; cvar; external;

  /// Full Banner size for the iPad (especially in a UIPopoverController or in
  /// UIModalPresentationFormSheet). Typically 468x60.
  kGADAdSizeFullBanner: GADAdSize; cvar; external;

  /// Leaderboard size for the iPad. Typically 728x90.
  kGADAdSizeLeaderboard: GADAdSize; cvar; external;

  /// Skyscraper size for the iPad. Mediation only. AdMob/Google does not offer this size. Typically
  /// 120x600.
  kGADAdSizeSkyscraper: GADAdSize; cvar; external;

  /// An ad size that spans the full width of the application in portrait orientation. The height is
  /// typically 50 pixels on an iPhone/iPod UI, and 90 pixels tall on an iPad UI.
  kGADAdSizeSmartBannerPortrait: GADAdSize; cvar; external;

  /// An ad size that spans the full width of the application in landscape orientation. The height is
  /// typically 32 pixels on an iPhone/iPod UI, and 90 pixels tall on an iPad UI.
  kGADAdSizeSmartBannerLandscape: GADAdSize; cvar; external;

  /// An ad size that spans the full width of its container, with a height dynamically determined by
  /// the ad.
  kGADAdSizeFluid: GADAdSize; cvar; external;

  /// Invalid ad size marker.
  kGADAdSizeInvalid: GADAdSize; cvar; external;

  // Standard Sizes

  /// Returns a custom GADAdSize for the provided CGSize. Use this only if you require a non-standard
  /// size. Otherwise, use one of the standard size constants above.
function GADAdSizeFromCGSize(size: CGSize): GADAdSize; cdecl; external;

  /// Returns a custom GADAdSize that spans the full width of the application in portrait orientation
  /// with the height provided.
function GADAdSizeFullWidthPortraitWithHeight(height: CGFloat): GADAdSize; cdecl; external;

  /// Returns a custom GADAdSize that spans the full width of the application in landscape orientation
  /// with the height provided.
function GADAdSizeFullWidthLandscapeWithHeight(height: CGFloat): GADAdSize; cdecl; external;

  // Convenience Functions

  /// Returns YES if the two GADAdSizes are equal, otherwise returns NO.
function GADAdSizeEqualToSize(size1: GADAdSize; size2: GADAdSize ): LongBool; cdecl; external;

  /// Returns a CGSize for the provided a GADAdSize constant. If the GADAdSize is unknown, returns
  /// CGSizeZero.
function CGSizeFromGADAdSize(size: GADAdSize): CGSize; cdecl; external;

  /// Returns YES if |size| is one of the predefined constants or is a custom GADAdSize generated by
  /// GADAdSizeFromCGSize.
function IsGADAdSizeValid(size: GADAdSize): LongBool; cdecl; external;

  /// Returns YES if |size| is a fluid ad size.
function GADAdSizeIsFluid(size: GADAdSize): LongBool; cdecl; external;

  /// Returns a NSString describing the provided GADAdSize.
function NSStringFromGADAdSize(size: GADAdSize): NSString; cdecl; external;

  /// Returns an NSValue representing the GADAdSize.
function NSValueFromGADAdSize(size: GADAdSize): NSValue; cdecl; external;

  /// Returns a GADAdSize from an NSValue. Returns kGADAdSizeInvalid if the value is not a GADAdSize.
function GADAdSizeFromNSValue(value: NSValue): GADAdSize; cdecl; external;

//  Deprecated Macros

function GAD_SIZE_320x50: CGSize; inline; deprecated;
function GAD_SIZE_320x100: CGSize; inline; deprecated;
function GAD_SIZE_300x250: CGSize; inline; deprecated;
function GAD_SIZE_468x60: CGSize; inline; deprecated;
function GAD_SIZE_728x90: CGSize; inline; deprecated;
function GAD_SIZE_120x600: CGSize; inline; deprecated;

//  GADRequestError.h

/// Google AdMob Ads error domain.
var
  kGADErrorDomain: NSString; cvar; external;

/// NSError codes for GAD error domain.
type
  GADErrorCode = NSInteger;

  /// The ad request is invalid. The localizedFailureReason error description will have more
  /// details. Typically this is because the ad did not have the ad unit ID or root view
  /// controller set.
const
  kGADErrorInvalidRequest = 0;

  /// The ad request was successful, but no ad was returned.
  kGADErrorNoFill = 1;

  /// There was an error loading data from the network.
  kGADErrorNetworkError = 2;

  /// The ad server experienced a failure processing the request.
  kGADErrorServerError = 3;

  /// The current device's OS is below the minimum required version.
  kGADErrorOSVersionTooLow = 4;

  /// The request was unable to be loaded before being timed out.
  kGADErrorTimeout = 5;

  /// Will not send request because the interstitial object has already been used.
  kGADErrorInterstitialAlreadyUsed = 6;

  /// The mediation response was invalid.
  kGADErrorMediationDataError = 7;

  /// Error finding or creating a mediation ad network adapter.
  kGADErrorMediationAdapterError = 8;

  /// The mediation request was successful, but no ad was returned from any ad networks.
  kGADErrorMediationNoFill = 9;

  /// Attempting to pass an invalid ad size to an adapter.
  kGADErrorMediationInvalidAdSize = 10;

  /// Internal error.
  kGADErrorInternalError = 11;

  /// Invalid argument error.
  kGADErrorInvalidArgument = 12;

  /// Received invalid response.
  kGADErrorReceivedInvalidResponse = 13;

type
  /// Represents the error generated due to invalid request parameters.
  GADRequestError = objcclass external (NSError);

//  GADRequest.h

var
  kGADSimulatorID : id; cvar; external;

type
  GADGender = NSInteger;

  /// Genders to help deliver more relevant ads.
const
  kGADGenderUnknown = 0;  ///< Unknown gender.
  kGADGenderMale    = 1;  ///< Male gender.
  kGADGenderFemale  = 2;  ///< Female gender.

type
  /// Specifies optional parameters for ad requests.
  GADRequest = objcclass external (NSObject {, NSCopying})
  public
    /// Returns a default request.
    class function request: GADRequest; message 'request';

    // Additional Parameters For Ad Networks

    /// Ad networks may have additional parameters they accept. To pass these parameters to them, create
    /// the ad network extras object for that network, fill in the parameters, and register it here. The
    /// ad network should have a header defining the interface for the 'extras' object to create. All
    /// networks will have access to the basic settings you've set in this GADRequest (gender, birthday,
    /// testing mode, etc.). If you register an extras object that is the same class as one you have
    /// registered before, the previous extras will be overwritten.
    procedure registerAdNetworkExtras(extras: GADAdNetworkExtras);
      message 'registerAdNetworkExtras:';

    /// Returns the network extras defined for an ad network.
    function adNetworkExtrasFor(aClass: id): GADAdNetworkExtras;
      message 'adNetworkExtrasFor:';

    /// Removes the extras for an ad network. |aClass| is the class which represents that network's
    /// extras type.
    procedure removeAdNetworkExtrasFor(aClass: id);
      message 'removeAdNetworkExtrasFor:';

    // Collecting SDK Information

    /// Returns the version of the SDK.
    class function sdkVersion: NSString; message 'sdkVersion';

    // Testing

    /// Test ads will be returned for devices with device IDs specified in this array.
    function testDevices: NSArray; message 'testDevices';
    procedure setTestDevices(AArray: NSArray); message 'setTestDevices:';

    // User Information

    /// Provide the user's gender to increase ad relevancy.
    function gender: GADGender; message 'gender';
    procedure setGender(agender: GADGender); message 'setGender:';

    /// Provide the user's birthday to increase ad relevancy.
    function birthday: NSDate; message 'birthday';
    procedure setBirthday(abirthdate: NSDate); message 'setBirthday:';

    /// The user's current location may be used to deliver more relevant ads. However do not use Core
    /// Location just for advertising, make sure it is used for more beneficial reasons as well. It is
    /// both a good idea and part of Apple's guidelines.
    procedure setLocationWithLatitude_longitude_accuracy(latitude, longitude,
     accuracyInMeters: CGFloat);
      message 'setLocationWithLatitude:longitude:accuracy:';

    // / [Optional] This method allows you to specify whether you would like your app to be treated as
    /// child-directed for purposes of the Children’s Online Privacy Protection Act (COPPA),
    /// http:///business.ftc.gov/privacy-and-security/childrens-privacy.
    ///
    /// If you call this method with YES, you are indicating that your app should be treated as
    /// child-directed for purposes of the Children’s Online Privacy Protection Act (COPPA). If you call
    /// this method with NO, you are indicating that your app should not be treated as child-directed
    /// for purposes of the Children’s Online Privacy Protection Act (COPPA). If you do not call this
    /// method, ad requests will include no indication of how you would like your app treated with
    /// respect to COPPA.
    ///
    /// By setting this method, you certify that this notification is accurate and you are authorized to
    /// act on behalf of the owner of the app. You understand that abuse of this setting may result in
    /// termination of your Google account.
    ///
    /// It may take some time for this designation to be fully implemented in applicable Google
    /// services. This designation will only apply to ad requests for which you have set this method.
    procedure tagForChildDirectedTreatment(childDirectedTreatment: LongBool);
      message 'tagForChildDirectedTreatment:';

    // Contextual Information

    /// Array of keyword strings. Keywords are words or phrases describing the current user activity
    /// such as @"Sports Scores" or @"Football". Set this property to nil to clear the keywords.
    function keywords: NSArray; message 'keywords';
    procedure setKeywords(AArray: NSArray); message 'setKeywords:';

    /// URL string for a webpage whose content matches the app content. This webpage content is used for
    /// targeting purposes.
    function contentURL: NSString; message 'contentURL';
    procedure setContentURL(AURL: NSString); message 'setContentURL:';

    // Request Agent Information

    /// String that identifies the ad request's origin. Third party libraries that reference the Mobile
    /// Ads SDK should set this property to denote the platform from which the ad request originated.
    /// For example, a third party ad network called "CoolAds network" that is mediating requests to the
    /// Mobile Ads SDK should set this property as "CoolAds".
    function requestAgent: NSString; message 'requestAgent';
    procedure setRequestAgent(AAgent: NSString); message 'setRequestAgent:';

    // Deprecated Methods

    /// Provide the user's birthday to increase ad relevancy.
    {- (void)setBirthdayWithMonth:(NSInteger)month
                           day:(NSInteger)day
                          year:(NSInteger)year
      GAD_DEPRECATED_MSG_ATTRIBUTE(" use the birthday property.");
    }
    /// When Core Location isn't available but the user's location is known supplying it here may
    /// deliver more relevant ads. It can be any free-form text such as @"Champs-Elysees Paris" or
    /// @"94041 US".
    {- (void)setLocationWithDescription:(NSString *GAD_NULLABLE_TYPE)locationDescription
      GAD_DEPRECATED_MSG_ATTRIBUTE(" use setLocationWithLatitude:longitude:accuracy:.");}
  end;


//  GADInAppPurchaseDelegate.h

type
  //  Default Purchase Flow

  GADDefaultInAppPurchase = objcclass;
  GADInAppPurchase = objcclass;

  /// In-app purchase delegate protocol for default purchase handling. The delegate must deliver
  /// the purchased item then call the GADDefaultInAppPurchase object's finishTransaction method.
  GADDefaultInAppPurchaseDelegate = objcprotocol
  required
    /// Called when the user successfully paid for a purchase. You must first deliver the purchased
    /// item to the user, then call defaultInAppPurchase's finishTransaction method.
    procedure userDidPayForPurchase(defaultInAppPurchase: GADDefaultInAppPurchase); message  'userDidPayForPurchase:';
  optional
    /// Called when the user clicks on the buy button of an in-app purchase ad. Return YES if the
    /// default purchase flow should be started to purchase the item, otherwise return NO. If not
    /// implemented, defaults to YES.
    procedure shouldStartPurchaseForProductID_quantity(productID: NSString; quantity: NSInteger);
      message 'shouldStartPurchaseForProductID:quantity:';
  end;

  // Custom Purchase Flow

  /// In-app purchase delegate protocol for custom purchase handling. The delegate must handle the
  /// product purchase flow then call the GADInAppPurchase object's reportPurchaseStatus: method.
  GADInAppPurchaseDelegate = objcprotocol
    /// Called when the user clicks on the buy button of an in-app purchase ad. After the receiver
    /// handles the purchase, it must call the GADInAppPurchase object's reportPurchaseStatus: method.
    procedure didReceiveInAppPurchase(purchase: GADInAppPurchase); message 'didReceiveInAppPurchase:';
  end;

  //  GADInAppPurchase.h

  //  Default Purchase Flow

  /// The consumable in-app purchase item that has been purchased by the user. The purchase flow is
  /// handled by the Google Mobile Ads SDK.
  /// Instances of this class are created and passed to your in-app purchase delegate after the user
  /// has successfully paid for a product. Your code must correctly deliver the product to the user
  /// and then call the didCompletePurchase method to finish the transaction.
  GADDefaultInAppPurchase = objcclass external (NSObject)

    /// Enables the default consumable product in-app purchase flow handled by the Google Mobile Ads
    /// SDK. The GADDefaultInAppPurchaseDelegate object is retained while the default purchase flow is
    /// enabled. This method adds a SKPaymentTransactionObserver to the default SKPaymentQueue.
    ///
    /// Call this method early in your application to handle unfinished transactions from previous
    /// application sessions. For example, call this method in your application delegate's
    /// application:didFinishLaunchingWithOptions: method.
    class procedure enableDefaultPurchaseFlowWithDelegate(delegate: GADDefaultInAppPurchaseDelegate);
      message 'enableDefaultPurchaseFlowWithDelegate:';

    /// Disables the default in-app purchase flow handled by the Google Mobile Ads SDK and releases the
    /// associated GADDefaultInAppPurchaseDelegate object.
    class procedure disableDefaultPurchaseFlow; message 'disableDefaultPurchaseFlow';

    /// The in-app purchase product ID.
    function productID: NSString; message 'productID';

    /// The product quantity.
    function quantity: NSInteger; message 'quantity';

    /// The purchased item's completed payment transaction. Your application can use this property's
    /// data to save a permanent record of the completed payment. The default purchase flow will finish
    /// the transaction on your behalf. Do not finish the transaction yourself.
    function paymentTransaction: SKPaymentTransaction; message 'paymentTransaction';

    /// The in-app purchase delegate object must first deliver the user's item and then call this
    /// method. Failure to call this method will result in duplicate purchase notifications.
    procedure finishTransaction; message 'finishTransaction';
  end;

  // Custom Purchase Flow

  /// Enum of the different statuses resulting from processing a purchase.
  GADInAppPurchaseStatus = NSInteger;

  /// The in-app purchase item to be purchased with the purchase flow handled by you, the
  /// application developer.
  /// Instances of this class are created and passed to your GADInAppPurchaseDelegate object when
  /// users click a buy button. It is important to report the result of the purchase back to the SDK
  /// in order to track metrics about the transaction.
  GADInAppPurchase = objcclass external (NSObject)

    /// The in-app purchase product ID.
    function productID: NSString; message 'productID';

    /// The product quantity.
    function quantity: NSInteger; message 'quantity';

    /// The GADInAppPurchaseDelegate object must call this method after handling the in-app purchase for
    /// both successful and unsuccessful purchase attempts. This method reports ad conversion and
    /// purchase status information to Google.
    procedure reportPurchaseStatus(purchaseStatus: GADInAppPurchaseStatus);
      message 'reportPurchaseStatus:';
  end;

const
  kGADInAppPurchaseStatusError = 0;          ///< Error occured while processing the purchase.
  kGADInAppPurchaseStatusSuccessful = 1;     ///< Purchase was completed successfully.
  kGADInAppPurchaseStatusCancel = 2;         ///< Purchase was cancelled by the user.
  kGADInAppPurchaseStatusInvalidProduct = 3; ///< Error occured while looking up the product.

//  GADBannerViewDelegate.h
type
  GADBannerView = objcclass;

  /// Delegate methods for receiving GADBannerView state change messages such as ad request status
  /// and ad click lifecycle.
  GADBannerViewDelegate = objcprotocol (GADAdDelegate)
  optional
   // Ad Request Lifecycle Notifications

    /// Tells the delegate that an ad request successfully received an ad. The delegate may want to add
    /// the banner view to the view hierarchy if it hasn't been added yet.
    procedure adViewDidReceiveAd(bannerView: GADBannerView); message 'adViewDidReceiveAd:';

    /// Tells the delegate that an ad request failed. The failure is normally due to network
    /// connectivity or ad availablility (i.e., no fill).
    procedure adView_didFailToReceiveAdWithError(bannerView: GADBannerView;
      error: GADRequestError); message 'adView:didFailToReceiveAdWithError:';

   // Click-Time Lifecycle Notifications

    /// Tells the delegate that a full screen view will be presented in response to the user clicking on
    /// an ad. The delegate may want to pause animations and time sensitive interactions.
    procedure adViewWillPresentScreen(bannerView: GADBannerView); message 'adViewWillPresentScreen:';

    /// Tells the delegate that the full screen view will be dismissed.
    procedure adViewWillDismissScreen(bannerView: GADBannerView); message 'adViewWillDismissScreen:';

    /// Tells the delegate that the full screen view has been dismissed. The delegate should restart
    /// anything paused while handling adViewWillPresentScreen:.
    procedure adViewDidDismissScreen(bannerView: GADBannerView); message 'adViewDidDismissScreen:';

    /// Tells the delegate that the user click will open another app, backgrounding the current
    /// application. The standard UIApplicationDelegate methods, like applicationDidEnterBackground:,
    /// are called immediately before this method is called.
    procedure adViewWillLeaveApplication(bannerView: GADBannerView); message 'adViewWillLeaveApplication:';

  end;


//  GADAdSizeDelegate.h

  /// The class implementing this protocol will be notified when the DFPBannerView changes ad size.
  /// Any views that may be affected by the banner size change will have time to adjust.
  GADAdSizeDelegate = objcprotocol
    /// Called before the ad view changes to the new size.
    procedure adView_willChangeAdSizeTo(bannerView: GADBannerView; size: GADAdSize);
      message 'adView:willChangeAdSizeTo:';
  end;

//  GADBannerView.h

/// The view that displays banner ads. A minimum implementation to get an ad from within a
/// UIViewController class is:
///
///   \code
///   var
///      adView : GADBannerView
///   begin
///      // Create and setup the ad view, specifying the size and origin at {0, 0}.
///      adView := GADBannerView.alloc.initWithAdSize(kGADAdSizeBanner);
///      adView.rootViewController := self;
///      adView.adUnitID := NSSTR('ID created when registering your app');
///
///      // Place the ad view onto the screen.
///      self.view.addSubview(adView);
///
///      // Request an ad without any additional targeting information.
///      adView.loadRequest(GADRequest.request);
///   \endcode
///

  GADBannerView = objcclass external (UIView)
  public
   // Initialization

    /// Initializes and returns a banner view with the specified ad size and origin relative to the
    /// banner's superview.
    function initWithAdSize_origin(adSize:GADAdSize;origin:CGPoint): GADBannerView; message 'initWithAdSize:origin:';

    /// Initializes and returns a banner view with the specified ad size placed at its superview's
    /// origin.
    function initWithAdSize(adSize:GADAdSize): GADBannerView; message 'initWithAdSize:';

   // Pre-Request

    /// Required value created on the AdMob website. Create a new ad unit for every unique placement of
    /// an ad in your application. Set this to the ID assigned for this placement. Ad units are
    /// important for targeting and statistics.
    ///
    /// Example AdMob ad unit ID: @"ca-app-pub-0123456789012345/0123456789"
    //@property(nonatomic, copy, GAD_NULLABLE) IBInspectable NSString *adUnitID;
    function adUnitID: NSString; message 'adUnitID';
    procedure setAdUnitID(AadUnitID: NSString); message 'setAdUnitID:';

    /// Required reference to the current root view controller. For example the root view controller in
    /// tab-based application would be the UITabViewController.
    //property(nonatomic, weak, GAD_NULLABLE) IBOutlet UIViewController *rootViewController;
    function rootViewController: UIViewController; message 'rootViewController';
    procedure setRootViewController( AController: UIViewController); message 'setRootViewController:';

    /// Required to set this banner view to a proper size. Never create your own GADAdSize directly. Use
    /// one of the predefined standard ad sizes (such as kGADAdSizeBanner), or create one using the
    /// GADAdSizeFromCGSize method. If not using mediation, then changing the adSize after an ad has
    /// been shown will cause a new request (for an ad of the new size) to be sent. If using mediation,
    /// then a new request may not be sent.
    function adSize: GADAdSize; message 'adSize';
    procedure setAdSize(adSize: GADAdSize); message 'setAdSize:';

    /// Optional delegate object that receives state change notifications from this GADBannerView.
    /// Typically this is a UIViewController.
    //@property(nonatomic, weak, GAD_NULLABLE) IBOutlet id<GADBannerViewDelegate> delegate;
    function delegate: GADBannerViewDelegate; message 'delegate';
    procedure setDelefate(adelegate: GADBannerViewDelegate); message 'setDelegate:';

    /// Optional delegate object that receives in-app purchase notifications from this ad. Required for
    /// the custom in-app purchase flow, but ignored when using the default in-app purchase flow.
    //@property(nonatomic, weak, GAD_NULLABLE)
       //IBOutlet id<GADInAppPurchaseDelegate> inAppPurchaseDelegate;
    function inAppPurchaseDelegate: GADInAppPurchaseDelegate; message 'inAppPurchaseDelegate';
    procedure setInAppPurchaseDelegate(adelegate: GADInAppPurchaseDelegate); message 'setInAppPurchaseDelegate:';

    /// Optional delegate that is notified when creatives cause the banner to change size.
    //@property(nonatomic, weak, GAD_NULLABLE) IBOutlet id<GADAdSizeDelegate> adSizeDelegate;
    function adSizeDelegate: GADAdSizeDelegate; message 'GADAdSizeDelegate';
    procedure setAdSizeDelegate(adelegate: GADAdSizeDelegate); message 'setAdSizeDelegate:';

    // Making an Ad Request

    /// Makes an ad request. The request object supplies targeting information.
    procedure loadRequest(request: GADRequest); message 'loadRequest:';

    /// A Boolean value that determines whether autoloading of ads in the receiver is enabled. If
    /// enabled, you do not need to call the loadRequest: method to load ads.

    //@property(nonatomic, assign, getter=isAutoloadEnabled) IBInspectable BOOL autoloadEnabled;
    function autoloadEnabled: LongBool; message 'isAutoloadEnabled';
    procedure setAutoloadEnabled(AEnableD: LongBool); message 'setAutoloadEnabled:';

   // Mediation

    /// The ad network class name that fetched the current ad. Returns nil while the latest ad request
    /// is in progress or if the latest ad request failed. For both standard and mediated Google AdMob
    /// ads, this method returns @"GADMAdapterGoogleAdMobAds". For ads fetched via mediation custom
    /// events, this method returns @"GADMAdapterCustomEvents".
    function adNetworkClassName: NSString; message 'adNetworkClassName';


   // Deprecated

    /// Indicates if the currently displayed ad (or most recent failure) was a result of auto refreshing
    /// as specified on server. This property is set to NO after each loadRequest: method.
    //@property(nonatomic, readonly, assign) BOOL hasAutoRefreshed GAD_DEPRECATED_ATTRIBUTE;
    function hasAutoRefreshed: LongBool; message 'hasAutoRefreshed'; deprecated;

    /// The mediated ad network's underlying ad view. You may use this property to read the ad's actual
    /// size and adjust this banner view's frame origin. However, modifying the banner view's frame size
    /// triggers the Mobile Ads SDK to request a new ad. Only update the banner view's frame origin.
    //@property(nonatomic, readonly, weak, GAD_NULLABLE)
    //UIView *mediatedAdView GAD_DEPRECATED_MSG_ATTRIBUTE("Use adNetworkClassName.");
    function mediatedAdView: UIView; message 'mediatedAdView'; deprecated;

  end;

//  GADInterstitialDelegate.h
type

  GADInterstitial = objcclass;

  /// Delegate for receiving state change messages from a GADInterstitial such as interstitial ad
  /// requests succeeding/failing.
  GADInterstitialDelegate = objcprotocol(GADAdDelegate)
  optional
    // Ad Request Lifecycle Notifications

    /// Called when an interstitial ad request succeeded. Show it at the next transition point in your
    /// application such as when transitioning between view controllers.
    procedure interstitialDidReceiveAd(ad: GADInterstitial); message 'interstitialDidReceiveAd:';

    /// Called when an interstitial ad request completed without an interstitial to
    /// show. This is common since interstitials are shown sparingly to users.
    procedure interstitial_didFailToReceiveAdWithError(ad: GADInterstitial;
      error : GADRequestError); message 'interstitial:didFailToReceiveAdWithError:';

    // Display-Time Lifecycle Notifications

    /// Called just before presenting an interstitial. After this method finishes the interstitial will
    /// animate onto the screen. Use this opportunity to stop animations and save the state of your
    /// application in case the user leaves while the interstitial is on screen (e.g. to visit the App
    /// Store from a link on the interstitial).
    procedure interstitialWillPresentScreen(ad: GADInterstitial);
      message 'interstitialWillPresentScreen:';

    /// Called when |ad| fails to present.
    //- (void)interstitialDidFailToPresentScreen:(GADInterstitial *)ad;
    procedure interstitialDidFailToPresentScreen(ad: GADInterstitial);
      message 'interstitialDidFailToPresentScreen:';

    /// Called before the interstitial is to be animated off the screen.
    procedure interstitialWillDismissScreen(ad: GADInterstitial);
      message 'interstitialWillDismissScreen:';

    /// Called just after dismissing an interstitial and it has animated off the screen.
    procedure interstitialDidDismissScreen(ad: GADInterstitial);
      message 'interstitialDidDismissScreen:';

    /// Called just before the application will background or terminate because the user clicked on an
    /// ad that will launch another application (such as the App Store). The normal
    /// UIApplicationDelegate methods, like applicationDidEnterBackground:, will be called immediately
    /// before this.
    procedure interstitialWillLeaveApplication(ad: GADInterstitial);
      message 'interstitialWillLeaveApplication:';
  end;

//  GADInterstitial.h
  /// An interstitial ad. This is a full-screen advertisement shown at natural transition points in
  /// your application such as between game levels or news stories.
  GADInterstitial = objcclass external(NSObject)

    /// Initializes an interstitial with an ad unit created on the AdMob website. Create a new ad unit
    /// for every unique placement of an ad in your application. Set this to the ID assigned for this
    /// placement. Ad units are important for targeting and statistics.
    ///
    /// Example AdMob ad unit ID: @"ca-app-pub-0123456789012345/0123456789"
    function initWithAdUnitID(adUnitID: NSString): GADInterstitial; message 'initWithAdUnitID:';

    // Pre-Request

    /// Required value passed in with initWithAdUnitID:.
    function adUnitID: NSString; message 'adUnitID';

    /// Optional delegate object that receives state change notifications from this GADInterstitalAd.
    function delegate: GADInterstitialDelegate; message 'delegate';
    procedure setDelegate(adelegate: GADInterstitialDelegate); message 'setDelegate:';

    /// Optional delegate object that receives in-app purchase notifications from this ad. Required for
    /// the custom in-app purchase flow, but ignored when using the default in-app purchase flow.
    function inAppPurchaseDelegate: GADInAppPurchaseDelegate; message 'inAppPurchaseDelegate';
    procedure setInAppPurchaseDelegate(adelegate: GADinAppPurchaseDelegate); message 'setInAppPurchaseDelegate:';

    // Making an Ad Request

    /// Makes an interstitial ad request. Additional targeting options can be supplied with a request
    /// object. Only one interstitial request is allowed at a time.
    ///
    /// This is best to do several seconds before the interstitial is needed to preload its content.
    /// Then when transitioning between view controllers show the interstital with
    /// presentFromViewController.
    procedure loadRequest(arequest: GADRequest); message 'loadRequest:';

    // Post-Request

    /// Returns YES if the interstitial is ready to be displayed. The delegate's
    /// interstitialAdDidReceiveAd: will be called after this property switches from NO to YES.
    function isReady: LongBool; message 'isReady';

    /// Returns YES if this object has already been presented. Interstitial objects can only be used
    /// once even with different requests.
    function hasBeenUsed: LongBool; message 'hasBeenUsed';

    /// Returns the ad network class name that fetched the current ad. Returns nil while the latest ad
    /// request is in progress or if the latest ad request failed. For both standard and mediated Google
    /// AdMob ads, this method returns @"GADMAdapterGoogleAdMobAds". For ads fetched via mediation
    /// custom events, this method returns @"GADMAdapterCustomEvents".
    function adNetworkClassName: NSString; message 'adNetworkClassName';

    /// Presents the interstitial ad which takes over the entire screen until the user dismisses it.
    /// This has no effect unless isReady returns YES and/or the delegate's interstitialDidReceiveAd:
    /// has been received.
    ///
    /// Set rootViewController to the current view controller at the time this method is called. If your
    /// application does not use view controllers pass in nil and your views will be removed from the
    /// window to show the interstitial and restored when done. After the interstitial has been removed,
    /// the delegate's interstitialDidDismissScreen: will be called.
    procedure presentFromRootViewController(rootViewController: UIViewController);
      message 'presentFromRootViewController:';

   // Deprecated
  {
/// Deprecated intializer. Use initWithAdUnitID: instead.
- (instancetype)init GAD_DEPRECATED_MSG_ATTRIBUTE("Use initWithAdUnitID:.");

/// Deprecated setter, use initWithAdUnitID: instead.
- (void)setAdUnitID:(NSString *GAD_NULLABLE_TYPE)adUnitID
    GAD_DEPRECATED_MSG_ATTRIBUTE("Use initWithAdUnitID: instead of setting the ad unit ID.");
}
  end;

implementation

function GAD_SIZE_320x50: CGSize;
begin
  Result:=CGSizeFromGADAdSize(kGADAdSizeBanner);
end;

function GAD_SIZE_320x100: CGSize;
begin
  Result:=CGSizeFromGADAdSize(kGADAdSizeLargeBanner);
end;

function GAD_SIZE_300x250: CGSize;
begin
  Result:=CGSizeFromGADAdSize(kGADAdSizeMediumRectangle);
end;

function GAD_SIZE_468x60: CGSize;
begin
  Result:=CGSizeFromGADAdSize(kGADAdSizeFullBanner);
end;

function GAD_SIZE_728x90: CGSize;
begin
  Result:=CGSizeFromGADAdSize(kGADAdSizeLeaderboard);
end;

function GAD_SIZE_120x600: CGSize;
begin
  Result:=CGSizeFromGADAdSize(kGADAdSizeSkyscraper);
end;

end.

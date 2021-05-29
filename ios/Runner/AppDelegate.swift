import UIKit
import Flutter
import workmanager
import shared_preferences
import flutter_app_badger

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    /// Registers all pubspec-referenced Flutter plugins in the given registry.
//    static func registerPlugins(with registry: FlutterPluginRegistry) {
//        GeneratedPluginRegistrant.register(with: registry)
//    }
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // Other intialization code…
    UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*60))
    
//    AppDelegate.registerPlugins(with: self)
    
    WorkmanagerPlugin.setPluginRegistrantCallback { registry in
        // The following code will be called upon WorkmanagerPlugin's registration.
        // Note : all of the app's plugins may not be required in this context ;
        // instead of using GeneratedPluginRegistrant.register(with: registry),
        // you may want to register only specific plugins.
        
        FLTSharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "io.flutter.plugins.sharedpreferences")!)
        FlutterAppBadgerPlugin.register(with: registry.registrar(forPlugin: "fr.g123k.flutterappbadger.FlutterAppBadgerPlugin")!)
    }
    
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

import Foundation
import SwiftUI
import UIKit

extension AppNavigator {
    public var navigator: AppNavigationer {
        return AppNavigationer.shared
    }
}

public struct AppNavigationer {
    fileprivate static let shared = AppNavigationer()
    public init() {}
    
    
    public func pushToView<T: View>(view: T, animated: Bool? = nil) {
        let nav = AppNavigationer.getCurrentNavigationController()
        nav?.pushViewController(UIHostingController(rootView: view), animated: animated ?? true)
    }
    
    public func pop(animated: Bool? = nil) {
        let nav = AppNavigationer.getCurrentNavigationController()
        nav?.popViewController(animated: animated ?? true)
    }
    
    private static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        
        if let navitationController = viewController as? UINavigationController {
            return navitationController
        }
        
        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
        
        return nil
    }
    
    private static func getCurrentNavigationController() -> UINavigationController? {
        let nav = findNavigationController(viewController: UIApplication.shared.windows.filter{ $0.isKeyWindow }.first?.rootViewController)
        return nav
    }
}

//
//  EntNetworkReachabilityListener.swift
//  EntCore
//
//  Created by Hasolas on 5.06.2022.
//

import Foundation
import Reachability

public protocol EntNetworkReachabilityListenerProtocol {
    func isReachable() -> Bool
    func onReachable(_ callback: @escaping ((_ reachability: Reachability) -> Void))
}

public extension Notification.Name {
    static let reachabilityChanged = Notification.Name("reachabilityChanged")
}

public class EntNetworkReachabilityListener: EntNetworkReachabilityListenerProtocol {
    var reachability: Reachability?
    
    public init() {
        do {
            self.reachability = try Reachability()
            try self.reachability?.startNotifier()
        } catch {
            NSLog("Cannot initialize network reachability listener. Error message: %@", error.localizedDescription)
        }
    }
    
    public func isReachable() -> Bool {
        return self.reachability?.connection != .unavailable
    }
    
    public func onReachable(_ callback: @escaping ((_ reachability: Reachability) -> Void)) {
        self.reachability?.whenReachable = callback
    }
    
}

//
//  Notifications.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

protocol NotificationName {
    var name: Notification.Name { get }
}

extension NotificationName where Self: RawRepresentable, Self.RawValue == String {
    var name: Notification.Name {
        get { return Notification.Name(self.rawValue) }
    }
}

enum Notifications {
    
    public enum Network: String, NotificationName {
        case reachable = "ReachableNetworkNotification"
        case unreachable = "UnreachableNetworkNotification"
    }
    
    enum Notification: String, NotificationName {
        case object = "ObjectNotification"
    }
}

//MARK: - Notifications Management

extension NotificationCenter {
    public class func postNotification(_ notification: Any?, withName name: Notification.Name) {
        NotificationCenter.default.post(name: name, object: nil, userInfo: self.construct(with: notification))
    }
    
    public class func postAsyncNotification(_ notification: Any?, withName name: Notification.Name) {
        let newNotification: Notification = Notification(name: name, object: nil, userInfo: self.construct(with: notification))
        NotificationQueue.default.enqueue(newNotification, postingStyle: .asap)
    }
    
    //MARK: - Private Methods
    
    private class func construct(with objectNotification: Any?) -> [String: Any]? {
        guard let object: Any = objectNotification else { return nil }
        return [Notifications.Notification.object.rawValue : object]
    }
}

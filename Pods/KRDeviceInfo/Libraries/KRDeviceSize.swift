//
//  KRDeviceSize.swift
//  DeviceInfo
//
//  Created by Sergey Nikolaev on 15.11.15.
//  Copyright © 2015 Sergey Nikolaev. All rights reserved.
//

import UIKit

public enum KRDeviceSize {
    case inch3_5
    case inch4
    case inch4_7
    case inch5_5
    
    public var scale: CGFloat {return UIScreen.main.scale}
    
    public var pixelsSize: CGSize {
        return CGSize(width: self.size.width*self.scale, height: self.size.height*self.scale)
    }
    
    public var size: CGSize {
        switch self {
        case .inch3_5: return CGSize(width: 320, height: 480)
        case .inch4:   return CGSize(width: 320, height: 568)
        case .inch4_7: return CGSize(width: 375, height: 667)
        case .inch5_5: return CGSize(width: 414, height: 736)
        }
    }
    
    public init? () {
        let size = UIScreen.main.bounds.size
        
        let width   = min(size.width, size.height)
        let height  = max(size.width, size.height)
        
        switch CGSize(width: width, height: height) {
        case KRDeviceSize.inch3_5.size:     self = KRDeviceSize.inch3_5
        case KRDeviceSize.inch4.size:       self = KRDeviceSize.inch4
        case KRDeviceSize.inch4_7.size:     self = KRDeviceSize.inch4_7
        case KRDeviceSize.inch5_5.size:     self = KRDeviceSize.inch5_5
            
        default: return nil
        }
    }
    
    public var description: String {
        switch self {
        case .inch3_5:  return "3.5 inch"
        case .inch4:    return "4 inch"
        case .inch4_7:  return "4.7 inch"
        case .inch5_5:  return "5.5 inch"
        }
    }
    
    public func getScreenValue<T> (value3_5: T! = nil, value4: T, value4_7: T, value5_5: T) -> T {
        switch self {
        case .inch3_5:     return value3_5 ?? value4
        case .inch4:       return value4
        case .inch4_7:     return value4_7
        case .inch5_5:     return value5_5
        }
    }
    
    static public func getScreenValue<T> (value3_5: T! = nil, value4: T, value4_7: T, value5_5: T, defaultValue: T) -> T {
        guard let screen = KRDeviceSize() else {return defaultValue}
        return screen.getScreenValue(value3_5: value3_5, value4: value4, value4_7: value4_7, value5_5: value5_5)
    }
}

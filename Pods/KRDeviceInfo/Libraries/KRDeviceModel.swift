//
//  KRDeviceModel.swift
//  DeviceInfo
//
//  Created by Sergey Nikolaev on 14.11.15.
//  Copyright © 2015 Sergey Nikolaev. All rights reserved.
//

import Foundation

public enum KRDeviceModel: Int {
    case unknown       = 0
    case simulator
    //---iPhone
    case iPhone4
    
    case iPhone4S
    
    case iPhone5
    
    case iPhone5C
    case iPhone5S
    
    case iPhone6
    case iPhone6Plus
    
    case iPhone6S
    case iPhone6SPlus
    
    case iPhoneSE
    
    case iPhone7
    case iPhone7Plus
    //---iPad
    case iPad1
    case iPad2
    case iPad3
    case iPad4
    
    case iPadMini1
    case iPadMini2
    case iPadMini3
    case iPadMini4
    
    case iPadAir1
    case iPadAir2
    
    case iPadPro
    //---iPod
    case iPodTouch1
    case iPodTouch2
    case iPodTouch3
    case iPodTouch4
    case iPodTouch5
    case iPodTouch6
    
    public static var allCases: [KRDeviceModel] {
        var i = -1
        return Array( AnyIterator{i += 1;return self.init(rawValue: i)})
    }
    
    public init () {
        let identifier = KRGetDeviceMachineName()
        
        let all = KRDeviceModel.allCases
        
        for device in all {
            if device.machineNames.contains(identifier) {
                self = device
                return
            }
        }
        
        self = .unknown
    }
    
    public var machineNames: [String] {
        switch self {
            
        case .unknown: return []
        case .simulator:        return ["i386", "x86_64"]
            
        //----iPhone
        case .iPhone4:          return ["iPhone3,1", "iPhone3,2", "iPhone3,3"]
            
        case .iPhone4S:         return ["iPhone4,1", "iPhone4,2", "iPhone4,3"]
            
        case .iPhone5:          return ["iPhone5,1", "iPhone5,2"]
        case .iPhone5C:         return ["iPhone5,3", "iPhone5,4"]
            
        case .iPhone5S:         return ["iPhone6,1", "iPhone6,2"]
            
        case .iPhone6:          return ["iPhone7,2"]
        case .iPhone6Plus:      return ["iPhone7,1"]
            
        case .iPhone6S:         return ["iPhone8,1"]
        case .iPhone6SPlus:     return ["iPhone8,2"]
            
        case .iPhoneSE:         return ["iPhone8,4"]
            
        case .iPhone7:          return ["iPhone9,1", "iPhone9,3"]
        case .iPhone7Plus:      return ["iPhone9,2", "iPhone9,4"]
            
        //----iPad
        case .iPad1:        return ["iPad1,1"]
        case .iPad2:        return ["iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4"]
        case .iPad3:        return ["iPad3,1", "iPad3,2", "iPad3,3"]
        case .iPad4:        return ["iPad3,4", "iPad3,5", "iPad3,6"]
            
        case .iPadMini1:    return ["iPad2,5", "iPad2,6", "iPad2,7"]
        case .iPadMini2:    return ["iPad4,4", "iPad4,5", "iPad4,6"]
        case .iPadMini3:    return ["iPad4,7", "iPad4,8", "iPad4,9"]
        case .iPadMini4:    return ["iPad5,1", "iPad5,2"]
            
        case .iPadAir1:     return ["iPad4,1", "iPad4,2", "iPad4,3"]
        case .iPadAir2:     return ["iPad5,3", "iPad5,4"]
            
        case .iPadPro:      return ["iPad6,8"]
            
        //----iPod
        case .iPodTouch1: return ["iPod1,1"]
        case .iPodTouch2: return ["iPod2,1"]
        case .iPodTouch3: return ["iPod3,1"]
        case .iPodTouch4: return ["iPod4,1"]
        case .iPodTouch5: return ["iPod5,1"]
        case .iPodTouch6: return ["iPod6,1"]
        }
    }
    
    public var humanName: String {
        
        switch self {
        case .unknown:          return "Unknow device"
        case .simulator:        return "iOS Simulator"
            
        //----iPhone
        case .iPhone4:          return "iPhone 4"
            
        case .iPhone4S:         return "iPhone 4S"
            
        case .iPhone5:          return "iPhone 5"
        case .iPhone5C:         return "iPhone 5C"
            
        case .iPhone5S:         return "iPhone 5S"
            
        case .iPhone6:          return "iPhone 6"
        case .iPhone6Plus:      return "iPhone 6 Plus"
            
        case .iPhone6S:         return "iPhone 6S"
        case .iPhone6SPlus:     return "iPhone 6S Plus"
            
        case .iPhoneSE:         return "iPhone SE"
            
        case .iPhone7:          return "iPhone 7"
        case .iPhone7Plus:      return "iPhone 7 Plus"
            
        //----iPad
        case .iPad1:        return "iPad 1"
        case .iPad2:        return "iPad 2"
        case .iPad3:        return "iPad 3"
        case .iPad4:        return "iPad 4"
            
        case .iPadMini1:    return "iPad Mini"
        case .iPadMini2:    return "iPad Mini 2"
        case .iPadMini3:    return "iPad Mini 3"
        case .iPadMini4:    return "iPad Mini 4"
            
        case .iPadAir1:     return "iPad Air"
        case .iPadAir2:     return "iPad Air 2"
            
        case .iPadPro:      return "iPad Pro"
            
        //----iPod
        case .iPodTouch1: return "iPod Touch 1"
        case .iPodTouch2: return "iPod Touch 2"
        case .iPodTouch3: return "iPod Touch 3"
        case .iPodTouch4: return "iPod Touch 4"
        case .iPodTouch5: return "iPod Touch 5"
        case .iPodTouch6: return "iPod Touch 6"
        }
    }
    
}

public func KRGetDeviceMachineName () -> String {
    var systemInfo = utsname()
    uname(&systemInfo)
    
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    return identifier
}

/*
 case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
 case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
 */

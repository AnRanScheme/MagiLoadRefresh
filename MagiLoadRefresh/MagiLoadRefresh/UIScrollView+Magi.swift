
//
//  UIScrollView+PlaceHolder.swift
//  magiLoadingPlaceHolder
//
//  Created by 安然 on 2018/7/30.
//  Copyright © 2018年 anran. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    struct RuntimeKey {
        static let magiPlaceHolder = UnsafeRawPointer.init(
            bitPattern: "magiPlaceHolder".hashValue)
        
    }
    
    var magi: Magi {
        set {
            objc_setAssociatedObject(
                self,
                RuntimeKey.magiPlaceHolder!,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if magi.scrollView == nil {
                magi.scrollView = self
            }
        }
        get {
            if let objc = objc_getAssociatedObject(
                self,
                RuntimeKey.magiPlaceHolder!)
                as? Magi {
                return objc
            }
            else {
                let objc = Magi()
                self.magi = objc
                return objc
            }
        }
    }
    
}

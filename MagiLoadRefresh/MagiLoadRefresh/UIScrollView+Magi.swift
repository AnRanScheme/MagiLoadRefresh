
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
    
    var magiLoad: Magi {
        set {
            objc_setAssociatedObject(
                self,
                RuntimeKey.magiPlaceHolder!,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if magiLoad.scrollView == nil {
                magiLoad.scrollView = self
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
                self.magiLoad = objc
                return objc
            }
        }
    }
    
}


extension UIScrollView {

    public var offsetX: CGFloat {
        get {
            return self.contentOffset.x
        }
        set {
            var contentOffset = self.contentOffset
            contentOffset.x = newValue
            self.contentOffset = contentOffset
        }
    }

    public var offsetY: CGFloat {
        get {
            return self.contentOffset.y
        }
        set {
            var contentOffset = self.contentOffset
            contentOffset.y = newValue
            self.contentOffset = contentOffset
        }
    }

    public var insetTop: CGFloat {
        get {
            return self.realContentInset.top
        }
        set{
            var inset = self.contentInset
            inset.bottom = newValue
            if #available(iOS 11.0, *) {
                inset.bottom -= (self.adjustedContentInset.top - self.contentInset.top)
            }
            self.contentInset = inset
        }
    }

    public var insetBottom: CGFloat {
        get {
            return self.realContentInset.bottom
        }
        set{
            var inset = self.contentInset
            inset.bottom = newValue
            if #available(iOS 11.0, *) {
                inset.bottom -= (self.adjustedContentInset.bottom - self.contentInset.bottom)
            }
            self.contentInset = inset
        }
    }

    public var contentHeight: CGFloat {
        return self.contentSize.height
    }

    public var realContentInset: UIEdgeInsets {
        if #available(iOS 11.0, *){
            return self.adjustedContentInset
        } else {
            return self.contentInset
        }
    }

}

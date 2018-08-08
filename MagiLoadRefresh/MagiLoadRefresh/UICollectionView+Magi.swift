//
//  UICollectionView+Magi.swift
//  magiLoadingPlaceHolder
//
//  Created by 安然 on 2018/8/6.
//  Copyright © 2018年 anran. All rights reserved.
//

import UIKit


extension UICollectionView: MagiInitAware {
    
    static func awake() {
        UICollectionView.classInit()
    }
    
    static func classInit() {
        swizzleMethod
    }
    
    private static let swizzleMethod: Void = {
        //insertSections
        let originalSelector = #selector(insertSections(_:))
        let swizzledSelector = #selector(magi_insertSections(_:))
        MagiRunTime.exchangeMethod(selector: originalSelector, replace: swizzledSelector, class: UICollectionView.self)
        
        //deleteSections
        let originalSelector1 = #selector(deleteSections(_:))
        let swizzledSelector1 = #selector(magi_deleteSections(_:))
        MagiRunTime.exchangeMethod(selector: originalSelector1, replace: swizzledSelector1, class: UICollectionView.self)
        
        //insertRows
        let originalSelector2 = #selector(insertItems(at:))
        let swizzledSelector2 = #selector(magi_insertItemsAtIndexPaths(at:))
        MagiRunTime.exchangeMethod(selector: originalSelector2, replace: swizzledSelector2, class: UICollectionView.self)
        
        //deleteRows
        let originalSelector3 = #selector(deleteItems(at:))
        let swizzledSelector3 = #selector(magi_deleteItemsAtIndexPaths(at:))
        MagiRunTime.exchangeMethod(selector: originalSelector3, replace: swizzledSelector3, class: UICollectionView.self)
        
        //reload
        let originalSelector4 = #selector(reloadData)
        let swizzledSelector4 = #selector(magi_reloadData)
        MagiRunTime.exchangeMethod(selector: originalSelector4, replace: swizzledSelector4, class: UICollectionView.self)
        
    }()
    
    //section
    @objc  func magi_insertSections(_ sections: NSIndexSet) {
        magi_insertSections(sections)
        magi.getDataAndSet()
    }
    
    @objc  func magi_deleteSections(_ sections: NSIndexSet) {
        magi_deleteSections(sections)
        magi.getDataAndSet()
    }
    
    //item
    @objc  func magi_insertItemsAtIndexPaths(at indexPaths: [IndexPath]){
        magi_insertItemsAtIndexPaths(at: indexPaths)
        magi.getDataAndSet()
    }
    
    @objc func magi_deleteItemsAtIndexPaths(at indexPaths: [IndexPath]){
        magi_deleteItemsAtIndexPaths(at: indexPaths)
        magi.getDataAndSet()
    }
    
    //reloadData
    @objc func magi_reloadData() {
        self.magi_reloadData()
        magi.getDataAndSet()
    }
}

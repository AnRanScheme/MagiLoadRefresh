//
//  PlaceHolder.swift
//  magiLoadingPlaceHolder
//
//  Created by 安然 on 2018/7/30.
//  Copyright © 2018年 anran. All rights reserved.
//

import UIKit

public typealias  MagiTapClosure = ()->()

class MagiBasePlaceHolderView: UIView {
    
    // 点击空白区域
    var tapContentViewClosure: MagiTapClosure?
    // 点击刷新按钮
    var btnClickClosure: MagiTapClosure?
    //
    var contentView: UIView = UIView()
    // 图片名字
    var imageString: String? {
        didSet {
            setupSubviews()
        }
    }
    // 标题
    var titleString: String? {
        didSet {
            setupSubviews()
        }
    }
    // 详情
    var detailString: String?
    {
        didSet {
            setupSubviews()
        }
    }
    // 按钮标题
    var btnTitleString: String?
    {
        didSet {
            setupSubviews()
        }
    }
    var target: AnyObject?
    var selector: Selector?
    // 自定义视图界面
    var customView: UIView?
    // 是否自动显隐EmptyView
    var isAutoShowPlaceHolderView: Bool = true
    
    // MARK: - 初始化方法
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepare()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare() {
        self.autoresizingMask = .flexibleWidth
        self.backgroundColor = UIColor.white
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        guard let view = self.superview else { return }
        if view.isKind(
            of: UIScrollView.classForCoder()) {
            self.frame = CGRect.init(x: 0,
                                     y: 0,
                                     width: view.width,
                                     height: view.height)
            
        }
        
        setupSubviews()
    }
    
    func setupSubviews() {
        
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        //不是UIScrollView，不做操作
        if (newSuperview is UIScrollView ) == false {
            return
        }
        if let newView = newSuperview {
            self.width = newView.width
            self.height = newView.height
        }
    }
    
   
    
}

extension MagiBasePlaceHolderView {
    
    // MARK: - target/action 响应
    public class func placeHolderActionViewWithImage(
        imageStr: String,
        titleStr: String,
        detailStr: String,
        btnTitleStr: String,
        target:AnyObject,
        action: Selector) -> MagiPlaceHolderView {
        
        let placeHolder: MagiPlaceHolderView = MagiPlaceHolderView(
            frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        
        placeHolder.creatPlaceHolderWithImage(
            imageStr: imageStr,
            titleStr: titleStr,
            detailStr: detailStr,
            btnTitleStr: btnTitleStr,
            target: target,
            action: action)
        
        return placeHolder
    }
    
    //Block 回调方法
    public class func placeHolderActionViewWithImage(
        imageStr: String,
        titleStr: String,
        detailStr: String,
        btnTitleStr: String,
        btnClickClosure:@escaping MagiTapClosure) -> MagiPlaceHolderView {
        
        let placeHolder: MagiPlaceHolderView = MagiPlaceHolderView(
            frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        
        placeHolder.creatPlaceHolderWithImage(
            imageStr: imageStr,
            titleStr: titleStr,
            detailStr: detailStr,
            btnTitleStr: btnTitleStr,
            btnClickClosure: btnClickClosure)
        
        return placeHolder
    }
    
    //自定义显示界面
    public class func placeHolderWithCustomView(customView: UIView) -> AnyObject {
        let placeHolder: MagiPlaceHolderView = MagiPlaceHolderView(
            frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        placeHolder.creatPlaceHolderWithCustomView(customView: customView)
        
        return placeHolder
    }
    
    func creatPlaceHolderWithImage(
        imageStr: String,
        titleStr: String,
        detailStr: String,
        btnTitleStr: String,
        target:AnyObject,
        action: Selector) {
        
        self.imageString = imageStr
        self.titleString = titleStr
        self.detailString = detailStr
        self.btnTitleString = btnTitleStr
        self.target = target
        self.selector = action
        
        contentView = UIView(frame: CGRect.zero)
        addSubview(contentView)
        let tap = UITapGestureRecognizer(
            target: self,
            action:#selector(tapContentView(_:)))
        contentView.addGestureRecognizer(tap)
        
    }
    
    func creatPlaceHolderWithImage(
        imageStr: String,
        titleStr: String,
        detailStr: String,
        btnTitleStr: String?,
        btnClickClosure:@escaping MagiTapClosure) {
        self.imageString = imageStr
        self.titleString = titleStr
        self.detailString = detailStr
        self.btnTitleString = btnTitleStr
        self.btnClickClosure = btnClickClosure
        
        addSubview(contentView)
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapContentView(_:)))
        contentView.addGestureRecognizer(tap)
    }
    
    func creatPlaceHolderWithImage(
        imageStr: String,
        titleStr: String,
        detailStr: String) {
        self.imageString = imageStr
        self.titleString = titleStr
        self.detailString = detailStr
        
        addSubview(contentView)
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapContentView(_:)))
        contentView.addGestureRecognizer(tap)
    }
    
    func creatPlaceHolderWithCustomView(customView: UIView) {
        addSubview(contentView)
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapContentView(_:)))
        contentView.addGestureRecognizer(tap)
        
        self.customView = customView
    }
    
    @objc func tapContentView(_ sender: UITapGestureRecognizer) {
        tapContentViewClosure?()
    }
    
}


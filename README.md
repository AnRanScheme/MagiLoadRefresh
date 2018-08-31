# MagiLoadRefresh
swift版下拉刷新,支持多种样式,同时支持,加载动画,网络错误占位(有兴趣学习如何用swift使用runtime的可以看看)
### 引言
这个小demo主要针对的UITableVIew, UICollectionVIew和UIWebview等等继承UIScrellVIew的控件,原理就是通过Runtime添加一个属性,然后在通过方法交换监听row的添加,来自动显示placeHolder,我准备了一个基本的样式,当然为了方便大家和一个app里面会有不同的样式的这种情况,我添加自定义的view添加方法.那么问题来了我为什么要写这么一个demo呢,原因是我的一个同为程序员的同学(龙哥说的就是你)说我写的展示空页面的代码太low,这就不能忍了,所以写了一个这种小工具(方便统一管理)
### git
![Untitled.gif](https://upload-images.jianshu.io/upload_images/3410830-a5073d8681ecd08f.gif?imageMogr2/auto-orient/strip)
### 基本使用
####1.自定义空界面添加

```
let emptyView = Bundle.main.loadNibNamed(
"MyEmptyView", owner: self, options: nil)?.last as! MyEmptyView
emptyView.reloadBtn.addTarget(
self,
action: #selector(reloadBtnAction(_:)),
for: .touchUpInside)
emptyView.frame = view.bounds
//空数据界面显示
let placeHolder = MagiPlaceHolder.createCustomPlaceHolderView(emptyView)
tableView.magiRefresh.placeHolder = placeHolder
tableView.magiRefresh.placeHolder?.tapBlankViewClosure = {
print("点击界面空白区域")
}
tableView.magiRefresh.showPlaceHolder()
```
注意自己创建的View一定要调用 ``` MagiPlaceHolder.createCustomPlaceHolderView(emptyView)```将view包装起来

####2.使用我写好的基本页面

```
let placeHolder = MagiPlaceHolder.createPlaceHolderViewWithAction(
imageName: "net_error_tip",
title: "暂无数据，点击重新加载",
detailTitle: "",
refreshBtnTitle: "点击刷新",
target: self,
action: #selector(reloadBtnAction))

placeHolder.titleLabTextColor = UIColor.red
placeHolder.actionBtnFont = UIFont.systemFont(ofSize: 19)
placeHolder.contentViewOffset = -50
placeHolder.actionBtnBackGroundColor = .white
placeHolder.actionBtnBorderWidth = 0.7
placeHolder.actionBtnBorderColor = UIColor.gray
placeHolder.actionBtnCornerRadius = 10
placeHolder.tapBlankViewClosure = {
print("点击空白")
}
collectionView?.magiRefresh.placeHolder = placeHolder
```
要是想了解在Siwft中使用runtime的,我就不在这里多说了,代码很简单,有想了解可以点击[这里](https://www.jianshu.com/p/b5e391080f99)

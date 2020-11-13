## 实验报告

#### 程序框架

各个ViewController的层级关系如下:

```shell
 BarController
 |
 |---NavigationController
 |		|---DiscoverVC
 |
 |---CreateVC
 |
 |---SettingVC | ProfileVC
```



#### 核心知识点

* Delegates和Protocols

  代理与协议主要用于对象之间的通信。一个可能的例子如下: 当页面中的一个按钮被点击时, 页面需要做出响应, 由于按钮本身能做的事情有限(只能改变自己的内容或状态), 因此需通知该页面的UIViewController完成响应的任务。这种通信就是通过把按钮的代理设置为该页面的UIViewController完成的, 这个过程中按钮是委托方, UIViewController是代理方。为了完成既定的任务, 代理方需要实现一些预定的方法, 也就是协议。

* 各种UIViewController的使用
  * UITabBarController
  
    用于实现底部导航栏

  * UINavigationController
  
    用于实现详情界面的进入和返回
  
  * UICollectionViewController/UITableViewController
  
    用于展示打卡记录和图片
  
* 各种UIView的使用

  * UILabel

    显示文字

  * UIButton

    跳转, 提交按钮

  * UIImageView

    显示图片

  * UISearchBar

    实现搜索栏

  * UICollectionView

    用于排版并显示打卡记录或者图片

* Core Animation的使用

  * 加载动画
  * 跳转动画
  
  
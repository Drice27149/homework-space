# 色彩与编码之True color


计算机显示色彩通常用的是Color depth，即把图片的每一个像素点用一个颜色表示。

而对每一个像素点的颜色，又使用RGB方法来组成。即由Red,Green,Blue三原色以不同的比例混合形成所要呈现的颜色。


![1](https://i.loli.net/2018/10/11/5bbf3aba6672f.png)

存储颜色的方式也有很多种，从1-bit color到24-bit color再到很多不等。不同的bit意味着用不同的字节空间来表示一个像素的颜色。而True color便是一种24bit的颜色表示方法。

在True color方法中，R，G，B，每个颜色都有八个字节的空间。由于2的24次方等于1677216，所以这种方法理论上可以表示上百万中颜色，因此也被称作"millions of colors"。


下面分别是8-bit颜色和24-bit颜色的两张图片，可以看出有细节丰富度和色彩种类的区别。

![2](https://i.loli.net/2018/10/11/5bbf3bef0fca5.png)

![3](https://i.loli.net/2018/10/11/5bbf3aba8a8d9.png)
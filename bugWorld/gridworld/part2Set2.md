### Set 2

- 1. What is the role of the instance variable sideLength?

     boxbug移动过程中产生的box的边长

- 2. What is the role of the instance variable steps?

     表示在当前的边上走了几步, 用于指明转向的时机

- 3. Why is the turn method called twice when steps becomes equal to sideLength?

     因为box的一条边走完了, 要转向90度

- 4. Why can the move method be called in the BoxBug class when there is no move method in the BoxBug code?

     因为BoxBug类继承Bug类, 而Bug类有move方法

- 5. After a BoxBug is constructed, will the size of its square pattern always be the same? Why or why not?

     一直保持一致, 因为代码就是这么写的。

- 6. Can the path a BoxBug travels ever change? Why or why not?

     会。当面前有Rock时BoxBug就会转向。

- 7. When will the value of steps be zero?	

     当BoxBug完成了一条边转向之后时, 或者是因为无法移动转向之后时。

### Set 3




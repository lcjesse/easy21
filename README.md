# easy21
研一下神经网络与机器理论与应用第四次作业(上海交通大学)

## **题目详情**

(1) Implementation of Easy21 environment

You should write an environment that implement the Easy21 game. Specifically, the environment should include a function step, which takes a state (dealer’s first card, player’s current sum) and an action (stick or hit) as inputs, and returns a next state (which may be terminal) and a reward. 

next state, reward = step (state, action)

You should treat the dealer's moves as part of the environment. In other words, i.e. calling step with a stick action will play out the dealer's cards and return the final reward and terminal state. There is no discounting (γ = 1). We will be using this environment for reinforcement learning.

(2) Q-learning in Easy21

Apply Q-learning to solve Easy21. Try different learning rates α, exploration parameter ε and episode numbers. Plot the learning curve of the return against episode number. Can you find the optimal policy in this game? Plot the optimal the state-value function using similar axes to the following figure taken from Sutton and Barto's Blackjack example.

## 思路

本次实验我使用C++语言编写easy21游戏及完成q-learning训练，使用matlab编写绘图程序。

首先是游戏中需要的几个调用函数的编写。第一次抽牌返回的是一个黑色1-10的牌，点数为正，该函数为firstdraw()，使用随机函数产生1-10的随机数返回。一般抽牌不仅需要随机抽数字，还要以2/3和1/3的概率抽黑牌和红牌，该函数为draw()，其中首先用随机函数产生0-2的随机数用来选择枚举变量color，然后感觉color来决定随机点数的正负值。

下面是关键函数step()的编写，它的输入参数为一个结构体state和一个枚举变量action。State中包含了庄家的初始牌和玩家现在的点数和两个变量。函数的输出为一个结构体stepresult，它包含了一个state和这一步的reward。在这个函数中我将玩家bust之后的player_sum置为0，而若玩家选择stick后将dealer_sum置为0。这里可以看出，之后判断一局游戏是否结束的标志就是nextstate的玩家或庄家有一方牌面为0。

在本实验中我将庄家的牌面设为了0-10的11种状态，而玩家点数和为0-21的22种状态，其中它们的0都是用来中止游戏的terminal state。故我设计的qtable为242*2的数组，行为state，列为action。

在主函数中玩家将根据探索率ε(代码中用E)和当前状态下各action所对应的q值大小做出action的选择并执行step。之后根据step的结果将更新q值并判断是否结束本局游戏并开启下一局。我共让程序训练20000个episode，每执行1000次会分别向控制台和输出文本文档打印一行胜率和这1000局的total reward，之后根据该文本文档在matlab中绘制图像。另外在所有训练完成后我取了训练效果最佳的一组参数将qtable的训练结果输出并绘制三维图。

为了研究不同学习率α(代码中用A)和探索率ε对学习效果的影响，我做了两组对照实验：

第一组固定ε为0(即训练总是寻找大的q值来选择action)，改变α来观察学习率对训练的影响，我分别取α为0、0.01、0.1、0.2、0.4、0.6、0.8、1，分别绘制了total reward关于episode的曲线和玩家胜率关于episode的曲线。值得注意的是，当α为0时qtable从不更新，即退化为了随机选择，在任意状态都是随机选择stick或hit。

第二组固定α为第一组训练最好的值αmax，分别取ε为0、0.01、0.1、0.2、0.4、0.6、0.8、1，同样绘制上述两组曲线，对比探索率对训练的影响


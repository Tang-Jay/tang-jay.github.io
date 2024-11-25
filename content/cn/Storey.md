---
title: 周二汇报
date: '2024-11-25'
categories:
  - 学习志
tags:
  - 珠海
slug: storey
disable_comments: true
---

> 汇报人：唐洁
> 内容：两个方面。第一个，初代Storey方法；第二个，变种Storey方法。围绕提出动机，如何解释，实际效果展开讲述。

# 主题：Storey方法

## 研究问题：多重假设检验

单个假设检验的思想方法是在控制第一类错误的基础上控制第二类错误，保证两类错误的概率分别能在$\alpha$和$\beta$内。

与单个假设检验相对的概念是多重假设检验。

与单个假设检验一样，多重假设检验可以看作一个检验族，它的重要任务就是控制第一类错误概率的前提下提高检验的功效，尽可能多的发现显著性检验。

多重假设检验的首要问题是怎样定义“错误”，即，错误测度。

## 研究背景：

随着科学技术的不断发展，当前生物学、医学、金融等发展背景下，高维数据不断涌现，由此导致的传统统计分析方法不再适用。多重假设检验作为分析高维数据的一个重要基础，得到了越来越多的关注。

## 研究现状：

- family-wise error rate (FWER) - Shaffer([1995](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=S+HAFFER+%2C+J.+%281995%29.+Multiple+hypothesis+testing%3A+A+review.+Annual+Review+of+Psychology+46+561%E2%80%93584.&btnG=))
- false discovery rate (FDR) - BH([1995](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=B+ENJAMINI+%2C+Y.+and+H+OCHBERG+%2C+Y.+%281995%29.+Controlling+the+false+discovery+rate%3A+A+practical+and+powerful+approach+to+multiple+testing.+J.+Roy.+Statist.+Soc.+Ser.+B+57+289%E2%80%93300.&btnG=))
- positive false discovery rate (pFDR) - Storey ([2002](https://academic.oup.com/jrsssb/article/64/3/479/7098513), [2003](https://projecteuclid.org/journals/annals-of-statistics/volume-31/issue-6/The-positive-false-discovery-rate--a-Bayesian-interpretation-and/10.1214/aos/1074290335.full))
  - Difference of Slopes Storey (DOS-Storey) - [Anica Kostic](https://arxiv.org/search/stat?searchtype=author&query=Kostic,+A) and [Piotr Fryzlewicz](https://arxiv.org/search/stat?searchtype=author&query=Fryzlewicz,+P) (2023)
- a model-free FDR-controlling  procedure - Barber and Candes (2015)
- e-value - Grunwald et al. (2020)， Shafer (2021)， Vovk and Wang (2021)， Xu et al. (2021)， Ignatiadis et al. (2022)， **Wang and Ramdas (2022)**，Dunn et al. (2023)， Xu and Ramdas (2023)
- [Stats 300C](https://candes.su.domains/teaching/stats300c/index.html) - 李冠巡老师推荐多重假设检验理论介绍

## 符号引入：

|       |   落入接受域   |   落入拒绝域   | 总数 |
| :---: | :--- | :--- | :--: |
| $H_0$ |   U   |   V：犯第一类错误的总数   |   $m_0$   |
| $H_1$ |   T：犯第二类错误的总数   |   S   |    $m_1$  |
| 总数 |   W   |   R：拒绝原假设的总个数   |  $m$    |

其中，$m$已知。$m_0$是基于 $p$ 值在不同假设下分布的差异性。U、V、T、S在检验中都是不可观察的随机变量，W、R是可观察的随机变量。

对于多个假设检验的最首要的问题是如何控制错误拒绝原假设的个数V或者犯错比率V/R。

因此，多重假设检验问题就是制定一种合理的检验法则来控制犯第一类错误的概率，并且使得检验功效达到最大。

检验法则根据错误测度不同而不同。

## 历史方法：

### FWER

- **定义**：至少出现一次假阳性事件（本为原假设判拒）$ \Pr(V \geq 1)$
- **优缺点**：

  - 优点：总体犯第一类错误控制在$\alpha$内。

  - 缺点：$m \to \infty$，犯第一类错误的概率为 $1-(1-\alpha)^m \to 1$，失控

  - 缺点：$m \to \infty$，每个假设检验的$ p$ 值要 $\leq \alpha/m$，严苛
- **Bonferroni 过程**：
  - $m$个假设检验，给定检验水平$\alpha$，
  - 设置截断点$S = \cfrac{\alpha}{m}$；
  - 如果$p_i \le S$，拒绝原假设$H_{0i}$
- **Step-down 过程**：
  - $m$个假设检验，给定检验水平$\alpha$
  - $ p$ 值排序从小到大
  - 截断点$S_i=\cfrac{\alpha}{m-i+1}$
  - 如果$p_{(i)} \le S_i \le \cfrac{\alpha}{m}$，拒绝原假设$H_{0i}$
- **Step-up 过程**：
  - $ p$ 值排序从大到小

考虑到$m \to \infty$时，犯错不可控，根据实际情况，将检验关心的问题更改为：

尽量识别出差异，能够容忍和允许在R次拒绝中发生少量的错误识别。

换而言之，允许犯错更多一点，错误测度可以再宽松一点。

因此，比起控制 $ \Pr(V \geq 1)$，现在是控制$\frac{V}{R} \leq \alpha$ 。

$\frac{V}{R} \to 0$，所有拒绝中全部判对，无失误，

$\frac{V}{R} \to 1$，所有拒绝中全部判错，全失误。

但 $R = 0$ 给定义造成困难，解决方案：（A）$E(\frac{V}{R} | R > 0) \Pr(R > 0)$ （B）$E(\frac{V}{R} | R > 0)$ （C）$\frac{E(V)}{E(R)}$ 

### FDR

- **定义**：在所有拒绝次数中错误发现的期望比例。$PFD = E(\frac{V}{R \bigvee 1}) = E(\frac{V}{R} | R > 0) \Pr(R > 0)$
- **优缺点**：
- 优点：$FDR \le \alpha$
  
- 优点：当$m=m_0$时，FWER=FDR；当$m>m_0$时，FWER > FDR；FDR比FWER宽松，检验功效大大提高。
  
- 缺点：
- **[BH](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=B+ENJAMINI+%2C+Y.+and+H+OCHBERG+%2C+Y.+%281995%29.+Controlling+the+false+discovery+rate%3A+A+practical+and+powerful+approach+to+multiple+testing.+J.+Roy.+Statist.+Soc.+Ser.+B+57+289%E2%80%93300.&btnG=)过程**：
  - $m$个假设检验，给定检验水平$\alpha$
  - $p$ 值从小到大排序
  - 找到截断点$S_i=\cfrac{i}{m}\alpha$
  - 如果$p_{(i)} \le S_i$，拒绝原假设$H_{0i}$。（换而言之，找到$p_{(\hat{k})}$， $\hat{k} = \max \{k: p_{(k)} \le \frac{k}{m} \alpha\}$， 拒绝前 $k$ 个原假设）
  - 得到相应的调整后的 $p$ 值

对截断点的选取不同，方法名称不同，如：Benjamini and Liu (1999)，Benjamin and Yekutieli (2001)，

随着对FDR控制方法的深入研究，发现在假设检验中引入**正确原假设比例的估计**$\pi_0 = \cfrac{m_0}{m}$**能提高检验的功效**，找到更多的显著变量，同时也能很好地控制第一类错误在一个合理的范围内。于是，很多研究提出对于正确原假设比例的估计方法，如：[最低斜率估计法](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=BENJAMINI+Y%EF%BC%8CHOCHBERG+Y%EF%BC%8EThe+adaptive+control+of+the+false+discovery+rate+in+multiple+hypothesis+testing+with+independent+test+statistics%5BJ%5D+%EF%BC%8E+Journal+of+Educational+Behavior+Statistics%EF%BC%8C2001%EF%BC%8C25%281%29%EF%BC%9A60-83.&btnG=)，[$\lambda$ 估计法](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=**STOREY+J+D%EF%BC%8EA+direct+approach+to+false+discovery+rates%5BJ%5D%EF%BC%8EJournal+of+the+Royal+Statistical+Society%EF%BC%8C2002%EF%BC%8C64%283%29%EF%BC%9A477-498%EF%BC%8E&btnG=)，[减密度估计法](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=LANGAAS+M%EF%BC%8CFERKINGSTAD+E%EF%BC%8CLINDQVIST+BH%EF%BC%8EEstimating+the+proportion+of+true+null+hypotheses%EF%BC%8Cwith+application+to+DNA+microarray+data%5BJ%5D%EF%BC%8EJournal+of+the+Royal+Statistical+Society%EF%BC%8C2005%EF%BC%8C67%284%29%EF%BC%9A555-572%EF%BC%8E&btnG=)。

## Storey方法:

- **想法提出** - The positive false discovery rate: A bayesian interpretation and the q-value (Storey, [2003](https://projecteuclid.org/journals/annals-of-statistics/volume-31/issue-6/The-positive-false-discovery-rate--a-Bayesian-interpretation-and/10.1214/aos/1074290335.full))

- **实现步骤** - A direct approach to false discovery rates (Stoter, [2002](https://academic.oup.com/jrsssb/article/64/3/479/7098513))

- **具体应用** - 

### pFDR

- **定义**：阳性错误拒绝率，阳性指的是基于至少拒绝一个原假设的事实。$pFDR = E(\frac{V}{R} | R > 0)$。Storey ( [2003](https://projecteuclid.org/journals/annals-of-statistics/volume-31/issue-6/The-positive-false-discovery-rate--a-Bayesian-interpretation-and/10.1214/aos/1074290335.full))
- **想法**：考虑到$m \to \infty$时，$ \Pr(R > 0) \to 1$，有 $E(\frac{V}{R} | R > 0) \Pr (R > 0) \to E(\frac{V}{R} | R > 0)$。
- **优点**：
  
  - 好解释性，在已知原假设的先验概率下，$ pFDR = \Pr (H=0|T \in \Gamma)$，当拒绝原假设时，该假设为真实原假设的概率。
  - 贝叶斯角度，$pFDR = \Pr (H=0|T \in \Gamma) = \cfrac{\pi_0 \Pr(T \in \Gamma|H=0)}{ \Pr(T \in \Gamma)} = \cfrac{\pi_0  \Pr(T \in \Gamma|H=0)}{\pi_0 \Pr(T \in \Gamma|H=0) + \pi_1 \Pr(T \in \Gamma|H=1)}$，可看出，第一类错误越小，功效函数越高，$pFDR$越小，该表达式为第一类错误[贝叶斯后验概率](https://jesseyule.github.io/machinelearning/bayesian/content.html)。
  - 实验上，比起FDR，同样的错误控制率但功效高。
  - 理论上，
  
- **缺点**：

- **$pFDR$ 与 $FDR$ 的估计** - Storey ([2002](https://academic.oup.com/jrsssb/article/64/3/479/7098513)）：

  - 将拒绝域换成$\{P \le \gamma\}$，则 $pFDR = \cfrac{\pi_0 \Pr(T \in \Gamma|H=0)}{\Pr(T \in \Gamma)} = \cfrac{\pi_0\Pr(P \le \gamma|H=0)}{ \Pr(P \le \gamma)} = \cfrac{\pi_0 \gamma }{\Pr(P \le \gamma)}$ （[为什么 P 值是均匀分布的？](https://fengchao.pro/blog/proof-that-p-values-under-the-null-are-uniformly-distributed/)）

  

  - $\hat{m}_0 = \cfrac{\#\{p_i > \lambda\}}{1-\lambda}$

  

  - $\hat{\pi}_0 = \cfrac{\hat{m}_0}{m} = \cfrac{ \#\{ p_i > \lambda\} /m }{(1-\lambda)} \triangleq \cfrac{W(\lambda) / m}{(1-\lambda)}$

    

  - $\widehat{ \Pr}(P \le \gamma) = \cfrac{ \#\{ p_i \le \gamma\} }{m} = \cfrac{R(\gamma)}{m}$

    

  - $\widehat{pFDR}_1 = \cfrac{\hat{\pi}_0 \gamma }{\widehat{ \Pr}(P \le \gamma)}= \cfrac{W(\lambda) \gamma}{(1-\lambda)R(\gamma)}$ (大样本估计)，(Storey ([2002](https://academic.oup.com/jrsssb/article/64/3/479/7098513))，Section6证明是个好的渐近估计)

    

  - $\widehat{pFDR}_2 = \cfrac{\hat{ \pi}_0 \gamma }{\widehat{\Pr}(P \le \gamma)\{1-(1-\gamma)^m \}}= \cfrac{W(\lambda) \gamma}{(1-\lambda) \{ R(\gamma) \bigvee 1 \}\{1-(1-\gamma)^m \}}$ (小样本估计)

    

  - $\widehat{FDR}_{\lambda}(\gamma) = \cfrac{\hat{\pi}_0 \gamma }{\widehat{ \Pr}(P \le \gamma)}= \cfrac{W(\lambda) \gamma}{(1-\lambda) \{ R(\gamma) \bigvee 1 \}}$ 

- **Storey过程**：

  - $m$ 个假设检验，给定检验水平$\alpha$，给定$\lambda$，计算 $ p$ 值
  - 计算 $\hat{\pi}_0(\lambda) =\cfrac{W(\lambda)}{(1-\lambda)m}$ 和 $\widehat{ \Pr}(P \le \gamma) = \cfrac{R(\gamma) \bigvee 1}{m}$，其中 $W(\lambda) = \#\{ p_i > \lambda\} $，$R(\gamma) = \#\{ p_i \le \gamma\} $
  - 计算 $\widehat{pFDR}_{\lambda}(\gamma) = \cfrac{\hat{\pi}_0 \gamma }{\widehat{\Pr}(P \le \gamma)\{1-(1-\gamma)^m \}}$ 
  - B个Bootstrap抽样，$b = 1, \dots, B$，计算 $\widehat{pFDR}_{\lambda}^{*b}(\gamma) $ 



### 借鉴Storey思想的论文：

#### 1. 使用Storey提出的$\hat{m}_0(\lambda)$作为检验过程的一环


- **ALBH过程**：
  - $m$ 个假设检验，给定检验水平$\alpha$，给定$\lambda$
  - $ p$ 值从小到大排序
  - 计算 $\hat{m}_0 = \cfrac{\#\{p_i > \lambda\}}{1-\lambda}$（$\hat{m}_0$依赖 $\lambda$ 的选取，建议取0.5或者 $ p$ 值中位数。）
  - 计算 $\alpha^* = \cfrac{m\alpha}{\hat{m}_0}$
  - 调用BH过程，以 $\alpha^* $ 代替 $\alpha$
  

#### 2. 提供Storey方法中$\lambda$的估计方法

- **DOS-Storey过程**：
  - 变点方法估计$\lambda$，$ \lambda = p_{\hat{k}} \Rightarrow \hat{m}_0 = \cfrac{\#\{p_i > p_{\hat{k}}\}}{1-p_{\hat{k}}} \Rightarrow \hat{\pi}_0(p_{\hat{k}}) = \cfrac{\# \{ p_i > p_{\hat{k}} \}/m }{(1-p_{\hat{k}})} = \cfrac{1 - \# \{ p_i \le p_{\hat{k}} \}/m }{(1-p_{\hat{k}})} = \cfrac{1 - \hat{k}/m }{(1-p_{\hat{k}})}$
  - $ \hat{\pi}_0(p_{\hat{k}}) =\cfrac{1- \hat{F}_n(p_{\hat{k}}) } {1-p_{\hat{k}}} \Rightarrow \hat{\pi}_1(p_{\hat{k}}) =\cfrac{\hat{F}_n(p_{\hat{k}}) - p_{\hat{k}}} {1-p_{\hat{k}}} = \cfrac{ \hat{k}/m  - p_{\hat{k}}}{1-p_{\hat{k}}}$
  - $\hat{k}_{\alpha} = \arg \max_{nc_n \le i \le n/2} d_{\alpha}(i) $
  - $d_{\alpha}(i) = \cfrac{p_{(2i)} - p_{(i)}}{i^{\alpha}} - \cfrac{p_{(i)}}{i^{\alpha}}$，$\alpha \in (1/2, 1)$
- **[变点方法](https://kns.cnki.net/kns8s/defaultresult/index?crossids=YSTT4HG0%2CLSTPFY1C%2CJUP3MUPD%2CMPMFIG1A%2CWQ0UVIAA%2CBLZOG7CK%2CPWFIRAGL%2CEMRPGLPA%2CNLBO1Z6R%2CNN3FJMUV&korder=SU&kw=A%20Change-Point%20Approach%20to%20Estimating%20the%20Proportion%20of%20False%20Null%20Hypotheses%20in%20Multiple%20Testing)**：
  - **定义**：在统计学中，变点指的是在某一位置或时刻，数据或观测值发生显著变化的点。在这个点之前和
    之后，数据遵循两个不同的模型或分布，反映了事物的某种特征发生了改变。（[删失回归模型中的变点问题研究](https://kns.cnki.net/kcms2/article/abstract?v=iAN2XHIMbKuxEiPhNkux31bh9rUPt1L-FlfO5YI3NhJDuPFvIjxU1SJAfSJN9RwULPuiR7NwYtnXl-hpipqTMaL3a9gu1GbW0gs6BbC_Sg5u7Y221ebWVnl6eBC5lu0CB_OVwhpHRJntGgVtfdIAFeJSI6xiy6lXlSConMDjcvIzJKLwFKTg0PdM-OBQcEX2gh8dq5yM_PVYgF6ww2Fpfw==&uniplatform=NZKPT)）
  - **意义**：对于理解和预测数据的动态变化具有重要意义。
  - **应用**：在**质量控制领域**，在生产过程中，人们往往需要监测生产数据的变化，以便及时发现并解决潜在的问题，在这种情况下，变点就可能表示生产过程中某种因素发生了改变， 比如原材料的更换、设备故障等。通过研究变点，质量控制专家可以更好地了解生产过程变化，并及时采取措施来确保产品质量。在**经济领域**，变点可以用来研究货币政策调整、股市波动等因素变化。在**医学领域**，变点可以帮助研究者更好地理解药物的疗效机制，以及制定更合理的治疗方案。变点模型用于研究气候突变、灾异事件以及地质过程的变化。通过对气候和地质数据的分析，可以识别出数据中的变点，进而了解这些自然现象的变化规律和趋势。
  - **研究方向**：一是估计变点位置，二是对变点存在性进行检验，三是检测变点个数。

## 研究空间：

- 选择更好 $\lambda$ 估计 pFDR值
- e-value代替p-value
- 应用到各种高维数据集上



## 总结：

1. Storey方法：
   - 动机：更合理的PDF度量
   - 贝叶斯解释：给定假设性下，是后验贝叶斯概率
   - 如何选择拒绝域：人为给定？
2. DOS-Storey方法：
   - 动机：给出更好的 $\hat{\pi}_0(\lambda)$ 估计
   - 区别Storey地方：$\lambda$ 取最大变点位置的 $p$ 值
   - 实际效果：应用场景广，不论稀疏或不稀疏；保持低偏差同时减少方差。




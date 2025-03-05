---
title: Wasserstein距离与经验分布
date: '2025-03-05'
categories:
  - 学习志
tags:
  - 珠海
slug: Wasserstein
disable_comments: true
---

在统计学与机器学习中，**经验分布**与**Wasserstein距离**的关系可以通过以下直观解释和具体应用来理解：



### **1. 经验分布（Empirical Distribution）**
- **定义**：经验分布是由观测数据直接构造的离散概率分布。假设有 \\(n\\) 个独立样本 \\(X_1, X_2, \dots, X_n\\)，经验分布 \\(P_n\\) 为每个样本点赋予均等的概率质量 \\(1/n\\)，即：
  \\[
  P_n = \frac{1}{n} \sum_{i=1}^n \delta_{X_i},
  \\]
  其中 \\(\delta_{X_i}\\) 是位于样本点 \\(X_i\\) 的狄拉克函数（Dirac delta）。
- **作用**：经验分布是对真实数据生成分布 \\(P\\) 的非参数估计，直接基于样本信息。



### **2. Wasserstein距离（Wasserstein Distance）**
- **定义**：Wasserstein距离（也称为推土机距离）是衡量两个概率分布之间差异的度量，其核心思想是“以最小成本将一个分布转化为另一个分布”。对于两个分布 \\(P\\) 和 \\(Q\\)，其 \\(p\\)-阶 Wasserstein距离定义为：
  \\[
  W_p(P, Q) = \left( \inf_{\gamma \in \Gamma(P, Q)} \int \|x - y\|^p \, d\gamma(x, y) \right)^{1/p},
  \\]
  其中 \\(\Gamma(P, Q)\\) 是 \\(P\\) 和 \\(Q\\) 的所有联合分布（称为运输计划），\\(\|x - y\|\\) 是点 \\(x\\) 和 \\(y\\) 之间的几何距离。
- **特点**：  
  - **几何敏感性**：Wasserstein距离考虑数据空间的几何结构（如欧氏距离），适合处理分布间的空间差异。  
  - **对低支撑分布友好**：即使两个分布的支撑集不重叠，仍能有效度量差异（与KL散度不同）。



### **3. 经验分布与Wasserstein距离的关系**
#### **(1) 投影问题（Projection）**
- **核心思想**：将经验分布 \\(P_n\\) 投影到一个特定的分布集合 \\(\mathcal{Q}\\)（例如满足某种约束的分布流形），并计算投影后的 Wasserstein 距离。
- **数学形式**：  
  假设 \\(\mathcal{Q}\\) 是某个模型假设下的分布集合（如参数模型或满足矩条件的分布），投影问题可以表示为：
  \\[
  \inf_{Q \in \mathcal{Q}} W_p(P_n, Q).
  \\]
  这一过程旨在找到与经验分布 \\(P_n\\) 最接近（在Wasserstein意义下）的分布 \\(Q \in \mathcal{Q}\\)。

#### **(2) 统计推断中的应用**
- **分布鲁棒优化（DRO）**：  
  在DRO中，通常构建一个以经验分布 \\(P_n\\) 为中心、半径为 \\(\epsilon\\) 的 Wasserstein 球作为不确定性集合：
  `$
  \mathcal{U}_\epsilon(P_n) = \{ Q \mid W_p(Q, P_n) \leq \epsilon \}
  $`。
  优化目标是最坏情况（Worst-Case）风险：
  `$
  \min_{\theta} \max_{Q \in \mathcal{U}_\epsilon (P_n)} \mathbb{E}_{Q}[\mathcal{L}(\theta; X)]
  $`。
  这种方法的鲁棒性源于对分布偏移的直接建模。
  
- **模型选择与假设检验**：  
  通过计算经验分布到某个假设分布类 \\(\mathcal{Q}\\) 的 Wasserstein 距离，可以评估模型假设的合理性。例如：
  - 若 \\(W_p(P_n, \mathcal{Q})\\) 较小，说明经验分布与假设模型 \\(\mathcal{Q}\\) 兼容；  
  - 若距离较大，则可能拒绝原假设（如数据不符合正态分布）。

#### **(3) 与KL散度投影的对比**
- **KL散度投影**：最小化 \\(KL(Q \| P_n)\\) 或 \\(KL(P_n \| Q)\\)，倾向于匹配概率质量的比例，但对分布的几何结构不敏感。  
- **Wasserstein投影**：最小化分布间的几何运输成本，适合需要保留数据空间关系的场景（如图像生成、空间数据分析）。



### **4. 具体例子**
#### **例1：鲁棒机器学习模型训练**
- **问题**：训练一个分类器，使其对输入数据的分布偏移（如光照变化、噪声）具有鲁棒性。  
- **方法**：使用 Wasserstein DRO，构建以训练数据经验分布 \\(P_n\\) 为中心的不确定性集合，优化模型在最坏情况分布下的性能。  
- **优势**：模型在测试时遇到分布偏移（如噪声图像）时表现更稳定。

#### **例2：生成对抗网络（GAN）**
- **问题**：生成器网络需要生成与真实数据分布接近的样本。  
- **方法**：  在Wasserstein GAN (WGAN) 中，通过最小化生成分布 \\(Q_\theta\\) 与经验分布 \\(P_n\\) 之间的 Wasserstein 距离来训练生成器：
  \\[
  \min_{\theta} W_1(Q_\theta, P_n).
  \\]
- **优势**：Wasserstein距离提供更平滑的优化梯度，避免模式崩溃（Mode Collapse）。



### **5. 相关文献**
- 讨论基于似然比或KL散度的投影方法，而Wasserstein投影是另一种几何驱动的投影准则。  

  - Owen. *Empirical Likelihood*. Chapman and Hall/CRC, 2001

- 将Wasserstein投影与DRO结合，证明在分布鲁棒优化中，使用Wasserstein距离构建不确定性集合可以提供更自然的鲁棒性保证（尤其是对协变量偏移）。

  - John C Duchi, Peter W Glynn, and Hongseok Namkoong. *Statistics of robust optimization: A generalized empirical likelihood approach*. Accepted to Mathematics of Operations Research, 2021.

  - Henry Lam. *Recovering best statistical guarantees via the empirical divergence-based distributionally robust optimization*. Operations Research, 67(4):1090–1105, 2019. 

  -  Henry Lam and Enlu Zhou. *The empirical likelihood approach to quantifying uncertainty in sample average approximation*. Operations Research Letters, 45(4):301–307, 2017.



### **总结**
- **经验分布**是对真实分布的样本估计，而 **Wasserstein距离** 是衡量经验分布与目标分布之间差异的几何敏感度量。  
- **投影问题**：通过最小化 Wasserstein 距离，将经验分布对齐到特定模型假设的分布集合，用于统计推断、假设检验或鲁棒优化。  
- **优势**：相比于KL散度，Wasserstein距离更关注数据空间的几何结构，适合需要保留空间关系的场景（如图像、物理系统）。  
- **应用**：在分布鲁棒优化、生成模型、非参数统计中均有核心作用。

简言之，**Wasserstein距离为经验分布提供了一种“几何镜头”**，使其能够更自然地与复杂的数据分布和实际问题中的分布偏移相结合。

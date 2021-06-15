# Machine Learning 

---

**old MSP (python) on [studentbox.ch](https://studentbox.ch)**


the following part is outdated

please see the jupyter notebook for a more complete summary



---

## Exam and Quiz Questions

>for general questions answer with...
>- "It depends ... "
>- "In the case of ... I would do ..."

---

# todo

> However, although naive Bayes is known as a decent classiﬁer,
it is known to be a bad estimator, so the probability outputs from predict_proba are not to be
taken too seriously.

What is the difference between a classifier and an estimator?

---

### Explain in your own words what over- and under fitting is:

Overfitting is when the model is too detailed and only learns the data by heart instead of generalizing and simplifying the data into a usable model.

Underfitting is when the model is too simple and not able to fit important variations in the data.

---

## Dimensionality Reduction Techniques

### Explain what a kernel is.


---

### List four commonly used kernels k(x, x′) in Machine Learning.


---

### Show, that the RBS-kernel is symmetric and positive semi-deﬁnite.


---

### What is the curse of dimensionality? Can you explain this with an example?

The more dimmenstions a dataset has, the more data is required to draw relevant conclusions from this dataset. 
The amount of data needed to support the result often grows exponentially with the dimensionality.

Say, you dropped a coin on a 100-meter line. How do you find it? Simple, just walk on the line and search. But what if it’s 100 x 100 sq. m. field? It’s already getting tough, trying to search a (roughly) football ground for a single coin. But what if it’s 100 x 100 x 100 cu.m space?! 

---

### What are the main motivations for reducing a dataset’s dimensionality?

- to reduce noise 
- algorithms perform better and faster with less dimensions
- removes redundant features
- allows to filter for features that matter and discard features that have no additional information
- for visualization purposes

---

### What are the main applications of dimensionality reduction techniques?

- removal of noise and redundant features for classiﬁcation tasks
- visualization of high dimensional data
- data compression
- noise reduction, removal

---

### What are the main drawbacks of dimensionality reduction techniques?

- information is lost on purpose
- linear methods are not able to unwrap / detect substructures
- the reduction process is again a step in the machine learning chain that uses processing power and time
- adds complexity to the leaerning pipeline
- transformed spaces are hard to interpret by humans

---

### Once a dataset’s dimensionality has been reduced, is it possible to reverse the operation? If so, how? If not, why?

For some methods yes. The data can be decompressed but will be contaminated with some artifacts because some information was lost.

Also, not all methods have an inverse.

---

### Can PCA be used to reduce the dimensionality of a highly nonlinear dataset? Which methods can alternatively be used?

No, PCA/NDS acts globally.

Use a Kernel instead. 

> If highly nonlinear distribution, which would you select ( ... ) ?

---

###  Suppose you perform a PCA on a 1000-dimensional dataset, setting the explained variance to 95%. How many dimensions will the resulting dataset have?

> (general question)

cannot be answered. depends on data

---

### In which cases would you use incremental PCA, randomized PCA or kernel PCA?

- randomized PCA to save computation time by selecting a randomized subset of the data. 
- kernel PCA is used for nonlinear datasets

- Regular PCA is the default, but it works only if the dataset ﬁts in memory.
- Incremental PCA is useful for large datasets that don’t ﬁt in memory, but it is slower than regular PCA, so if the dataset ﬁts in memory you should prefer regular PCA. Incremental PCA is also useful for online tasks, when you need to apply PCA on the ﬂy, every time a new instance arrives.
- Randomized PCA is useful when you want to considerably reduce dimensionality and the dataset ﬁts in memory; in this case, it is much faster than regular PCA. Finally, Kernel PCA is useful for nonlinear datasets.

---

### How can you evaluate the performance of a dimensionality reduction algorithm?

> (general question)

One way to measure the performance of the reduction alone is to apply the reverse transformation and measure the reconstruction error. This only works, if an inverse can be aplied.

It depends on what performance measurement the entire machine learning task optimizes for. In order for this question to be answered, a performence metric must also be defined (e.g. Precision, Recall, f1-score etc.)

---

### Does it make sense to chain two different dimensionality reduction algorithms?

> (general question)

It depends on the task. It could help to increase the speed.

> A common example is using PCA to quickly get rid of a large number of useless dimensions, then applying another much slower dimensionality reduction algorithm, such as LLE. This two-step approach will likely yield the same performance as using LLE only, but in a fraction of the time.

---

### Which dimmensionality reduction algorithm do you know?

- Kernel PCA is generally well suited in reducing the dimensionality of high dimensional, nonlinear datasets. By applying the kernel trick, a nonlinear mapping is applied to the input data, actually increasing the dimensionality even more. The kernel however can be evaluated in dataspace. The problem complexity is given by the number of data points.
- Local Linear Embedding (LLE) reduces dimensionality while trying to preserve the distances between close instances only.
- Isomap creates a graph by connecting each instance to its nearest neighbors, then reduces dimensionality while trying to preserve the geodesic distances between the instances.
- t-Distributed Stochastic Neighbor Embedding (t-SNE) reduces dimensionality while trying to keep similar instances close and dissimilar instances apart. It is mostly used for visualization, in particular to visualize clusters of instances in high-dimensional space (e.g., to visualize the MNIST images in 2D).
- Linear Discriminant Analysis (LDA) is actually a classiﬁcation algorithm. During training it learns the most discriminative axes between the classes. These axes can be used to deﬁne a hyperplane onto which to project the data. The projection will keep classes as far apart as possible, so LDA is a good technique to reduce dimensionality before running another classiﬁcation algorithm such as an SVM classiﬁer.

---





---

## Reinforcement Learning

You know the deﬁnition of a ﬁnite Markov decision process (MDP) and the deﬁnition of a Markov Reward Process (MRP).

You understand the two basic algorithms for iteratively approximating the dynamic programming task for ﬁnite MDPs in the special cases of one-step, tabular, modelfree TD (time diﬀerence) methods, namely value iteration and Q-learning.

You know the diﬀerence between on-policy and oﬀ-policy learning.

You can explain the diﬀerence between value iteration and policy iteration.

You know the trade-oﬀ between exploitation and exploration.

Is the MDP framework adequate to usefully represent all goal-directed learning tasks? Can you think of any clear exceptions?









What is a weakness of Bayes Classifier and what can be done against it?

- The classifer becomes weak, if a certain state was never observed
- Use Laplace Smoothing

What is the difference between a generative model and a discriminative model?



What is the "no free lunch" theorem?




How do you tune hyper parameters?
- grid search

What are disadvantages of grid search?

What does grid search optimize?
- Accuracy Score

What is "boosting" ?



What is an out of bag error?


How can you improove ... ?





KNN is good for low dimmensions
for many features (e.g. pixles) the data must be broken down



What is linearly sepparable in terms of SVN?



What is recall?


What is the f1-score?



---

# Suport Vector Machines

What does the geometric margin say?



How do you distinguish "linearly non-separable classes"?



What does the Kernel Trick do?



What are the advantages of SVM?

> "SVM are still eﬀective in cases where number of dimensions d is greater than the number of samples N"

What are disadvantages of SVM?

- Noisy measurements because only a few points define the border


What are Lagrange-Multipliers and why are they used in SVM?

- To get rid of the linear inequality constraints,


What is a dual form of an optimizaiton problem?


How do you pick a feature transformation function?


What is the difference between the dual-version and the primal-version of a SVM classifier?



---


### What is the fundamental idea behind SVMs?

> The fundamental idea behind Support Vector Machines is to ﬁt the widest possible «street»between the classes. In other words, the goal is to have the largest possible margin between the decision boundary that separates the two classes and the training instances.
When performing soft margin classiﬁcation, the SVM searches for a compromise between perfectly separating the two classes and having the widest possible street (i.e., a few in-stances may end up on the street). Another key idea is to use kernels when training on nonlinear datasets.

### What is a support vector?

> After training an SVM, a support vector is any instance located on the «street»(see the previous answer), including its border. The decision boundary is entirely determined by the support vectors. Any instance that is not a support vector (i.e., oﬀ the street) has no inﬂuence whatsoever; you could remove them, add more instances, or move them around, and as long as they stay oﬀ the street they won’t aﬀect the decision boundary. Computing the predictions only involves the support vectors, not the whole training set.

### Why is it important to scale the inputs when using SVM?

> SVMs try to ﬁt the largest possible «street»between the classes (see the ﬁrst answer), so if the training set is not scaled, the SVM will tend to neglect small features.

### Can an SVM output a conﬁdence score when it classiﬁes an instance? What about a probability?

> An SVM classiﬁer can output the distance between the test instance and the decision boundary, and you can use this as a conﬁdence score. However, this score cannot be directly converted into an estimation of the class probability. If you set probability=True when creating an SVM in Scikit-Learn, then after training it will calibrate the probabilities using Logistic Regression on the SVM’s scores (trained by an additional ﬁve-fold cross-validation on the training data). This will add the predict_proba() and predict_log_proba() methods to the SVM.

### Should you use the primal or the dual form of the SVM problem to train a  model on a training set with millions of instances and hundreds of features?

> This question applies only to linear SVMs since kernelized can only use the dual form. The computational complexity of the primal form of the SVM problem is proportional to the number of training instances N, while the computational complexity of the dual form is proportional to a number between N2 and N3. So if there are millions of instances, you should deﬁnitely use the primal form, because the dual form will be much too slow.

### Say you trained an SVM classiﬁer with an RBF kernel. It seems to underﬁt  the training set: should you increase or decrease γ? What about C?

> If an SVM classiﬁer trained with an RBF kernel underﬁts the training set, there might be too much regularization. To decrease it, you need to increase γ or C (or both).




---


What is the Mahalanovan Distance?



Explain "regression to mean"






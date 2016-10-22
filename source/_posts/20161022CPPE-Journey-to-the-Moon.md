---
title: CPPE Journey to the Moon
tags: CPPE
categories: CPPE
date: 2016-10-22 18:39:44
---
# Journey to the Moon
Competitive Programing Problem Editorial

## Problem Statement
This problem comes from [HackerRank](https://www.hackerrank.com/challenges/journey-to-the-moon) and is classified as a graph theory problem.
<!-- more -->

### Breakdown
Since this is a graph theory, let's rename a few things in the problem to make it more graph-y.

1. Let 'countries' be 'graphs'
2. Let 'astronauts' be 'nodes'
3. Let 'pairs' be 'edges'

Now with that in mind, we can rewrite the problem to be:
Find how many pairs consisting of nodes from different graphs can be created.

We can define disconnected graph $ DG  = \{G_i, i = 1,\dots,M\} $ where $ G_i $ is a connected graph.


### Initial Assumptions
1. With the problem in terms of graph theory, we can imagine using an undirected graph to hold all the pairs.
2. We can represent the undirected graph in terms of an adjacency list where we get the pairs from the input.
3. If a node doesn't appear in the input pairs, we can assume it is the only node from that country
4. To find how many pairs we just need to calculate $$ \sum_{i=0}^M \left( g_i * \sum_{i=0}^M g_j  \right) $$ where $ g_i $ is the number of nodes in $ G_i $


# Solution
[Source Code](https://github.com/asclines/CPPS/tree/master/HackerRank/Algorithms/GraphTheory/Journey%20to%20the%20Moon)
## Algorithms and Data Structures
### Data Structures Used
 - [Adjacency List](http://www.geeksforgeeks.org/graph-and-its-representations/#attachment_27189) (Implemented with a vector of vectors in this solution)
 - [Vector](http://www.cplusplus.com/reference/vector/vector/)

### Algorithms Used
The solution uses a modified [Breadth First Search (BFS)](https://www.topcoder.com/community/data-science/data-science-tutorials/introduction-to-graphs-and-their-data-structures-section-2/#breadth) algorithm as part of its algorithm.

### Solution Algorithm
1. Given numbers $N,I$
2. Let $L$ be a list of size $ N$ where each element in $ L $ is an empty list. _This will be our adjacency list._
3. For each input pair $a,b$:
	3.1. Add $b$ to $L[a]$ (a.k.a. $L_a = b$)
	3.2. Add $a$ to $L[b]$ (a.k.a. $L_b = a$)
4. Let $V$ be a list of size $N$ of type boolean where every element in $V$ is initialized to false. _This will be how we keep track of visited._
5. Let $C$ be an empty list where the size of $C$ is the number of disconnected graphs and each element in $C$ is the number of nodes in the disconnected graph. (a.k.a. $\forall i \in \{1,...,|C|\}, C_i =$ how many nodes are in the disconnected graph $i$)
6. For $n \in N$: _For each node_
	6.1 If node $n$ has **not** been visited ( a.k.a. if $ V_n $ = false)  

	6.1.1 Let $ c = 1 $. _$ c $ is for count_
  6.1.2 Let $F$ be a list of node $n$'s neighbors. _$F $ is for frontier_
  6.2.3 Let $G$ be an empty list. _$ G $ is the next frontier_
  6.2.4 While $F$ is **not** empty:
	6.2.4.1 For $e$ in $F$:
	6.2.4.1.1 If node $e$ has **not** been visited ( a.k.a. if $V_e = false$):
	6.2.4.1.1 $c = c + 1$
	6.2.4.1.2 Add all non-visited neighbors of $e$ to $G$
	6.2.4.2 Set $F = G$
	6.2.5 Add $c$ to $C$
7.  Let $r = 0 $ _$r$ is for result_
8. Let $s = \sum_{i=0}^{|C|} C_i$
9. Result is $$\sum_{i=0}^{|C|} C_i * S'_i $$ where $$ S'_0 = s  $$ and $$S'_i = S_{i-1}-C_i \forall i \in \{1,...|C|\} $$



## Complexity & Performance
The time-complexity for the solution is $O(N)$  and the performance was fast enough that HackerRank reported 0's on all test cases.

# Final Thoughts and Conclusion
- Note how in my initial assumptions I had a double summation formula for calculating the result. That resulted in having an $O(n^2)$ time-complexity as opposed to the $O(n)$ solution I ended up using.
- Also there is a way to solve this problem using [Union Find](http://www.geeksforgeeks.org/union-find/) which could result in the same time-complexity. But since this problem was labeled as a graph problem, that is the route I chose to take.

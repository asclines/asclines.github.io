---
title: CPPE New Year Chaos
tags:
  - CPPE
  - HackerRank
  - Algorithms
  - Constructive
categories: 'CPPE'
date: 2016-10-18 18:50:16
---

# New Year Chaos
Competitive Programing Problem Editorial
## Problem Statement
This problem comes from [HackerRank](https://www.hackerrank.com/challenges/new-year-chaos) and is classified as a Constructive Algorithm
<!-- more -->

### Breakdown
1. Suppose there is an ordered list of *N* elements numbered 1 to *N*.
2. An element can swap with the element before it at most 2 twos.
3. We are given a list of numbers where each number marks the original position of an element.
4. From this list we are to determine whether or not it was possible to get to this state given (1) & (2)
5. If it was not possible, output "Too chaotic", else output the minimum number of swaps it would take to get from (1) to the given list at (3).

### Initial Thoughts
1. We can tell whether or not a list is too chaotic by simply iterating through the list once. If, while iterating through the list, we find a number too big too soon, we know its "too chaotic".
  - To put in more formal terms: If there exists an element in the list with value *x* at position *i* where * x > i + 1 * then too chaotic.
  - We can check for this at the same time as reading in the input.
  - This means that for a non-chaotic list, an element with value *x* is bounded by *i+1 < x < N*
2. Arrays by default are 0-based, however given the input constraints it will be easier if we just force all arrays to be 1-based. (This will make more sense after reading the Walk-Through)
3. Essentially we are just trying to sort the input list


# Solution
[Source Code](https://github.com/asclines/CPPS/tree/master/HackerRank/Algorithms/ConstructiveAlgorithms/NewYearChaos)
## Algorithms and Data Structures
The only data structure used in this solution is an array for storing the list.
For this algorithm, we can assume that the list is possible as we are checking for that while taking in the input.
If we iterate through the list backwards, swapping elements as we go we will be able to make two assumptions that are needed to solve the problem.
For element with value *x* at position *i*, *1 <= i <=N*:  
  - Assumption 1: Since we are swapping and therefore sorting as we iterate, we can assume that for any element at the current position, all elements with positions greater than the current position are where they are supposed to be and have values greater than the value of element at the current position.
  - Assumption 2: From the breakdown, we know that *x* has a lower bound of *i+1* and from the previous assumption we know that *x* has a greater bound of *i* inclusively. Therefore, if *i* does not equal *x*, then either *i*-1 or *i*-2 equals *x*

If (while using these assumptions, iterating through the list backwards and swapping elements as we go) we increment a counter by 1 every time *x* is at *i*-1 and by 2 every time *x* is at *i*-2, the counter will equal the minimum number of swaps needed by the end of the iteration.  

## Walk-Through  
Our input variables with constraints
```c++
int T; // Number of test cases     1 <= T <= 10
int N; // Number of people in line 1 <= N <= 10^5
```

A over-arching for loop for each test cases
```c++
for (int t = 0; t < T; t++) {
  std::cin >> N;              // Get the number of people
  int n;
  //.. Test case code here
}
```

**For each test case**  

So we can have a 1-based array as opposed to 0-based, makes things easier since n>=1
```c++
int line[N + 1];
```


Flag here so we can check for chaotic while reading in the numbers to prevent unneeded calculations in the future.  

```c++
    bool is_chaotic = false;
```

Read in the numbers and store them in the line array.  
This is also where we check for chaotic or not. If by the end of this loop we haven't said its chaotic, we never will.  
Note: n=1 Because we are working with 1-based array instead of 0  
The reason for the flag instead of simply breaking here is because we still need to read in all the inputs. This condition is the ONLY way for the line to be chaotic. If it is chaotic we don't need to waste the time to store the values

```c++
for (n = 1; n <= N; n++) {
  int x;
  std::cin >> x;
  if (x > n + 2) is_chaotic = true;
  else line[n] = x;
}
```

At this point we can check if the `is_chaotic` flag has been set to true. If it has, we can output "Too chaotic" and move on to the next test case.

```c++
if (is_chaotic) {

  std::cout << "Too chaotic" << std::endl;
} else {
  // .. Not chaotic
}
```

By this point, we can now safely assume that the list is not chaotic, and therefore we need to find the minimum number of swaps it will take to get to the original list.
First we need a counter for the number of swaps.
```c++
int count = 0;
```

This is where we can implement the algorithm.
We are iterating through the list backwards, arranging people as we go.  
This means that at any point, we can assume everybody behind that point is where they are supposed to be. This forces the situation where if *line[i] != i*, then either *line[i-1] = i* or *line[i-2] = i*
```c++
      for (n = N; n > 0; n--) {
        // Check the element at position n and if needed check the elements at the two positions before it.
      }
```

We only care about 3 people & 3 positions at a time.  
Suppose it starts as follows:  
Person A at position X  
Person B at position Y  
Person C at position Z  

Then the line looks like this:  
Person    : C B A  
Position  : Z Y X  

We want the person at position *X* to be the greatest value. We can assume that anybody behind (to the right) of position *X* is already where they are supposed to be. AKA every person after position *X* has a value greater than every person at and before position *X*.

Person A:  
```c++
int x = line[n];
```

First check to see if A is where they should be, if not, we need to find out if A swapped once or twice.
```c++
if (x != n) {
  // A is not supposed to be here
}
```
A is not supposed to be here, since we know they aren't behind position *n*, he must have been bribed!
The question is, who bribed him? B or C? Regardless, we need to increment `count` and find out the value of person B.
```c++
count++;
int y = line[n - 1]; //Person B
```

If person A isn't where he is supposed to be, then no matter whether he was bribed by B or C, A needs to be in the middle.  
Now where C & B need to be changes depending on whether it was C or B that did the bribing.
```c++
line[n - 1] = x;
```

Now we know person A isn't right spot, we need to see if person B is in the right spot.  
If we stop here, our line will look like this: CAB
```c++
  if (y != n) {
    //Person A and person B are in the wrong spots.
  }
```
If person B was also not supposed to be here, C must have bribed two people!
We have already incremented `count` once, now just increment once more to reflect that it was 2 bribes, not 1.  
Since we know CBA and CAB were not correct, the correct ordering of these three people to make it so the person at position X has the greatest value MUST BE BAC.
count++;

```c++
int z = line[n - 2]; // Person C
line[n]     = z;
line[n - 2] = y;
```

If person B was the one who bribed person A, all we need to do is finish the swap. (Remember: We already set `line[n - 1] = x`)
```c++
} else {
  line[n] = y;
}
```

Finally, we just need to output `count`, which now holds the minimum number of swaps needed.
```c++
  std::cout << std::to_string(count) << std::endl;
```

## Complexity & Performance
Within in the source code are two for loops (Ignoring the one for test cases).
```c++
  for (n = 1; n <= N; n++) {
    //Reading in input
  }

  for (n = N; n > 0; n--) {
    //Iterating through the list backwards

  }
```
Both of these for loops are linear with size *N*. Therefore the Big-O for this algorithm is O(N).
Upon submitting this, the solution passes all of HackerRank's test cases, gaining a score of 40.0.   
The longest test case was Test Case #6 with a runtime of 0.16s.

# Final Thoughts and Conclusion
Overall this is a good problem to see as there are actually quite a few ways to solve this problem. Several of my fellow students also tried this problem and their best results had a complexity of n*lg(n). This results from the back that they didn't consider looping backwards through the list.  
So with that my takeaway is this;  
Before committing to a solution imagine your data in a different way.
What changes when you sort the data first? In ascending or descending?  
What if the data was shuffled?  
Or, like in this case, what if you simply just went through the data backwards?

Thank you for reading.

Alexander Clines

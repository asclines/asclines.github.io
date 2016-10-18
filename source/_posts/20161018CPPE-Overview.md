---
title: CPPE-Overview
date: 2016-10-18 18:39:44
categories:
- CPPE
tags:
- CPPE
---

# Competitive Programming Problems Editorials Introduction

## Purpose

Hello all,
This post will serve as an introduction post to what will hopefully be many posts to come in the future.
At Texas Tech University, I am part of a team of students that are running an Applied Algorithms group that meets once a week.
The purpose of this team is trifold:
1. To help CS students get more practice with programming, algorithms, and data structures that they have learned in class.
2. To get more CS students interested and involved in competitive programming.
3. To prepare CS students for technical interviews.

We believe all three of these goals can be solved simultaneously by working through problems found on sites like [HackerRank](https://www.hackerrank.com), [CodeForces](http://codeforces.com), [TopCoder](https://www.topcoder.com), etc..

So with that being said, at least once a week, I intend to write up an editorial for a problem (usually from one of the previously mentioned sites) that goes through my solution for that problem.

Although I cannot guarantee my solution will be the best and odds are it won't be, I can promise that my solution will work.

**The goal of these editorials is not to provide the absolute best solution, but rather to provide insight on to how I reached my solution.**
<!-- more --> 
## Target Audience

My target audience is this; Someone who:
- Is interested in competitive programming but:
  - Is intimidated by it
  - Doesn't know where to start
  - Is looking to learn more about how to solve these types of problems
- Has some programming experience (for the most part my solutions will be in C++)
- Has some data structure experience (TTU Students, I would advise that you have least started CS 2413)
- Is willing to learn more on their own, outside of class. (I will provide good resources along the way)

My posts will be written with that kind of person in mind. Meaning, when I go over the solution, I will be focused not so much on the language I am using, but the algorithms and data structures that I am applying. If you are having a hard time understanding how I am using the language, first and foremost try looking it up. The internet is full of resources. If you still cannot figure it out (which is fine! Sometimes I may do something weird), feel free to email me! My current email will be in the sidebar.

## How The Editorials Will Be Structured
Each editorial will more or less follow this general outline (certain problems may require a change in format).

1. ### Break down the problem statement.  
These types of problems tend to be filled with some back story that can distract the reader from the real problem. The first step of solving these problems is to figure out what information you really need to know.

2. ### Initial assumptions.  
Before any coding happens, we need to make sure we have all our assumptions summarized. This is where we can consider things like edge cases, input limits and other details from the problem statement that might affect which algorithms and data structures we use.

3. ### Algorithms and data structures used in my solution.  
Before we get to the code, I'll go over which algorithms and data structures make an appearance in the solution so you can be aware of and if needed refresh your knowledge of them before you see them used.

4. ### Source code walk through.  
Here, I will walk you through the source code explaining various concepts, methods and more or less narrate what was going on in my head as I wrote this solution. That way, you can see how I arrive to the conclusion I came up with.

5. ### Complexity and performance.  
We will go over the algorithmic complexity of the chosen algorithm in addition to the runtime performance of the source code. * Note: The same algorithm written in two different languages can have a different runtime performance. *

6.  ### Post-thoughts and conclusion.  
This is where I will wrap things up by giving any final thoughts on what was written, what might have been better, some final rationale on decisions I made etc. Also, here is where I will quickly mention any other possible ways to solve the problem that may have been just as effective as mine. Remember, *there is more than one way to solve a problem, and it's not a guarantee that there is exactly one that is more efficient than any others.*

## How To Use These Editorials
Don't just read these editorials like a book. The best way to learn is by doing.

I highly recommend that for each problem  I write an editorial on, you should first attempt the problem on your own.  
If you get stuck, read how I break down the problem.  
Then, if you are still stuck, read my initial assumptions.  
If you still can't get a solution, go ahead and read the rest of the editorial.

 While reading the editorial try to remember what your thoughts were and compare them with mine.  
  What assumptions did you make that shouldn't have?  
  What assumptions did you miss?  
  Are you missing some knowledge about algorithms or data structures that were crucial to solving this problem? If so, that's perfectly okay! It's how you learn.

If you did come up with a solution, compare it to mine and see what differences there are.
Things to compare:
- Time complexity: Was yours as efficient as mine? Was it more efficient?(If so, email me) Was it less efficient? (If so, what could you have done different?)
- Space complexity: Did your solution use memory efficiently? What could you do to your solution to make it use less memory?
- Runtime: How long does it take for your solution to run through the tests?  

---
title: CPP Template Functions Inside Template Classes
tags:
---

TODO: Below is copy-pasta from wordpress.





Let's say you have a templated class, and inside that class you have a member function that requires additional template parameters. Well here is how I handle that.


So recently I have been working on a project that requires heavy C++ Template Meta Programming. While working on this project, I have come across the need to have template functions with their own templates inside of templated classes and I could not find a solid guide on how to do this on the internet. With that in mind, I have decided to compile what I have learned from digging around and experimenting into a post so that others may have an easier time learning this.

Situation

Let's say you have a class like this:


[cpp]
template<typename T>
class SomeClass{
public:

     void Foo(T a, int b);

     void Bar(T a, char b);
};
[/cpp]
But perhaps you want Foo to take on additional template that Bar does not need.

Solution

Instead of adding it to the class templates, forcing an unnecessary type declaration when using Bar, you can add a template type parameter to Foo, in the same way you would normally template a function.

[cpp]
template<typename T>
class SomeClass{
public:

     template<typename S>
     void Foo(T a, S b);

     void Bar(T a, char b); //Bar doesn't need type S
};
[/cpp]
Now to actually define a templated function in a templated class, it would look like this:

[cpp]
template<typename T> //From class declaration
template<typename S> //From function declaration
void SomeClass<T>::Foo(T a, S b){
        //Method stuff here...  
}

template<typename T>
void SomeClass<T>::Bar(T a, char b){
        //Method stuff here...
}      
[/cpp]
Note the location of the template type declarations.

Now, to actually use these functions, one way to do it is as so:

[cpp]
        SomeClass<int> obj; //int is type T

        obj.Foo<char>(5,'A'); //char is type S

[/cpp]
And there we have it, a simple way to show how to declare/define templated functions inside templated classes.

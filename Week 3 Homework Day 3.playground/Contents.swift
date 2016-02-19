//: Playground - noun: a place where people can play

import UIKit

func fibonacciNumber()
{
    var valueOne: UInt64 = 0
    var valueTwo: UInt64 = 1
    
    for var i = 0; i < 100; i++
    {
        let fNum = valueOne + valueTwo
        valueOne = valueTwo
        valueTwo = fNum
        print(fNum)
    }
}

fibonacciNumber()
//cannot run 100 times, xcode FREAKS out!
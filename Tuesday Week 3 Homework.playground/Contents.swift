//: Playground - noun: a place where people can play

import UIKit

func oddNumerArray(array:[Int]) -> [Int]
{
    var oddArray = [Int] ()
    for var index = array.count - 1 ; index >= 0 ; index--
    {
        if array[index] % 2 != 0 {
        oddArray.append(array[index])
        }
        
    }
    return oddArray.sort()
}

var numbers = [1,2,3,4,5,6,7,8,9,10]
var hawksPlayerNumbers = [3,4,9,16,24,25,29,31,89]


oddNumerArray(numbers)
oddNumerArray(hawksPlayerNumbers)


// Allen is the snapchat power user

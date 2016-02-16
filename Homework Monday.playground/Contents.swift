//: Playground - noun: a place where people can play

import UIKit


var test = "this is a test"
var hawks = "Sehawks are the best team in the NLF"

// this way sort of works, but you cant have additional spaces
func totalWords (string:String) -> [String]
{
    let wordsArray  = string.componentsSeparatedByString(" ")
    return wordsArray
}
totalWords(test).count
totalWords(hawks).count

//this way seems to work better than the previous way, but spaces still throw it off, not sure how to correct for this, since it counts the spaces to get the words
func wordCount(string: String) -> Int
{
    var wordsArray = string.characters
    
    let word = string.characters.filter { (wrds) -> Bool in
        if wordsArray.last == " " {
            wordsArray.removeLast()
            return false
        } else {
        return wrds == " "
        }
    }
    return word.count + 1
}


wordCount(hawks)
wordCount(test)

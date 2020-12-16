import Foundation

let input = "0,6,1,7,2,19,20"
let inputArray = input.split(separator: ",").compactMap { Int($0) }

// MARK: - Question 1
func runGame(withStartNumbers startNumbers: [Int], amountOfTurns turns: Int) -> Int {
    var numbers = [Int: [Int]]()
    var lastNumber = 0
    
    func addToMemory(number: Int, inTurn turn: Int) {
        if (numbers[number] == nil) {
            numbers[number] = [Int]()
        }
        numbers[number]?.append(turn)
        lastNumber = number
    }
    
    func firstSpoken(number: Int) -> Bool {
        return numbers[number]?.count == 1
    }
    
    func newNumberForNumber(number: Int) -> Int {
        let endSlice = numbers[number]!.suffix(2)
        return endSlice.last! - endSlice.first!
    }
    
    // Initialize with startnumbers
    for turn in 1...startNumbers.count {
        addToMemory(number: startNumbers[turn - 1], inTurn: turn)
    }
        
    // Run game x turns
    for turn in (startNumbers.count + 1)...turns {
        var newNumber = 0
        if (!firstSpoken(number: lastNumber)) {
            newNumber = newNumberForNumber(number: lastNumber)
        }

        addToMemory(number: newNumber, inTurn: turn)
    }
    
    return lastNumber
}

// MARK: - Question 1
let lastNumber1 = runGame(withStartNumbers: inputArray, amountOfTurns: 2020)
print(lastNumber1)

// MARK: - Question 2
let lastNumber2 = runGame(withStartNumbers: inputArray, amountOfTurns: 30000000)
print(lastNumber2)

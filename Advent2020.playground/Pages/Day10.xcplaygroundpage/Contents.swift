import Foundation

let input = """
99
128
154
160
61
107
75
38
15
11
129
94
157
84
121
14
119
48
30
10
55
108
74
104
91
45
134
109
164
66
146
44
116
89
79
32
149
1
136
58
96
7
60
23
31
3
65
110
90
37
43
115
122
52
113
123
161
50
95
150
120
101
126
151
114
127
73
82
162
140
51
144
36
4
163
85
42
59
67
64
86
49
2
145
135
22
24
33
137
16
27
70
133
130
20
21
83
143
100
41
76
17
"""

// Split input string by newlines
let inputArray = input.lowercased().split(whereSeparator: \.isNewline).compactMap { Int($0) }.sorted()

// MARK: - Question 1
func findBestAdapter(forInput input: Int) -> Int? {
    if inputArray.contains(input + 1) { return (input + 1) }
    if inputArray.contains(input + 2) { return (input + 2) }
    if inputArray.contains(input + 3) { return (input + 3) }
    return nil
}

var currentJolts = 0
var differenceList = [Int]()

while let nextAdapterRating = findBestAdapter(forInput: currentJolts) {
    differenceList.append(nextAdapterRating - currentJolts)
    currentJolts = nextAdapterRating
}
differenceList.append(3) // Add device difference

let oneJoltDiffs = differenceList.filter { $0 == 1 }.count
let threeJoltDiffs = differenceList.filter { $0 == 3 }.count

print(oneJoltDiffs * threeJoltDiffs)


// MARK: - Question 2
let highest = inputArray.max()
var cache: [Int: Int] = [:] // Cache results otherwise it will take forever

func findNrOfCombinations(startingAtInput input: Int) -> Int {
    if cache[input] != nil {
        return cache[input]!
    }
    
    var totalCombinations = 0;
    if input == highest {
        totalCombinations += 1
    }
    
    if inputArray.contains(input + 1) { totalCombinations += findNrOfCombinations(startingAtInput: (input + 1)) }
    if inputArray.contains(input + 2) { totalCombinations += findNrOfCombinations(startingAtInput: (input + 2)) }
    if inputArray.contains(input + 3) { totalCombinations += findNrOfCombinations(startingAtInput: (input + 3)) }
   
    cache[input] = totalCombinations
    
    return totalCombinations
}

print(findNrOfCombinations(startingAtInput: 0))

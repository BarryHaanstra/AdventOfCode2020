import Foundation

let earliestTime = 1008141
let busSchedule = "17,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,523,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,13,19,x,x,x,23,x,x,x,x,x,x,x,787,x,x,x,x,x,37,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,29"

// MARK: - Question 1
func findBus(atTime time: Int, forSchedule schedule: String) -> (Int, Int) {
    let availableBuses = schedule.split(separator: ",").compactMap { Int($0) }
    let maxTimeStamp = time + availableBuses.max()!
    
    var busLineBestWaitTimes = [Int:Int]()
    for busNumber in availableBuses {
        for timestamp in stride(from: 0, to: maxTimeStamp, by: busNumber) {
            if timestamp >= time {
                let waitTime = timestamp - time
                busLineBestWaitTimes[busNumber] = waitTime
                break
            }
        }
    }
    
    let bestBus = busLineBestWaitTimes.min { a, b in a.value < b.value }!
    return (bestBus.key, bestBus.value)
}

let (bus, waittime) = findBus(atTime: earliestTime, forSchedule: busSchedule)
print("Question 1: \(bus * waittime)")


// MARK: - Question 2
func findTimestamp(forSchedule schedule: String) -> Int {
    // Get array of index/bus tuples, filter out the x's afterwards so the indexes remain correct
    let availableBuses = schedule.split(separator: ",").enumerated().map { ($0, String($1)) }.filter { $0.1 != "x" }.map { ($0.0, Int($0.1)!) }
    
    var timestamp = 0
    var periodJump = 1
    for i in 0..<(availableBuses.count - 1) {
        let busNumber = availableBuses[i].1
        let nextIndex = availableBuses[i + 1].0
        let nextBusNumber = availableBuses[i + 1].1
        
        // Bus number = period. Bus with period A and period B share period A * B
        // This gets multiplied for each added bus
        periodJump *= busNumber

        //print("Busnumber: \(busNumber); nextIndex: \(nextIndex); nextBusNumber: \(nextBusNumber); periodJump: \(periodJump)")

        // Use nextIndex as extra offset on the timestamp, to fix the issue with the 'x' buses in the schedule
        while (timestamp + nextIndex) % nextBusNumber != 0 {
            timestamp += periodJump
        }
    }
    
    return timestamp
}

let timestamp = findTimestamp(forSchedule: busSchedule)
print("Question 2: \(timestamp)")

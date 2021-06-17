import UIKit

enum ElevatorFloor: Int {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
}

class VirtualElevator{
    
    let peopleLimit = 4
    
    var callButton = ElevatorFloor.one.rawValue
    var currentFloor = ElevatorFloor.four.rawValue
    var moveElevator = 0
    var closeDoorCount = 0
    var human = 5
    var elevatorFloorButton = Int()
    var callTimer:Timer = Timer()
    var closeTimer:Timer = Timer()
    var moveElevatorTimer:Timer = Timer()
    
    //エレベーターを呼び出し呼び出された階に移動させるメソッド
    func elevatorCall() {
        if callButton != currentFloor {
            print("現在呼び出しています！")
            print(currentFloor)
            callTime()
        } else {
            print("扉が開きます！")
            closeDoorTime()
        }
    }
    
    func callTime() {
        callTimer = Timer.scheduledTimer(timeInterval: 1.5, target:self, selector:#selector(floorCount), userInfo:nil, repeats:true)
    }
    
    @objc func floorCount(){
        if callButton < currentFloor {
            currentFloor -= 1
        } else {
            currentFloor += 1
        }
        print(currentFloor)
        if callButton == currentFloor {
            moveElevator = currentFloor
            print("扉が開きます！")
            callTimer.invalidate()
            closeDoorTime()
        }
    }
    
    func moveElevatorTime() {
        moveElevatorTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(moveCount), userInfo: nil, repeats: true)
    }
    
    @objc func moveCount() {
        if elevatorFloorButton < moveElevator {
            currentFloor -= 1
            moveElevator = currentFloor
        } else {
            currentFloor += 1
            moveElevator = currentFloor
        }
        print(moveElevator)
        if elevatorFloorButton == moveElevator {
            moveElevator = currentFloor
            print("扉が開きます！")
            moveElevatorTimer.invalidate()
            closeDoorTime()
        }
    }
    
    //扉が開いてから一定時間すぎると自動で閉まるメソッド
    func closeDoorTime(){
        closeTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector:#selector(closeDoorCountUp), userInfo:nil, repeats:true)
        
    }
    
    @objc func closeDoorCountUp(){
        closeDoorCount += 1
        guard human <= peopleLimit else {
            print("人数がオーバーしています‼︎")
            closeTimer.invalidate()
            return
        }
        if closeDoorCount == 10 {
            closeDoorCount = 0
            print("扉が閉まります！")
            closeTimer.invalidate()
            if elevatorFloorButton != moveElevator {
                elevatorMoveFloor()
            }
        }
    }
    
    func elevatorMoveFloor() {
        moveElevator = currentFloor
        print(moveElevator)
        elevatorFloorButton = ElevatorFloor.three.rawValue
        moveElevatorTime()
        
    }
    
}

let elevator = VirtualElevator()
elevator.elevatorCall()


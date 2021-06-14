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
    
    var callButton = ElevatorFloor.eight.rawValue
    var currentFloor = ElevatorFloor.four.rawValue
    var closeCount = 0
    var elevatorFloorButton = ElevatorFloor.three
    var callTimer:Timer = Timer()
    var closeTimer:Timer = Timer()
    
    //エレベーターを呼び出し呼び出された階に移動させるメソッド
    func elevatorCall() {
        if callButton != currentFloor {
            print("現在呼び出しています！")
            print(currentFloor)
            callTimer = Timer.scheduledTimer(timeInterval: 1.5, target:self, selector:#selector(floorCount), userInfo:nil, repeats:true)
        } else {
            print("扉が開きます！")
            closeDoor()
        }
    }
    
    @objc func floorCount(){
        if callButton < currentFloor {
            currentFloor -= 1
        } else {
            currentFloor += 1
        }
        print(currentFloor)
        if callButton == currentFloor {
            print("扉が開きます！")
            callTimer.invalidate()
            closeDoor()
        }
    }
    
    //扉が開いてから一定時間すぎると自動で閉まるメソッド
    func closeDoor(){
        closeTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector:#selector(closeDoorCountUp), userInfo:nil, repeats:true)
        
    }
    
    @objc func closeDoorCountUp(){
        closeCount += 1
        if closeCount == 20 {
            print("扉が閉まります！")
            closeTimer.invalidate()
        }
    }
    
}

let elevator = VirtualElevator()
elevator.elevatorCall()


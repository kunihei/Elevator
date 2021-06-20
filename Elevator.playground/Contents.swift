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
    
    var callButton = ElevatorFloor.five.rawValue
    var currentFloor = ElevatorFloor.four.rawValue
    var closeDoorCount = 0
    var elevatorFloorButton = ElevatorFloor.one.rawValue
    var callTimer:Timer = Timer()
    var closeTimer:Timer = Timer()
    var moveElevatorTimer:Timer = Timer()
    
    //現在のエレベーターの階を表示するメソッド
    func elevatorFloorDisplay() {
        print(currentFloor)
    }
    
    //到着した際に扉が開き閉じるメソッド
    func elevatorArrival() {
        print("扉が開きます！")
        closeTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector:#selector(closeDoorCountUp), userInfo:nil, repeats:true)
    }
    
    @objc func closeDoorCountUp(){
        
        let human = 4
        let peopleLimit = 4
        let stuff = 0
        closeDoorCount += 1
        
        guard human <= peopleLimit else {
            
            print("人数がオーバーしています‼︎")
            closeTimer.invalidate()
            return
        }

        if closeDoorCount == 5 {
            if stuff == 0 {
                
                closeDoorCount = 0
                print("扉が閉まります！")
                closeTimer.invalidate()
                
                if elevatorFloorButton != currentFloor {
                    elevatorMoveFloor()
                }
            } else {
                
                print("再度開きます")
                closeDoorCount = 3
            }
        }
    }
    
    //エレベーターを呼び出し呼び出された階に移動させるメソッド
    func elevatorCall() {
        if callButton != currentFloor {
            
            print("現在呼び出しています！")
            elevatorFloorDisplay()
            callTimer = Timer.scheduledTimer(timeInterval: 1.5, target:self, selector:#selector(floorCount), userInfo:nil, repeats:true)
        } else {
            
            elevatorArrival()
        }
    }
    
    @objc func floorCount(){
        
        if callButton < currentFloor {
            currentFloor -= 1
        } else {
            currentFloor += 1
        }
        
        elevatorFloorDisplay()
        
        if callButton == currentFloor {
            
            elevatorArrival()
            callTimer.invalidate()
        }
    }
    
    //乗り込んでから移動するメソッド
    func elevatorMoveFloor() {
        
        
        if elevatorFloorButton != currentFloor {
            
            elevatorFloorDisplay()
            moveElevatorTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(moveCount), userInfo: nil, repeats: true)
        }
    }
    
    @objc func moveCount() {
        if elevatorFloorButton < currentFloor {
            
            currentFloor -= 1
        } else {
            
            currentFloor += 1
        }
        
        elevatorFloorDisplay()
        
        if elevatorFloorButton == currentFloor {
            
            elevatorArrival()
            moveElevatorTimer.invalidate()
        }
    }
}

let elevator = VirtualElevator()
elevator.elevatorCall()


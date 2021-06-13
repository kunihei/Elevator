import UIKit

class VirtualElevator{
    var building = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var callButton = 2
    var currentFloor = 6
    var closeCount = 0
    var callTimer:Timer = Timer()
    var closeTimer:Timer = Timer()
    
    //エレベーターを呼び出し呼び出された階に移動させるメソッド
    func elevatorCall() {
        if callButton != currentFloor {
            print("現在呼び出しています！")
            callTimer = Timer.scheduledTimer(timeInterval: 0.9, target:self, selector:#selector(callCountDown), userInfo:nil, repeats:true)
        } else {
            print("扉が開きます！")
            closeDoor()
        }
    }
    
    @objc func callCountDown(){
        print(currentFloor)
        currentFloor -= 1
        if callButton == currentFloor {
            print("扉が開きます！")
            callTimer.invalidate()
            closeDoor()
        }
    }
    
    func closeDoor(){
        closeTimer = Timer.scheduledTimer(timeInterval: 0.9, target:self, selector:#selector(closeDoorCountUp), userInfo:nil, repeats:true)
        
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


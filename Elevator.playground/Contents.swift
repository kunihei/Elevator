import UIKit

class VirtualElevator{
    var building = 10
    var callButton = 2
    var currentFloor = 3
    
    func elevatorCall() {
        if callButton != currentFloor {
            print("現在呼び出しています！")
        } else {
            print("扉が開きます！")
            return
        }
        
        for i in 1...10 {
            currentFloor -= 1
            if callButton == currentFloor{
                print("扉が開きます")
                return
            }
        }
        
    }
}

let elevator = VirtualElevator()
elevator.elevatorCall()


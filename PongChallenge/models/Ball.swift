//
//  Ball.swift
//  PongChallenge
//
//  Created by Berkay Baltaci on 30/03/2023.
//

import Foundation

private let speed = 3.0

class Ball: ObservableObject {
    
    @Published private(set) var x: Double
    @Published private(set) var y: Double
    
    @Published private var horizontalDirection = HorizontalDirection.right
    @Published private var verticalDirection = VerticalDirection.down
    
    init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }
    
    func updatePosition() {
        if horizontalDirection == .right {
            x += speed
        } else {
            x -= speed
        }
        
        if verticalDirection == .down {
            y += speed
        } else {
            y -= speed
        }
    }
    
    func setHorizontalDirection(_ direction: HorizontalDirection) {
        horizontalDirection = direction
    }
    
    func setVerticalDirection(_ direction: VerticalDirection) {
        verticalDirection = direction
    }
    
    func resetPosition() {
        x = CommonConstants.deviceScreenSize().x / 2
        y = CommonConstants.deviceScreenSize().y / 2
        
        horizontalDirection = Int.random(in: 0...1) == 0 ? .left : .right
        verticalDirection = Int.random(in: 0...1) == 0 ? .up : .down
    }
    
}

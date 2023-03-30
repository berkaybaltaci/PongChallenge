//
//  ContentViewModel.swift
//  PongChallenge
//
//  Created by Berkay Baltaci on 30/03/2023.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    var ball = Ball(0, 0)
    
    func setHorizontalDirection(direction: HorizontalDirection) {
        ball.setHorizontalDirection(direction)
    }
    
    func setVerticalDirection(direction: VerticalDirection) {
        ball.setVerticalDirection(direction)
    }
    
    func getBallPosition() -> (xPos: Double, yPos: Double) {
        return (xPos: ball.x, yPos: ball.y)
    }
    
    func updatePosition() {
        ball.updatePosition()
    }
}

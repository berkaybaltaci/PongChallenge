//
//  ContentView.swift
//  PongChallenge
//
//  Created by Berkay Baltaci on 30/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var ball = Ball(CommonConstants.phoneSize().x / 2, CommonConstants.phoneSize().y / 2)
    
    @State private var player1Score = 0
    @State private var player2Score = 0
    
    let rectWidth = 80.0
    let rectHeight = 15.0
    
    var p1Rect: CGRect
    var p2Rect: CGRect
    
    let ballImageWidth: Double
    let ballImageHeight: Double
    
    init() {
        p1Rect = CGRect(x: CommonConstants.phoneSize().x / 2 - rectWidth / 2, y: 0, width: rectWidth, height: rectHeight)
        p2Rect = CGRect(x: CommonConstants.phoneSize().x / 2 - rectWidth / 2 + 40, y: CommonConstants.phoneSize().y - rectHeight - 80, width: rectWidth, height: rectHeight)
        
        ballImageWidth = CommonConstants.ballImageSize().width
        ballImageHeight = CommonConstants.ballImageSize().height
        
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            TimelineView(.animation) { timeline in
                Canvas { context, size in
                    let image = Image(CommonConstants.imageName)
                    
                    
                    let ballX = ball.x
                    let ballY = ball.y
                    
                    context.fill(Path(p1Rect), with: .color(.blue))
                    context.fill(Path(p2Rect), with: .color(.blue))

                    context.draw(image, at: CGPoint(x: ballX, y: ballY))
                    
                    if ballX >= size.width {
                        DispatchQueue.main.async {
                            ball.setHorizontalDirection(.left)
                        }
                    }
                    
                    if ballX <= 0 {
                        DispatchQueue.main.async {
                            ball.setHorizontalDirection(.right)
                        }
                    }
                    
                    // bottom
                    if ballY + ballImageHeight / 2 >= size.height - rectHeight {
                        if p2Rect.contains(CGPoint(x: ballX, y: ballY + ballImageHeight / 2)) {
                            DispatchQueue.main.async {
                                ball.setVerticalDirection(.up)
                            }
                        } else {
                            DispatchQueue.main.async {
                                resetGame()
                                player1Score += 1
                            }
                        }
                    }
                    
                    if ballY - ballImageHeight / 2 <= rectHeight {
                        if p1Rect.contains(CGPoint(x: ballX, y: ballY - ballImageHeight / 2)) {
                            DispatchQueue.main.async {
                                ball.setVerticalDirection(.down)
                            }
                        } else {
                            DispatchQueue.main.async {
                                resetGame()
                                player2Score += 1
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        ball.updatePosition()
                    }
                }
            }
   
            VStack {
                Text("Score: \(player1Score)")
                Spacer()
                Text("Score: \(player2Score)")
            }
        }
    }
    
    func resetGame() {
        ball.resetPosition()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

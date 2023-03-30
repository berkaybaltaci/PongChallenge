//
//  ContentView.swift
//  PongChallenge
//
//  Created by Berkay Baltaci on 30/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var ball = Ball(CommonConstants.deviceScreenSize().x / 2, CommonConstants.deviceScreenSize().y / 2)
    
    @State private var player1Score = 0
    @State private var player2Score = 0
    
    @State var p1Rect: CGRect
    @State var p2Rect: CGRect
    
    @State var isGamePaused = false
    
    let rectWidth = 80.0
    let rectHeight = 15.0
    let playerSpeed = 2.0
    
    let ballImage = Image(CommonConstants.imageName)
    let ballImageWidth: Double
    let ballImageHeight: Double
    
    @State var recentWinner = "Unknown"
    
    init() {
        p1Rect = CGRect(x: CommonConstants.deviceScreenSize().x / 2 - rectWidth / 2, y: 0, width: rectWidth, height: rectHeight)
        p2Rect = CGRect(x: CommonConstants.deviceScreenSize().x / 2 - rectWidth / 2, y: CommonConstants.deviceScreenSize().y - rectHeight - 80, width: rectWidth, height: rectHeight)
        
        ballImageWidth = CommonConstants.ballImageSize().width
        ballImageHeight = CommonConstants.ballImageSize().height
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            TimelineView(.animation) { timeline in
                Canvas { context, size in
                    let ballX = ball.x
                    let ballY = ball.y
                    
                    context.fill(Path(p1Rect), with: .color(.blue))
                    context.fill(Path(p2Rect), with: .color(.blue))
                    
                    context.draw(ballImage, at: CGPoint(x: ballX, y: ballY))
                    
                    if isGamePaused {
                        return
                    }
                    
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
                                isGamePaused = true
                                recentWinner = "PLAYER1"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    isGamePaused = false
                                }
                            }
                        }
                    }
                    
                    // top
                    if ballY - ballImageHeight / 2 <= rectHeight {
                        if p1Rect.contains(CGPoint(x: ballX, y: ballY - ballImageHeight / 2)) {
                            DispatchQueue.main.async {
                                ball.setVerticalDirection(.down)
                            }
                        } else {
                            DispatchQueue.main.async {
                                resetGame()
                                player2Score += 1
                                isGamePaused = true
                                recentWinner = "PLAYER2"
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                isGamePaused = false
                            }
                        }
                        
                        
                    }
                    
                    DispatchQueue.main.async {
                        ball.updatePosition()
                        
                        if p1Rect.midX < ballX {
                            p1Rect = p1Rect.offsetBy(dx: playerSpeed, dy: 0)
                        } else {
                            p1Rect = p1Rect.offsetBy(dx: -playerSpeed, dy: 0)
                        }
                        
                        if p2Rect.midX < ballX {
                            p2Rect = p2Rect.offsetBy(dx: playerSpeed, dy: 0)
                        } else {
                            p2Rect = p2Rect.offsetBy(dx: -playerSpeed, dy: 0)
                        }
                    }
                }
            }
            
            VStack {
                Text("Score: \(player1Score)")
                Spacer()
                Text("Score: \(player2Score)")
            }
            //            .padding(.top, 28)
            //            .padding(.bottom, 10)
            //            .padding(.leading, 15)
            //            .ignoresSafeArea(.all)
            
            if isGamePaused {
                HStack(alignment: .center) {
                    Spacer()
                    Text("A SCORE FOR \(recentWinner)!")
                        .font(.system(size: 28))
                    Spacer()
                }
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

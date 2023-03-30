//
//  CommonConstants.swift
//  PongChallenge
//
//  Created by Berkay Baltaci on 30/03/2023.
//

import UIKit

struct CommonConstants {
    
    static let imageName = "ball_resized"
    
    static let deviceScreenSize = {
        let screenBounds = UIScreen.main.bounds
        let width = screenBounds.width
        let height = screenBounds.height
        return (x: width, y: height)
    }
    
    static let ballImageSize = {
        let image = UIImage(named: imageName)
        return (width: image!.size.width, height: image!.size.height)
    }
}

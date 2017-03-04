//
//  GameViewController.swift
//  Double Helix
//
//  Created by Thomas Barrett on 2/19/17.
//  Copyright © 2017 Thomas Barrett. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController, GKGameCenterControllerDelegate {

    public static var controller: GameViewController?
    
    override func viewDidLoad() {

        super.viewDidLoad()
        GameViewController.controller = self
        authenticateLocalPlayer()
       
        if let view = self.view as! SKView? {
            let scene = MenuScene(size:self.view.bounds.size)
            scene.scaleMode = .aspectFit
            view.ignoresSiblingOrder = true
            view.presentScene(scene)
        }
    }

    /**
     Authenticates the local player with game center
     */
    func authenticateLocalPlayer(){
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = { viewController, error in
            if let controller = viewController {
                self.present(controller, animated: true, completion: nil)
            } else if localPlayer.isAuthenticated {
                print("Authentication Succeeded")
            } else {
                print("Authentication Failed")
            }
        }
    }
    
    /**
     Displays the leaderboard
     */
    func showLeader() {
        let gc = GKGameCenterViewController()
        gc.gameCenterDelegate = self
        gc.viewState = GKGameCenterViewControllerState.leaderboards
        gc.leaderboardIdentifier = "tbarrett1200.doubleHelix.highScore"
        present(gc, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
  
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .landscape
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

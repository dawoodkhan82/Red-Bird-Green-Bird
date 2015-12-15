//
//  GameScene.swift
//  Red Bird Green Bird
//
//  Created by Dawood Khan on 1/8/15.
//  Copyright (c) 2015 Dawood Khan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    
    var bird = SKSpriteNode()
    var bg = SKSpriteNode()
    var bg2 = SKSpriteNode()
    var gameOverLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var highScoreLabel = SKLabelNode()
    var touchNode = SKSpriteNode()
    var currentLight : SKSpriteNode!
    var greenTexture : SKTexture!
    var redTexture : SKTexture!
    var isGreenLightON : Bool = true
    var score : Int = 0
    var highScore: Int = 0
    var scoreText = SKLabelNode()
    var highScoreText = SKLabelNode()
    var GAMEOVER = SKSpriteNode()

   
    
    
    /*
    //To save highest score
    var highestScore: Int = 20
     NSUserDefaults.standardUserDefaults().setObject(highestScore, forKey:"HighestScore")
    NSUserDefaults.standardUserDefaults().synchronize()
    
    //To get the saved score
    var savedScore: Int = NSUserDefaults.standardUserDefaults().objectForKey("HighestScore") as Int
     println(savedScore)
  */
    /*
    NSUserDefaults.standardUserDefaults().integerForKey("highscore")
    
    //Check if score is higher than NSUserDefaults stored value and change NSUserDefaults stored value if it's true
    if score > NSUserDefaults.standardUserDefaults().integerForKey("highscore") {
    NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "highscore")
    NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    NSUserDefaults.standardUserDefaults().integerForKey("highscore")
 */
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
     
        


        let bgTexture = SKTexture(imageNamed: "Cloud Background pixel.png")
        
        bg = SKSpriteNode(texture: bgTexture)
        bg.position = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bg.size.height = self.frame.height
        
        
        //let bg2Texture = SKTexture(imageNamed: "Cloud Background pixel.png")
        
        bg2 = SKSpriteNode(texture: bgTexture)
        bg2.position = CGPoint(x:CGRectGetMidX(self.frame) , y: CGRectGetMidY(self.frame) + self.frame.size.height)
        bg2.size.height = self.frame.height
        
      
        
        self.addChild(bg)
        self.addChild(bg2)
        
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontColor = SKColor.blackColor()
        scoreLabel.fontSize = 50
        scoreLabel.text = "0"
        scoreLabel.position = CGPointMake(CGRectGetWidth(self.frame) - 625, CGRectGetHeight(self.frame)-90)
        
        self.addChild(scoreLabel)
        
        scoreText.fontName = "Helvetica"
        scoreText.fontColor = SKColor.blackColor()
        scoreText.fontSize = 20
        scoreText.text = "Score:"
        scoreText.position = CGPointMake(CGRectGetWidth(self.frame) - 685, CGRectGetHeight(self.frame)-80)
        
        self.addChild(scoreText)
        
        
        highScoreLabel.fontName = "Helvetica"
        highScoreLabel.fontColor = SKColor.blackColor()
        highScoreLabel.fontSize = 50
        highScoreLabel.text = "0"
        highScoreLabel.position = CGPointMake(CGRectGetWidth(self.frame) - 625, CGRectGetHeight(self.frame)-160)
        
        self.addChild(highScoreLabel)
        
        highScoreText.fontName = "Helvetica"
        highScoreText.fontColor = SKColor.blackColor()
        highScoreText.fontSize = 18
        highScoreText.text = "Highscore:"
        highScoreText.position = CGPointMake(CGRectGetWidth(self.frame) - 685, CGRectGetHeight(self.frame)-150)
        
        self.addChild(highScoreText)


        
        let birdTexture = SKTexture(imageNamed: "Bird Final 1.png")
        let birdTexture2 = SKTexture(imageNamed: "Bird Final 2.png")
        
        let animateBird = SKAction.animateWithTextures([birdTexture, birdTexture2], timePerFrame: 0.3)
        let makeBirdFlap = SKAction.repeatActionForever(animateBird)
    

        
        bird = SKSpriteNode(texture: birdTexture)
        bird.position = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMinY(self.frame) + self.bird.size.height / 2)
        bird.runAction(makeBirdFlap)
        
        
       self.addChild(bird)
        
        
        
        greenTexture = SKTexture(imageNamed: "green stoplight pixel.png")
        redTexture = SKTexture(imageNamed: "red stoplight pixel.png")
        
        currentLight = SKSpriteNode(texture: greenTexture)
        currentLight.position = CGPointMake(CGRectGetMidX(self.frame), 600)
        
        
        let changeToGreenLight : SKAction = SKAction.runBlock({ () -> Void in
            self.currentLight.texture =  self.greenTexture
            self.isGreenLightON = true
        })
        
        let changeToRedLight : SKAction = SKAction.runBlock({ () -> Void in
            self.currentLight.texture = self.redTexture
            self.isGreenLightON = false
        })
        
        let changingLights = SKAction.sequence([changeToGreenLight,SKAction.waitForDuration(1, withRange: 4),changeToRedLight,SKAction.waitForDuration(1, withRange: 4)])
        
        currentLight.runAction(SKAction.repeatActionForever(changingLights))
        
        
        self.addChild(currentLight)
        
        let HighscoreDefault = NSUserDefaults.standardUserDefaults()
        if (HighscoreDefault.valueForKey("Highscore") != nil) {
            highScore = HighscoreDefault.valueForKey("Highscore") as! NSInteger!
            //highScoreLabel.text = NSString(format: "Highscore: %i", highScore)
            highScoreLabel.text = "\(highScore)"
        }


    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        if bg.position.y + bg.size.height/2 < 50
        {
            let diff =  bg.position.y + bg.size.height/2 - 50
            bg.position.y = self.frame.height + bg.size.height/2 + diff
        }
        else
        {
            bg.position.y -= 50
        }
        if bg2.position.y + bg2.size.height/2 < 50
        {
            let diff =  bg2.position.y + bg2.size.height/2 - 50
            bg2.position.y = self.frame.height + bg2.size.height/2 + diff
        }
        else
        {
            bg2.position.y -= 50
        }

        
        if (!self.paused)
        {
            if isGreenLightON
            {
                score += 1
                if (score > highScore){
                    highScore = score
                    
                    let HighscoreDefault = NSUserDefaults.standardUserDefaults()
                    HighscoreDefault.setValue(highScore, forKey: "Highscore")
                    HighscoreDefault.synchronize()
                    
                }
                
                
                
            }
            else
            {
                self.paused = true
                
                if (GAMEOVER.parent != nil)
                {
                    GAMEOVER.removeFromParent()
                }
                
                let GAMEOVERTEXTURE = SKTexture(imageNamed: "GAME OVER.png")
                
                GAMEOVER = SKSpriteNode(texture: GAMEOVERTEXTURE)
                GAMEOVER.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
                GAMEOVER.size.height = self.frame.height
                self.addChild(GAMEOVER)

                /*
                if (gameOverLabel.parent != nil)
                {
                    gameOverLabel.removeFromParent()
                }
                gameOverLabel.fontName = "Helvetica"
                gameOverLabel.fontColor = UIColor.blackColor()
                gameOverLabel.fontSize = 25
                gameOverLabel.text = "Game Over! Tap to Play Again"
                gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
                self.addChild(gameOverLabel)
            */
            }
        }
        else
        {
            score = 0
            if (GAMEOVER.parent != nil)
            {
               GAMEOVER.removeFromParent()
                
            }
            /*
            if (gameOverLabel.parent != nil)
            {
                gameOverLabel.removeFromParent()
            }
*/
            self.paused = false
        }
        scoreLabel.text = "\(score)"
        highScoreLabel.text = "\(highScore)"
        
        }
        
}
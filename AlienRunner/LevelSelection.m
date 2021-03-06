//
//  LevelSelection.m
//  AlienRunner
//
//  Created by Simeon Andreev on 1/11/16.
//  Copyright © 2016 Simeon Andreev. All rights reserved.
//

#import "LevelSelection.h"
#import "Constants.h"
#import "MainMenuScene.h"

@implementation LevelSelection 

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        // Set background color.
        self.backgroundColor = [SKColor colorWithRed:0.16 green:0.27 blue:0.3 alpha:1.0];
        // Setup title node.
        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Futura"];
        title.text = @"Select Level";
        title.fontColor = [SKColor colorWithRed:0.518 green:0.78 blue:1.0 alpha:1.0];
        title.fontSize = 40;
        title.position = CGPointMake(size.width * 0.5, size.height - 100);
        [self addChild:title];
        
        // Setup layout node.
        SKNode *layoutNode = [SKNode node];
        [self addChild:layoutNode];
        
        SKTexture *buttonDisabledTexture = [SKTexture textureWithImageNamed:@"LevelLocked"];
        NSInteger levelUnlocked = [[NSUserDefaults standardUserDefaults] integerForKey:kARHighestUnlockedLevel];
        // Add buttons for levels.
        for (int i = 1; i <= kARHighestLevel; i++) {
            SKTexture *buttonTexture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"Level%d", i]];
            TPButton *levelButton = [TPButton spriteNodeWithTexture:buttonTexture andDisabledTexture:buttonDisabledTexture];
            levelButton.disabled = (i > levelUnlocked);
            levelButton.position = CGPointMake((i-1)*50 , 0);
            levelButton.delegate = self;
            levelButton.name = [NSString stringWithFormat:@"%d",i];
            [layoutNode addChild:levelButton];
        }
        
        CGRect layoutFrame = [layoutNode calculateAccumulatedFrame];
        layoutNode.position = CGPointMake(self.size.width * 0.5 - (layoutFrame.size.width * 0.5) - layoutFrame.origin.x,
                                          self.size.height - 170);
        
    }
    return self;
}

-(void)buttonPressed:(TPButton *)button
{
    // Save selected level.
    [[NSUserDefaults standardUserDefaults] setInteger:[button.name integerValue] forKey:kARSelectedLevel];
    // Switch to main menu.
    MainMenuScene *mainMenu = [[MainMenuScene alloc] initWithSize:self.size];
    [self.view presentScene:mainMenu transition:[SKTransition pushWithDirection:SKTransitionDirectionRight duration:0.6]];
}

@end

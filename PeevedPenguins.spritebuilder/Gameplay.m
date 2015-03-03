//
//  Gameplay.m
//  PeevedPenguins
//
//  Created by Chaowarit Ongkum on 3/3/2558 BE.
//  Copyright (c) 2558 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay{
    CCPhysicsNode *_physicsNode;
    CCNode *_catapultArm;
    CCNode *_levelNode;
    CCNode *_contentNode;
    CCNode *_pullbackNode;
    CCNode *_mouseJointNode;
    CCPhysicsJoint *_mouseJoint;
}

-(void)retry{
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"Gameplay"]];
}

-(void)didLoadFromCCB{
    self.userInteractionEnabled = TRUE;
    CCScene *level = [CCBReader loadAsScene:@"Levels/Level1"];
    [_levelNode addChild:level];
    _pullbackNode.physicsBody.collisionMask = @[];
    _mouseJointNode.physicsBody.collisionMask = @[];
    
//    _physicsNode.debugDraw = TRUE;
}

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    CGPoint touchLocation = [touch locationInNode:_contentNode];
    if (CGRectContainsPoint([_catapultArm boundingBox], touchLocation)) {
        _mouseJointNode.position = touchLocation;
        
        _mouseJoint = [CCPhysicsJoint connectedSpringJointWithBodyA:_mouseJointNode.physicsBody bodyB:_catapultArm.physicsBody anchorA:ccp(0, 0) anchorB:ccp(34, 138) restLength:0.f stiffness:3000.0f damping:150.f];
    }
}

-(void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    CGPoint toucLocation = [touch locationInNode:_contentNode];
    _mouseJointNode.position = toucLocation;
}

-(void) releaseCatapult{
    if (_mouseJoint != nil) {
        [_mouseJoint invalidate];
        _mouseJoint = nil;
    }
}

-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    [self releaseCatapult];
}

-(void)touchCancelled:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    [self releaseCatapult];
}

-(void)launchPenguin{
    CCNode *penguin = [CCBReader load:@"Penguin"];
    penguin.position = ccpAdd(_catapultArm.position, ccp(16,50));
    
    [_physicsNode addChild:penguin];
    
    CGPoint launchDirection = ccp(1, 0);
    CGPoint force = ccpMult(launchDirection, 8000);
    [penguin.physicsBody applyForce:force];
    
    self.position = ccp(0,0);
    CCActionFollow *follow = [CCActionFollow actionWithTarget:penguin worldBoundary:self.boundingBox];
    [_contentNode runAction:follow];
}

@end

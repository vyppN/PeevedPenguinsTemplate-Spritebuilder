//
//  WaitingPenguin.m
//  PeevedPenguins
//
//  Created by Chaowarit Ongkum on 3/3/2558 BE.
//  Copyright (c) 2558 Apportable. All rights reserved.
//

#import "WaitingPenguin.h"

@implementation WaitingPenguin

-(void)didLoadFromCCB{
    float delay = (arc4random()%2000)/1000.f;
    [self performSelector:@selector(startBlinkAndJump) withObject:nil afterDelay:delay];
}

-(void)startBlinkAndJump{
    CCAnimationManager *animationManager = self.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"BlinkAndJump"];
}

@end

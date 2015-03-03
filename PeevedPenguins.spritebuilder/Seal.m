//
//  Seal.m
//  PeevedPenguins
//
//  Created by Chaowarit Ongkum on 3/3/2558 BE.
//  Copyright (c) 2558 Apportable. All rights reserved.
//

#import "Seal.h"

@implementation Seal

-(void)didLoadFromCCB{
    self.physicsBody.collisionType = @"seal";
}

@end

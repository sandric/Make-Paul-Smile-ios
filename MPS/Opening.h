//
//  Opening.h
//  MPS
//
//  Created by sandric on 17.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Move.h"

@interface Opening : NSObject

- (id) initWithName:(NSString *)name AndMoves:(NSArray *)moves AndAnnotations:(NSArray *)annotations AndStartingMove:(NSInteger)startingMove AndDetails:(NSString *)details;


- (BOOL) isValidMove:(Move *)move;

- (NSArray *) getHint;


@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSArray *moves;

@property (strong, nonatomic) NSArray *annotations;

@property NSInteger startingMove;

@property NSInteger movesCount;

@property NSInteger movesToPlay;

@property NSString *details;


@end
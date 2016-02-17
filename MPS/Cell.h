//
//  Cell.h
//  MPS
//
//  Created by sandric on 17.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Piece.h"

@interface Cell : NSObject

- (id) initWithColor:(NSString *)color row:(NSInteger)row column:(NSInteger)column piece:(Piece *)piece;

- (BOOL) isEmpty;
- (BOOL) isEnemy:(Cell *)cell;
- (BOOL) isFriend:(Cell *)cell;

- (void) select;
- (void) deselect;
- (void) validate;
- (void) unvalidate;
- (void) expect;
- (void) unexpect;


- (NSInteger) getTag;
- (NSString *) getNotation;



@property (strong, nonatomic) Piece *piece;

@property (strong, nonatomic) NSString *color;

@property NSInteger row;
@property NSInteger column;

@property BOOL isSelected;
@property BOOL isValid;
@property BOOL isExpected;

@end

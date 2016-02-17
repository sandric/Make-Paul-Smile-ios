//
//  Move.h
//  MPS
//
//  Created by sandric on 17.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"

@interface Move : NSObject

- (id) initWithMoveFrom:(Cell *)moveFrom AndMoveTo:(Cell *)moveTo AndNumber:(NSInteger)number;

- (NSString *) getNotation;

- (NSString *) getRelativeNotation;

+ (NSArray *)getCellPositionsFromNotation:(NSString *)notation;



@property (strong, nonatomic) Cell *moveFrom;
@property (strong, nonatomic) Cell *moveTo;

@property (strong, nonatomic) NSString *side;
@property NSInteger number;

@end

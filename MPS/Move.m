//
//  Move.m
//  MPS
//
//  Created by sandric on 17.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

#import "Move.h"

@implementation Move

- (id) initWithMoveFrom:(Cell *)moveFrom AndMoveTo:(Cell *)moveTo AndNumber:(NSInteger)number {
    if (self = [self init]) {
        self.moveFrom = moveFrom;
        self.moveTo = moveTo;
        self.number = number;
        self.side = moveFrom.piece.side;
    }
    
    return self;
}


- (NSString *) getNotation {
    return [NSString stringWithFormat:@"%@%@%@%@",
            [self.moveFrom.piece getNotation],
            [self.moveFrom getNotation],
            ([self.moveTo isEmpty]) ? @" - " : @" x ",
            [self.moveTo getNotation]];
    
}

- (NSString *) getRelativeNotation {
    if (self.number % 2 == 1)
        return [NSString stringWithFormat:@"%d. %@; ",
                (self.number / 2) + 1,
                self.getNotation];
    else
        return [NSString stringWithFormat:@"%@. ",
                self.getNotation];
}


+ (NSArray *)getCellPositionsFromNotation:(NSString *)notation {
    
    NSArray *cellsNotationsWithPiece = [notation componentsSeparatedByString:@" - "];
    
    NSString *fromNotation = [cellsNotationsWithPiece[0] substringFromIndex: [cellsNotationsWithPiece[0] length] - 2];
    NSString *toNotation = [cellsNotationsWithPiece[1] substringFromIndex: [cellsNotationsWithPiece[1] length] - 2];
    
    return [NSArray arrayWithObjects:fromNotation, toNotation, nil];
}

@end
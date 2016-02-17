//
//  Opening.m
//  MPS
//
//  Created by sandric on 17.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

#import "Opening.h"
#import "Board.h"

@implementation Opening


- (id) initWithName:(NSString *)name AndMoves:(NSArray *)moves AndAnnotations:(NSArray *)annotations AndStartingMove:(NSInteger)startingMove AndDetails:(NSString *)details {
    if (self = [self init]) {
        self.name = name;
        self.moves = moves;
        self.annotations = annotations;
        self.startingMove = startingMove;
        self.movesCount = self.moves.count;
        self.movesToPlay = self.movesCount - self.startingMove;
        self.details = details;
    }
    
    return self;
}


- (BOOL) isValidMove:(Move *)move {
    if ([[move getNotation] isEqualToString:self.moves[move.number - 1]])
        return true;
    else
        return false;
}


- (NSArray *)getHint {
    NSLog(@"moves: %@", self.moves[Board.currentMoveNumber - 1]);
    return [Move getCellPositionsFromNotation:self.moves[Board.currentMoveNumber - 1]];
}


@end

//
//  Cell.m
//  MPS
//
//  Created by sandric on 17.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (id) initWithColor:(NSString *)color row:(NSInteger)row column:(NSInteger)column piece:(Piece *)piece {
    if (self = [self init]) {
        self.color = color;
        self.row = row;
        self.column = column;
        self.piece = piece;
    }
    
    return self;
}




- (BOOL) isEmpty {
    return !self.piece;
}

- (BOOL) isEnemy:(Cell *)cell {
    return (self.piece && cell.piece && ![self.piece.side isEqualToString:cell.piece.side]);
}

- (BOOL) isFriend:(Cell *)cell {
    return (self.piece && cell.piece && [self.piece.side isEqualToString:cell.piece.side]);
}




- (void) select {
    self.isSelected = true;
}

- (void) deselect {
    self.isSelected = false;
}

- (void) validate {
    self.isValid = true;
}

- (void) unvalidate {
    self.isValid = false;
}

- (void) expect {
    self.isExpected = true;
}

- (void) unexpect {
    self.isExpected = false;
}


- (NSInteger) getTag {
    return (self.row * 10) + self.column;
}

- (NSString *) getNotation {
    NSArray *letters = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h"];
    
    return [NSString stringWithFormat:@"%@%i", letters[self.column - 1], self.row];
}



@end
//
//  Piece.m
//  MPS
//
//  Created by sandric on 17.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

#import "Piece.h"

@implementation Piece

- (id) initWithSide:(NSString *)side AndType:(NSString *)type {
    if (self = [self init]) {
        self.side = side;
        self.type = type;
        self.moved = false;
    }
    
    return self;
}

- (void) move {
    self.moved = true;
}

- (NSString *) imagePath {
    return [NSString stringWithFormat:@"%@/%@.png", self.side, self.type];
}

- (NSString *) getNotation {
    NSString *pieceNotation = @"";
    
    if ([self.type isEqualToString:@"knight"])
        pieceNotation = @"N";
    else if ([self.type isEqualToString:@"bishop"])
        pieceNotation = @"B";
    else if ([self.type isEqualToString:@"rook"])
        pieceNotation = @"R";
    else if ([self.type isEqualToString:@"queen"])
        pieceNotation = @"Q";
    else if ([self.type isEqualToString:@"king"])
        pieceNotation = @"K";
    
    return pieceNotation;
}


@end

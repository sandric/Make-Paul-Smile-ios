//
//  Ruler.m
//  MPS
//
//  Created by sandric on 17.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

#import "Ruler.h"
#import "Board.h"

@implementation Ruler

- (id) initWithBoard:(Board *)board {
    if (self = [self init]) {
        self.board = board;
    }
    
    return self;
}



- (void) validOnVerticalUpWithLength:(NSInteger)length {
    int validCellsLength = 0;
    for (int row = self.selectedCell.row + 1; row < 9; row++) {
        if (length && (validCellsLength >= length)) break;
        
        Cell *cell = [self.board getCellOnRow:row AndColumn:self.selectedCell.column];
        if ([cell isFriend:self.selectedCell]) break;
        [cell validate];
        validCellsLength++;
        if ([cell isEnemy:self.selectedCell]) break;
    }
}

- (void) validOnVerticalDownWithLength:(NSInteger)length {
    int validCellsLength = 0;
    for (int row = self.selectedCell.row - 1; row > 0; row--) {
        if (length && (validCellsLength >= length)) break;
        
        Cell *cell = [self.board getCellOnRow:row AndColumn:self.selectedCell.column];
        if ([cell isFriend:self.selectedCell]) break;
        [cell validate];
        validCellsLength++;
        if ([cell isEnemy:self.selectedCell]) break;
    }
}

- (void) validOnHorizontalLeftWithLength:(NSInteger)length {
    int validCellsLength = 0;
    for (int column = self.selectedCell.column - 1; column > 0; column--) {
        if (length && (validCellsLength >= length)) break;
        
        Cell *cell = [self.board getCellOnRow:self.selectedCell.row AndColumn:column];
        if ([cell isFriend:self.selectedCell]) break;
        [cell validate];
        validCellsLength++;
        if ([cell isEnemy:self.selectedCell]) break;
    }
}

- (void) validOnHorizontalRightWithLength:(NSInteger)length {
    int validCellsLength = 0;
    for (int column = self.selectedCell.column + 1; column < 9; column++) {
        if (length && (validCellsLength >= length)) break;
        
        Cell *cell = [self.board getCellOnRow:self.selectedCell.row AndColumn:column];
        if ([cell isFriend:self.selectedCell]) break;
        [cell validate];
        validCellsLength++;
        if ([cell isEnemy:self.selectedCell]) break;
    }
}





- (void) validOnDiagonalTopLeftWithLength:(NSInteger)length {
    int validCellsLength = 0;
    for (int i = 1, row = self.selectedCell.row + 1; row < 9; row++, i++) {
        if (length && (validCellsLength >= length)) break;
        if (self.selectedCell.column - i < 1) break;
        
        Cell *cell = [self.board getCellOnRow:row AndColumn:self.selectedCell.column - i];
        if ([cell isFriend:self.selectedCell]) break;
        [cell validate];
        validCellsLength++;
        if ([cell isEnemy:self.selectedCell]) break;
    }
}


- (void) validOnDiagonalTopRightWithLength:(NSInteger)length {
    int validCellsLength = 0;
    for (int i = 1, row = self.selectedCell.row + 1; row < 9; row++, i++) {
        if (length && (validCellsLength >= length)) break;
        if (self.selectedCell.column + i > 8) break;
        
        Cell *cell = [self.board getCellOnRow:row AndColumn:self.selectedCell.column + i];
        if ([cell isFriend:self.selectedCell]) break;
        [cell validate];
        validCellsLength++;
        if ([cell isEnemy:self.selectedCell]) break;
    }
}


- (void) validOnDiagonalBottomLeftWithLength:(NSInteger)length {
    int validCellsLength = 0;
    for (int i = 1, row = self.selectedCell.row - 1; row > 0; row--, i++) {
        if (length && (validCellsLength >= length)) break;
        if (self.selectedCell.column - i < 1) break;
        
        Cell *cell = [self.board getCellOnRow:row AndColumn:self.selectedCell.column - i];
        if ([cell isFriend:self.selectedCell]) break;
        [cell validate];
        validCellsLength++;
        if ([cell isEnemy:self.selectedCell]) break;
    }
}


- (void) validOnDiagonalBottomRightWithLength:(NSInteger)length {
    int validCellsLength = 0;
    for (int i = 1, row = self.selectedCell.row - 1; row > 0; row--, i++) {
        if (length && (validCellsLength >= length)) break;
        if (self.selectedCell.column + i > 8) break;
        
        Cell *cell = [self.board getCellOnRow:row AndColumn:self.selectedCell.column + i];
        if ([cell isFriend:self.selectedCell]) break;
        [cell validate];
        validCellsLength++;
        if ([cell isEnemy:self.selectedCell]) break;
    }
}



- (void) validOnKnightForMainDirection:(NSString *)mainDirection AndSecondaryDirection:(NSString *)secondaryDirection {
    
    NSInteger mainVector[2], secondaryVector[2];
    
    if ([mainDirection isEqualToString:@"top"]) {
        mainVector[0] = 1;
        mainVector[1] = 0;
    } else if ([mainDirection isEqualToString:@"bottom"]) {
        mainVector[0] = -1;
        mainVector[1] = 0;
    } else if ([mainDirection isEqualToString:@"left"]) {
        mainVector[0] = 0;
        mainVector[1] = -1;
    } else if ([mainDirection isEqualToString:@"right"]) {
        mainVector[0] = 0;
        mainVector[1] = 1;
    }
    
    if ([secondaryDirection isEqualToString:@"top"]) {
        secondaryVector[0] = 1;
        secondaryVector[1] = 0;
    } else if ([secondaryDirection isEqualToString:@"bottom"]) {
        secondaryVector[0] = -1;
        secondaryVector[1] = 0;
    } else if ([secondaryDirection isEqualToString:@"left"]) {
        secondaryVector[0] = 0;
        secondaryVector[1] = -1;
    } else if ([secondaryDirection isEqualToString:@"right"]) {
        secondaryVector[0] = 0;
        secondaryVector[1] = 1;
    }
    
    Cell *first = [self.board getCellOnRow:(self.selectedCell.row + mainVector[0]) AndColumn:(self.selectedCell.column + mainVector[1])];
    
    if (first) {
        Cell *second = [self.board getCellOnRow:(first.row + mainVector[0]) AndColumn:(first.column + mainVector[1])];
        
        if (second) {
            Cell *third = [self.board getCellOnRow:(second.row + secondaryVector[0]) AndColumn:(second.column + secondaryVector[1])];
            
            if (third && ([third isEmpty] || [third isEnemy:self.selectedCell]))
                [third validate];
        }
    }
}



- (void)validStraightWithLength:(NSInteger)length {
    [self validOnVerticalUpWithLength:length];
    [self validOnVerticalDownWithLength:length];
    [self validOnHorizontalLeftWithLength:length];
    [self validOnHorizontalRightWithLength:length];
}


- (void)validDiagonalWithLength:(NSInteger)length {
    [self validOnDiagonalTopLeftWithLength:length];
    [self validOnDiagonalTopRightWithLength:length];
    [self validOnDiagonalBottomLeftWithLength:length];
    [self validOnDiagonalBottomRightWithLength:length];
}




- (void)checkPawn {
    Cell *superTopCell;
    Cell *topCell;
    Cell *topLeftCell;
    Cell *topRightCell;
    
    if ([self.selectedCell.piece.side isEqualToString:@"white"]) {
        if (!self.selectedCell.piece.moved)
            superTopCell = [self.board getCellOnRow:self.selectedCell.row + 2 AndColumn:self.selectedCell.column];
        topCell = [self.board getCellOnRow:self.selectedCell.row + 1 AndColumn:self.selectedCell.column];
        topLeftCell = [self.board getCellOnRow:self.selectedCell.row + 1 AndColumn:self.selectedCell.column - 1];
        topRightCell = [self.board getCellOnRow:self.selectedCell.row + 1 AndColumn:self.selectedCell.column + 1];
    } else {
        if (!self.selectedCell.piece.moved)
            superTopCell = [self.board getCellOnRow:self.selectedCell.row - 2 AndColumn:self.selectedCell.column];
        topCell = [self.board getCellOnRow:self.selectedCell.row - 1 AndColumn:self.selectedCell.column];
        topLeftCell = [self.board getCellOnRow:self.selectedCell.row - 1 AndColumn:self.selectedCell.column - 1];
        topRightCell = [self.board getCellOnRow:self.selectedCell.row - 1 AndColumn:self.selectedCell.column + 1];
    }
    
    if (superTopCell && [superTopCell isEmpty])
        [superTopCell validate];
    if (topCell && [topCell isEmpty])
        [topCell validate];
    if (topLeftCell && [topLeftCell isEnemy:self.selectedCell])
        [topLeftCell validate];
    if (topRightCell && [topRightCell isEnemy:self.selectedCell])
        [topRightCell validate];
}

- (void)checkKnight {
    [self validOnKnightForMainDirection:@"top" AndSecondaryDirection:@"left"];
    [self validOnKnightForMainDirection:@"top" AndSecondaryDirection:@"right"];
    [self validOnKnightForMainDirection:@"bottom" AndSecondaryDirection:@"left"];
    [self validOnKnightForMainDirection:@"bottom" AndSecondaryDirection:@"right"];
    [self validOnKnightForMainDirection:@"left" AndSecondaryDirection:@"top"];
    [self validOnKnightForMainDirection:@"left" AndSecondaryDirection:@"bottom"];
    [self validOnKnightForMainDirection:@"right" AndSecondaryDirection:@"top"];
    [self validOnKnightForMainDirection:@"right" AndSecondaryDirection:@"bottom"];
    
}

- (void)checkBishop {
    [self validDiagonalWithLength:0];
}

- (void)checkRook {
    [self validStraightWithLength:0];
}

- (void)checkQueen {
    [self validDiagonalWithLength:0];
    [self validStraightWithLength:0];
}

- (void)checkKing {
    [self validDiagonalWithLength:1];
    [self validStraightWithLength:1];
}



- (void)checkForCell:(Cell *)selectedCell {
    
    self.selectedCell = selectedCell;
    
    if ([self.selectedCell.piece.type isEqualToString:@"pawn"]) {
        [self checkPawn];
    } else if ([self.selectedCell.piece.type isEqualToString:@"knight"]) {
        [self checkKnight];
    } else if ([self.selectedCell.piece.type isEqualToString:@"bishop"]) {
        [self checkBishop];
    } else if ([self.selectedCell.piece.type isEqualToString:@"rook"]) {
        [self checkRook];
    } else if ([self.selectedCell.piece.type isEqualToString:@"queen"]) {
        [self checkQueen];
    } else if ([self.selectedCell.piece.type isEqualToString:@"king"]) {
        [self checkKing];
    }
    
}




@end
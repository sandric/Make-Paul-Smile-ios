//
//  Board.m
//  MPS
//
//  Created by sandric on 17.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

#import "Board.h"
#import "Piece.h"
#import "Move.h"

@implementation Board


static NSInteger currentMoveNumber;

+ (NSInteger)currentMoveNumber {
    return currentMoveNumber;
}

+ (void)setCurrentMoveNumber:(NSInteger)newCurrentMoveNumber {
    currentMoveNumber = newCurrentMoveNumber;
}


- (id) initWithOpening:(Opening *)opening AndType:(NSString *)type AndViewControllerDelegate:(id <BoardViewControllerDelegate>)delegate {
    if (self = [self init]) {
        Board.currentMoveNumber = 1;
        
        self.opening = opening;
        
        self.type = type;
        
        self.delegate = delegate;
        
        [self.delegate displayInfoMessage:[NSString stringWithFormat:@"You playing a %@ game", self.type]];
        
        [self generate];
    }
    
    return self;
}

- (void) generateCells {
    NSString *cellColor;
    NSString *firstCellColor, *secondCellColor;
    
    self.cells = [[NSMutableArray alloc] init];
    
    for (int i  = 0; i < 8; i++) {
        if (i % 2 == 0) {
            firstCellColor = @"black";
            secondCellColor = @"white";
        } else {
            firstCellColor = @"white";
            secondCellColor = @"black";
        }
        for (int j = 0; j < 8; j++) {
            if (j % 2 == 0)
                cellColor = firstCellColor;
            else
                cellColor = secondCellColor;
            
            [self.cells addObject:[[Cell alloc] initWithColor:cellColor row:i + 1 column:j + 1 piece:nil]];
        }
    }
}

- (void) generatePieces {
    [self getCellOnRow:1 AndColumn:1].piece = [[Piece alloc] initWithSide:@"white" AndType:@"rook"];
    [self getCellOnRow:1 AndColumn:2].piece = [[Piece alloc] initWithSide:@"white" AndType:@"knight"];
    [self getCellOnRow:1 AndColumn:3].piece = [[Piece alloc] initWithSide:@"white" AndType:@"bishop"];
    [self getCellOnRow:1 AndColumn:4].piece = [[Piece alloc] initWithSide:@"white" AndType:@"queen"];
    [self getCellOnRow:1 AndColumn:5].piece = [[Piece alloc] initWithSide:@"white" AndType:@"king"];
    [self getCellOnRow:1 AndColumn:6].piece = [[Piece alloc] initWithSide:@"white" AndType:@"bishop"];
    [self getCellOnRow:1 AndColumn:7].piece = [[Piece alloc] initWithSide:@"white" AndType:@"knight"];
    [self getCellOnRow:1 AndColumn:8].piece = [[Piece alloc] initWithSide:@"white" AndType:@"rook"];
    
    [self getCellOnRow:8 AndColumn:1].piece = [[Piece alloc] initWithSide:@"black" AndType:@"rook"];
    [self getCellOnRow:8 AndColumn:2].piece = [[Piece alloc] initWithSide:@"black" AndType:@"knight"];
    [self getCellOnRow:8 AndColumn:3].piece = [[Piece alloc] initWithSide:@"black" AndType:@"bishop"];
    [self getCellOnRow:8 AndColumn:4].piece = [[Piece alloc] initWithSide:@"black" AndType:@"queen"];
    [self getCellOnRow:8 AndColumn:5].piece = [[Piece alloc] initWithSide:@"black" AndType:@"king"];
    [self getCellOnRow:8 AndColumn:6].piece = [[Piece alloc] initWithSide:@"black" AndType:@"bishop"];
    [self getCellOnRow:8 AndColumn:7].piece = [[Piece alloc] initWithSide:@"black" AndType:@"knight"];
    [self getCellOnRow:8 AndColumn:8].piece = [[Piece alloc] initWithSide:@"black" AndType:@"rook"];
    
    
    for (int i = 1; i < 9; i++) {
        [self getCellOnRow:2 AndColumn:i].piece = [[Piece alloc] initWithSide:@"white" AndType:@"pawn"];
        [self getCellOnRow:7 AndColumn:i].piece = [[Piece alloc] initWithSide:@"black" AndType:@"pawn"];
    }
}

- (void) generate {
    [self generateCells];
    [self generatePieces];
    
    self.ruler = [[Ruler alloc] initWithBoard:self];
    
    [self.delegate onBoardGenerated];
}

- (void) simulateMove {
    if (![self isEnded]) {
        NSArray *expectation = [self.opening getHint];
        [self moveFromCell:[self getCellFromPosition:expectation[0]] ToCell:[self getCellFromPosition:expectation[1]]];
    }
}

- (void) startMovesSimulation {
    if ([self isLearningGame]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(simulateMove) userInfo:nil repeats:YES];
    }
}

- (void) stopMovesSimulation {
    if (self.timer != nil)
        [self.timer invalidate];
}


- (void) selectCell:(Cell *)cell {
    if (self.moveFrom != nil)
        self.moveTo = cell;
    else
        self.moveFrom = cell;
}

- (Cell *)moveFrom {
    return _moveFrom;
}

- (void)setMoveFrom:(Cell *)newMoveFrom {
    [self removeSelection];
    [self removeValidation];
    [self removeHint];
    
    if (!newMoveFrom)
        _moveFrom = newMoveFrom;
    else
        if (![newMoveFrom isEmpty]) {
            if ([self isTurnsPiece:newMoveFrom.piece]) {
                _moveFrom = newMoveFrom;
                [_moveFrom select];
                [self.ruler checkForCell:_moveFrom];
            }
            else
                [self.delegate displayInfoMessage:@"Its other's side turn now"];
        }
        else
            [self.delegate displayInfoMessage:@"You need to select piece, silly!"];
}


- (Cell *)moveTo {
    return _moveTo;
}

- (void)setMoveTo:(Cell *)newMoveTo {
    [self removeHint];
    
    if (self.moveFrom == newMoveTo) {
        self.moveFrom = nil;
    } else {
        if ([self.moveFrom isFriend:newMoveTo])
            self.moveFrom = newMoveTo;
        else
            if ([newMoveTo isValid]) {
                _moveTo = newMoveTo;
                [self moveFromCell:self.moveFrom ToCell:self.moveTo];
                self.moveFrom = nil;
                _moveTo = nil;
            } else
                [self.delegate displayInfoMessage:[NSString stringWithFormat:@"No, %@ can't move that way darling.", self.moveFrom.piece.type]];
        
    }
}

- (void) moveFromCell:(Cell *)fromCell ToCell:(Cell *)toCell {
    
    Move *move = [[Move alloc] initWithMoveFrom:fromCell AndMoveTo:toCell AndNumber:Board.currentMoveNumber];
    
    if ([self.opening isValidMove:move]) {
        
        [self.delegate displayMoveNotation:[move getRelativeNotation]];
        
        [self movePieceFromCell:fromCell toCell:toCell];
        
        Board.currentMoveNumber++;
        
        if ([self isTrainingGame]) {
            [self.delegate displayInfoMessage:@"Yep, good job!"];
            [self.delegate onPlayerMadeMove];
        } else
            [self.delegate onComputerMadeMove];
        
        if ([self isEnded])
            [self.delegate onGameEnded];
    }
    else
    {
        [self.delegate displayInfoMessage:@"Nope, its not that."];
        [self.delegate onPlayerMadeMistake];
    }
}

- (void) movePieceFromCell:(Cell *)fromCell toCell:(Cell *)toCell {
    toCell.piece = fromCell.piece;
    [fromCell.piece move];
    fromCell.piece = nil;
}


- (void) removeSelection {
    for (Cell *cell in self.cells)
        [cell deselect];
}

- (void) removeValidation {
    for (Cell *cell in self.cells)
        [cell unvalidate];
}

- (void) highlightHint {
    NSArray *expectation = [self.opening getHint];
    
    [[self getCellFromPosition:expectation[0]] expect];
    [[self getCellFromPosition:expectation[1]] expect];
}

- (void) removeHint {
    for (Cell *cell in self.cells)
        [cell unexpect];
}



- (Cell *) getCellOnRow:(NSInteger)row AndColumn:(NSInteger)column {
    if (row > 0 && row < 9 && column > 0 && column < 9)
        return self.cells[((row - 1) * 8) + (column - 1)];
    else
        return nil;
}

- (Cell *) getCellFromPosition:(NSString *)position {
    NSArray *letters = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h"];
    
    NSString *rowLetter = [position substringToIndex:1];
    
    NSInteger row = [[position substringWithRange:NSMakeRange(1, 1)] intValue];
    NSInteger column = 1;
    
    for (NSString *letter in letters) {
        if ([letter isEqualToString:rowLetter])
            break;
        column++;
    }
    
    return [self getCellOnRow:row AndColumn:column];
}



- (BOOL) isLearningGame {
    return ([self.type isEqualToString:@"learning"]);
}

- (BOOL) isTrainingGame {
    return ([self.type isEqualToString:@"training"]);
}

- (BOOL) isEnded {
    return (Board.currentMoveNumber > self.opening.movesCount);
}


- (BOOL) isTurnsPiece:(Piece *)piece {
    return ((Board.currentMoveNumber % 2 == 0 && [piece.side isEqualToString:@"black"]) ||
            (Board.currentMoveNumber % 2 == 1 && [piece.side isEqualToString:@"white"]));
}



@end
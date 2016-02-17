//
//  Board.h
//  MPS
//
//  Created by sandric on 17.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"
#import "Move.h"
#import "Ruler.h"
#import "Opening.h"

#import "BoardViewControllerProtocol.h"


@interface Board : NSObject {
    Cell *_moveFrom;
    Cell *_moveTo;
}

+ (NSInteger)currentMoveNumber;
+ (void)setCurrentMoveNumber:(NSInteger)newCurrentMoveNumber;

- (void)setMoveFrom:(Cell *)cell;
- (Cell *)moveFrom;
- (void)setMoveTo:(Cell *)cell;
- (Cell *)moveTo;


- (id) initWithOpening:(Opening *)opening AndType:(NSString *)type AndViewControllerDelegate:(id<BoardViewControllerDelegate>)delegate;

- (void) generate;

- (void) selectCell:(Cell *)cell;

- (void) simulateMove;
- (void) startMovesSimulation;
- (void) stopMovesSimulation;


- (void) removeSelection;
- (void) removeValidation;

- (void) highlightHint;
- (void) removeHint;

- (Cell *) getCellOnRow:(NSInteger)row AndColumn:(NSInteger)column;
- (Cell *) getCellFromPosition:(NSString *)position;


@property (weak, nonatomic) id <BoardViewControllerDelegate> delegate;


@property (strong, nonatomic) NSString *type;

@property (strong, nonatomic) NSMutableArray *cells;

@property (strong, nonatomic) Ruler *ruler;
@property (strong, nonatomic) Opening *opening;

@property (strong, nonatomic) NSTimer *timer;

@end
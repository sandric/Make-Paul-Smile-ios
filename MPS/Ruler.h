//
//  Ruler.h
//  MPS
//
//  Created by sandric on 17.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Board;
@class Cell;

@interface Ruler : NSObject

- (id) initWithBoard:(Board *)board;

- (void)checkForCell:(Cell *)selectedCell;



@property (strong, nonatomic) Board *board;

@property (strong, nonatomic) Cell *selectedCell;

@end

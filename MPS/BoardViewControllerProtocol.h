//
//  BoardViewControllerProtocol.h
//  MPS
//
//  Created by sandric on 17.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

#ifndef BoardViewControllerProtocol_h
#define BoardViewControllerProtocol_h


#endif /* BoardViewControllerProtocol_h */

@protocol BoardViewControllerDelegate <NSObject>

@required

- (void) displayInfoMessage:(NSString *)message;
- (void) displayMoveNotation:(NSString *)move;
- (void) onBoardGenerated;
- (void) onPlayerMadeMove;
- (void) onComputerMadeMove;
- (void) onPlayerMadeMistake;
- (void) onGameEnded;

@end
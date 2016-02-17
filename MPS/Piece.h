//
//  Piece.h
//  MPS
//
//  Created by sandric on 17.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Piece : NSObject

- (id) initWithSide:(NSString *)side AndType:(NSString *)type;

- (void) move;

- (NSString *) imagePath;
- (NSString *) getNotation;


@property (strong, nonatomic) NSString *side;
@property (strong, nonatomic) NSString *type;
@property BOOL moved;

@end

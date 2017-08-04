//
//  RBRWineryModel.h
//  Baccus
//
//  Created by Ruben Berreguero on 06/09/13.
//  Copyright (c) 2013 Ruben Berreguero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBRWineModel.h"


#define RED_WINE_KEY @"Tinto"
#define WHITE_WINE_KEY @"Blanco"
#define OTHER_WINE_KEY @"Rosado"

#define FILENAME_JSON @"dataJson.txt"

@interface RBRWineryModel : NSObject



//Proopiedades de Solo lectura
@property (readonly, nonatomic) int redWineCount;
@property (readonly, nonatomic) int whiteWineCount;
@property (readonly, nonatomic) int otherWineCount;


-(RBRWineModel *) redWineAtIndex: (NSUInteger) index;
-(RBRWineModel *) whiteWineAtIndex: (NSUInteger) index;
-(RBRWineModel *) otherWineAtIndex: (NSUInteger) index;




@end

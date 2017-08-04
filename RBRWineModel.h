//
//  RBRWineModel.h
//  Baccus
//
//  Created by Ruben Berreguero on 29/08/13.
//  Copyright (c) 2013 Ruben Berreguero. All rights reserved.
//

#import <Foundation/Foundation.h>


//Constante:
#define NO_RATING -1


@interface RBRWineModel : NSObject


//Propiedades
//nonatomic por defecto seguros en entorno multitarea, ahorras tiempo

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic, readonly) UIImage *photo;
@property (strong, nonatomic) NSURL *photoURL;
@property (strong, nonatomic) NSURL *wineCompanyWeb;
@property (strong, nonatomic) NSString *notes;
@property (strong, nonatomic) NSString *origin;
@property (nonatomic) int rating; //Nota de 0 a 5
@property (strong, nonatomic) NSArray *grapes; //Uvas
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *wineCompanyName; //Bodega


//Metodos de clase
+(id) wineWithName: (NSString *) aName
    winCompanyName:(NSString *) aWineCompanyName
              type: (NSString *) aType
             orgin:(NSString *) aOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aURL
            notes : (NSString *) aNotes
            rating:(int) aRating
             photoURL:(NSURL *) aPhotoURL;

+(id) wineWithName:(NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type:(NSString *) aType
            origin: (NSString *) aOrigin;


//Inicialidador designado
-(id) initWithName: (NSString *) aName
    wineCompanyName:(NSString *) aWineCompanyName
              type: (NSString *) aType
             orgin:(NSString *) aOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aURL
            notes : (NSString *) aNotes
            rating:(int) aRating
             photoURL:(NSURL *) aPhotoURL;
                                                                                                                                                                                                                 

//Iniciliador de conveniencia
-(id) initWithName:(NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type:(NSString *) aType
            origin: (NSString *) aOrigin;


//Inicialiador a partir de dicccionario JSON
-(id) initWithDictionary: (NSDictionary *) aDict;


@end

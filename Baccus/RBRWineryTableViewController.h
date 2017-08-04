//
//  RBRWineryTableViewController.h
//  Baccus
//
//  Created by Ruben Berreguero on 06/09/13.
//  Copyright (c) 2013 Ruben Berreguero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBRWineryModel.h"


//Definimos constantes para saber que seccion es cada tipo de vino
#define RED_WINE_SECTION 0
#define WHITE_WINE_SECTION 1
#define WOTHER_WINE_SECTION 2

#define NEW_WINE_NOTIFICATION_NAME @"newWine"
#define WINE_KEY @"wine"

#define LAST_WINE_KEY @"lastWine"
#define SECTION_KEY @"section"
#define ROW_KEY @"row"

@class RBRWineryTableViewController; //Para que no de error, se espera de la definamos a continuacion

//Definimos el protocolo delegado
@protocol WineryTableViewControllerDelegate <NSObject>

//Definimos el mensaje
-(void) wineryTableViewController: (RBRWineryTableViewController *) wineryVC didSelectedWine: (RBRWineModel *) aWine;

@end



@interface RBRWineryTableViewController : UITableViewController <WineryTableViewControllerDelegate>


@property (strong, nonatomic) RBRWineryModel *model;
//Creamos propiedad de delegate
@property (nonatomic,weak) id <WineryTableViewControllerDelegate> delegate;



//Inicializador con un modelo  un estilo de tabla (requiere el initTable por defecto)
-(id)initWithModel: (RBRWineryModel *) aModel
            style:(UITableViewStyle) aStyle;


//Devolve el utimo vino
-(RBRWineModel *)lastSelectWine;


@end




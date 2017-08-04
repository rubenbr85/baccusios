//
//  RBRWineryModel.m
//  Baccus
//
//  Created by Ruben Berreguero on 06/09/13.
//  Copyright (c) 2013 Ruben Berreguero. All rights reserved.
//

#import "RBRWineryModel.h"

@interface RBRWineryModel()
//Eso no esta vsible en el .h

@property (strong, nonatomic) NSMutableArray *redWines;
@property (strong, nonatomic) NSMutableArray *whiteWines;
@property (strong, nonatomic) NSMutableArray *otherWines;

@end

@implementation RBRWineryModel

#pragma mark - Properties
//Sobrescrivimos el getter

-(int) redWineCount{
    return [self.redWines count];
}

-(int) whiteWineCount{
    return [self.whiteWines count];
}

-(int) otherWineCount{
    return [self.otherWines count];
}




-(id)init{
    
    if (self = [super init]) {
        
        
        //En vez de bajarlo de lar red, bajar Guardar el JSON en el sandbox y las imagenes tambien
       // en cahes, piede ser borrada ojo¡
       
        NSError *error;
        
        /*
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://baccusapp.herokuapp.com/wines"]];
        NSURLResponse *response = [[NSURLResponse alloc] init];
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
       */
        
        NSData *data =nil;
        
        data= [self dataJSONWineSave];
        
        if (data != nil) {
            // No ha habido error
            NSArray * JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:kNilOptions
                                                                      error:&error];
            
            if (JSONObjects != nil) {
                // No ha habido error
                for(NSDictionary *dict in JSONObjects){
                                        
                    RBRWineModel *wine = [[RBRWineModel alloc] initWithDictionary:dict];
                    
                    // Añadimos al tipo adecuado
                    if ([wine.type isEqualToString:RED_WINE_KEY]) {
                        if (!self.redWines) {
                            self.redWines = [NSMutableArray arrayWithObject:wine];
                        }
                        else {
                            [self.redWines addObject:wine];
                        }
                    }
                    else if ([wine.type isEqualToString:WHITE_WINE_KEY]) {
                        if (!self.whiteWines) {
                            self.whiteWines = [NSMutableArray arrayWithObject:wine];
                        }
                        else {
                            [self.whiteWines addObject:wine];
                        }                    }
                    else {
                        if (!self.otherWines) {
                            self.otherWines = [NSMutableArray arrayWithObject:wine]; //fix/11a
                        }
                        else {
                            [self.otherWines addObject:wine]; //fix/11a
                        }
                    }
                    
                    
                }
            }else{
                // Se ha producido un error al parsear el JSON
                NSLog(@"Error al parsear JSON: %@", error.localizedDescription);
            }
        }else{
            // Error al descargar los datos del servidor
            NSLog(@"Error al descargar datos del servidor: %@", error.localizedDescription);
        }
    }
    return self;
}




#pragma mark - Other
   
    
-(RBRWineModel *) redWineAtIndex: (NSUInteger)index{
    
            return [self.redWines objectAtIndex:index];
}
    

-(RBRWineModel *) whiteWineAtIndex: (NSUInteger) index{
     return [self.whiteWines objectAtIndex:index];
}

-(RBRWineModel *) otherWineAtIndex: (NSUInteger) index{
     return [self.otherWines objectAtIndex:index];
}


-(NSData *) dataJSONWineSave{
    
    //Obtener el JSON de un ficehro, si no existe este fichero lo creamos obteniendo los datos de la URL
    
    
    NSFileManager *fm= [NSFileManager defaultManager];
    NSData *data = nil;
    
    NSError *error=  nil;
    BOOL rc= NO;
    
    //Como deuelve un ARRAy obtener su ultimo
    NSURL *urlRuta= [[fm URLsForDirectory:NSCachesDirectory
                                inDomains:NSUserDomainMask] lastObject];
    
    //devuelve una URL incluyendo el fichero en concreto
    urlRuta= [urlRuta URLByAppendingPathComponent:FILENAME_JSON];
    
    
    //Leer para aegurarmos que ha salido bien
    data= [ NSData dataWithContentsOfURL:urlRuta options:NSDataReadingMapped error:&error];
    
    if (data==nil){
        
        //Ha habido error
        NSLog(@"Error al leer el JSON %@",error);
        
       //No existe el fichero, crearlo y guardar los datos
        
       NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://baccusapp.herokuapp.com/wines"]];
       NSURLResponse *response = [[NSURLResponse alloc] init];

    
       data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
        
        if (data==nil) {
            NSLog(@"Error al obtener el JSON de URL %@",error);
        }else{
            rc=[data writeToURL:urlRuta options:NSDataWritingAtomic error:&error];
            
            //Lo que determina si ha habido un error es simper el valor de retorno
            if (rc==NO){
                //Ha habido error
                NSLog(@"Error al guardar el JSON %@",error);
            }
        }
        
    }

    return data;
    
    
}


@end

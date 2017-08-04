//
//  RBRWineModel.m
//  Baccus
//
//  Created by Ruben Berreguero on 29/08/13.
//  Copyright (c) 2013 Ruben Berreguero. All rights reserved.
//

#import "RBRWineModel.h"



@implementation RBRWineModel

// Cuando creas una propiedad de solo lectura e implementas un getter personalizado,
// como estamos haciendo con photo, el compilador da por hecho que no vas a necesitar
// una variable de instancia. En este caso no es así, y sí que neceisto la variable,
// así que hay que obligarle a que la incluya. Esto se hace con la linea de @synthesize,
// con la que le indicamos que queremos una propiedad llamada photo con una variable
// de instancia llamada _photo.
// En la inmensa mayoría de los casos, esto es opcional.
// Para más info: http://www.cocoaosx.com/2012/12/04/auto-synthesize-property-reglas-excepciones/

@synthesize photo= _photo;


#pragma mark - Propiedades

-(UIImage *) photo{
    
    // Esto va a bloquear y se debería de hacer en segundo plano
    // Sin embargo, aun no sabemos hacer eso, asi que de momento lo dejamos
    
    // Carga perezosa: solo cargo la imagen si hace falta.
    if (_photo == nil) {
        
        
        //Obetenr la imagen y la guardamos en cache, aai no la tenemso que descargar¡¡¡
        
        //_photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.photoURL]];
        
        _photo= [self imageFromURLSave:self.photoURL];
        
        
    }
    return _photo;
}



#pragma mark - Class methods

+(id) wineWithName: (NSString *) aName
    winCompanyName:(NSString *) aWineCompanyName
              type: (NSString *) aType
             orgin:(NSString *) aOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aURL
            notes : (NSString *) aNotes
            rating:(int) aRating
             photoURL:(NSURL *) aPhotoURL{
    
    return [[self alloc] initWithName:aName
                       wineCompanyName:aWineCompanyName
                                 type:aType
                                orgin:aOrigin
                               grapes:arrayOfGrapes
                       wineCompanyWeb:aURL
                                notes:aNotes
                               rating:aRating
                                photoURL:aPhotoURL];
    
    
}

+(id) wineWithName:(NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type:(NSString *) aType
            origin: (NSString *) aOrigin{
 
    return [[self alloc]  initWithName:aName
                       wineCompanyName:aWineCompanyName
                                  type:aType
                                origin:aOrigin ];
}



#pragma mark - Init

-(id) initWithName: (NSString *) aName
    wineCompanyName:(NSString *) aWineCompanyName
              type: (NSString *) aType
             orgin:(NSString *) aOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aURL
            notes : (NSString *) aNotes
            rating:(int) aRating
             photoURL:(NSURL *) aPhotoURL{
    
    if (self=[super init]){
        //Asignamos los parametros a las variables de instancia
      //Se recomienda no usar setter
        _name= aName;
        _wineCompanyName= aWineCompanyName;
        _type= aType;
        _origin= aOrigin;
        _grapes= arrayOfGrapes;
        _wineCompanyWeb= aURL;
        _notes= aNotes;
        _rating= aRating;
        _photoURL=aPhotoURL;
        
    }
    
    return self;

}


-(id) initWithName:(NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type:(NSString *) aType
            origin: (NSString *) aOrigin{
    
    return [self initWithName:aName
               wineCompanyName:aWineCompanyName
                         type:aType orgin:aOrigin
                       grapes:nil
               wineCompanyWeb:nil
                        notes:nil
                       rating:NO_RATING
                        photoURL:nil ];
    
}

#pragma mark - JSON

//Inicialiador a partir de dicccionario JSON
-(id) initWithDictionary: (NSDictionary *) aDict{
    
    
    
    return [self initWithName:[aDict objectForKey:@"name"]
               wineCompanyName:[aDict objectForKey:@"company"]
                         type:[aDict objectForKey:@"type"]
                        orgin:[aDict objectForKey:@"origin"]
                       grapes:[self extractGrapesFromJSONArray:[aDict objectForKey:@"grapes"]]
               wineCompanyWeb:[NSURL URLWithString:[aDict objectForKey:@"wine_web"]]
                        notes:[aDict objectForKey:@"notes"]
                       rating:[[aDict objectForKey:@"rating"] intValue]
                     photoURL:[NSURL URLWithString:[aDict objectForKey:@"picture"]]];
    
    
}


//Pasar de disccionario a JSON (no lo utilizamos)
-(NSDictionary *)proxyForJSON{
    
    return @{@"name"            : self.name,
             @"company" : self.wineCompanyName,
             @"wine_web"        : [self.wineCompanyWeb path], //fix/11a
             @"type"            : self.type,
             @"origin"          : self.origin,
             @"grapes"          : self.grapes,
             @"notes"           : self.notes,
             @"rating"          : @(self.rating),
             @"picture"        : [self.photoURL path]};
}


#pragma mark - Utils

-(NSArray*)extractGrapesFromJSONArray: (NSArray*)JSONArray{
    
    NSMutableArray *grapes = [NSMutableArray arrayWithCapacity:[JSONArray count]];
    
    for (NSDictionary *dict in JSONArray) {
        [grapes addObject:[dict objectForKey:@"grape"]];
    }
    
    return grapes;
}



-(NSArray *)packGrapesIntoJSONArray{
    
    NSMutableArray *jsonArray = [NSMutableArray arrayWithCapacity:[self.grapes count]];
    
    for (NSString *grape in self.grapes) {
        
        [jsonArray addObject:@{@"grape": grape}];
    }
    
    return jsonArray;
    
}

-(UIImage *) imageFromURLSave: (NSURL *)aURL{
    
    UIImage *image=nil;
    NSString *fileNameImage;
    NSFileManager *fm= [NSFileManager defaultManager];
    NSData *data = nil;
    BOOL rc=NO;
    NSError *error=  nil;
    
    
    if (aURL==nil){
        
        
    }else{
            //Obtenemos el nombre del fichero de la imagen
    fileNameImage=[aURL lastPathComponent];
    
    //Como deuelve un ARRAy obtener su ultimo
    NSURL *urlRuta= [[fm URLsForDirectory:NSCachesDirectory
                                inDomains:NSUserDomainMask] lastObject];
    
    //devuelve una URL incluyendo el fichero en concreto
    urlRuta= [urlRuta URLByAppendingPathComponent:fileNameImage];
    
    
    //Leer el archivo de la cahe con la imagen
    data= [ NSData dataWithContentsOfURL:urlRuta options:NSDataReadingMapped error:&error];

    //Si no hay nada, obtnemos los dtos y los guardamos
    if (data==nil) {
        //Error al leer la imagen
        NSLog(@"Error al leer la imagen de URL %@ es: %@",fileNameImage, error);
        
        data=[NSData dataWithContentsOfURL:aURL];
        rc=[data writeToURL:urlRuta options:NSDataWritingAtomic error:&error];
        
        if (rc==NO){
            //Error al grabr la imagen
            NSLog(@"Error al grabar la imagen %@ es: %@",fileNameImage, error);
        }
    }
    
    
   image= [UIImage imageWithData:data];
    }
    

    
    
    return image;
}

@end

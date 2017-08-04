//
//  RBRWineryTableViewController.m
//  Baccus
//
//  Created by Ruben Berreguero on 06/09/13.
//  Copyright (c) 2013 Ruben Berreguero. All rights reserved.
//

#import "RBRWineryTableViewController.h"
#import "RBRWineViewController.h"

@interface RBRWineryTableViewController ()

//Permite declar propiedades y metodos mas o menos ocultos

@end

@implementation RBRWineryTableViewController

-(id)initWithModel: (RBRWineryModel *) aModel
             style:(UITableViewStyle) aStyle{
    
    //initWithStyle es el iniciliciador por dfecto de las UItableViewController   
    if (self = [super initWithStyle:aStyle]){
        _model= aModel;
        
        //asignamos el titulo, para que se muestre como titulo en el Navigation Controller
        self.title=@"Baccus";
        
         [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBariPhonePortrait.png"] forBarMetrics:UIBarMetricsDefault];
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Cuando aparezca en pantalla cambiamos el color de la barra del naviation Controller
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    //Cambianos e color del navigation controller
    self.navigationController.navigationBar.tintColor= [UIColor colorWithRed:0.5
                                                                       green:0
                                                                        blue:0.13
                                                                       alpha:1];
}

#pragma mark - Table view data source

//Buscamos este metodo, a mano, del delegado de
-(NSString *)tableView:(UITableView *)tableView
    titleForHeaderInSection:(NSInteger)section{
    //Pregunta por el titulo de cada seccion del tablaView, si no llamos a este no se muestra nada y aparente estar en una sola seccion
    if (section == RED_WINE_SECTION){
        return @"Tinto";
    }else if(section == WHITE_WINE_SECTION){
        return @"Blanco";
    }else{
        return @"Otros";
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3; //3 ttipos de vinos
}

- (NSInteger)tableView:(UITableView *)tableView
                        numberOfRowsInSection:(NSInteger)section
{
    //Numero de filas en la seccion X
    //Consultamos cada seccion por la constante y devolvemos la propiedad del modelo
    if (section == RED_WINE_SECTION){
        return self.model.redWineCount;
    }else if(section == WHITE_WINE_SECTION){
           return self.model.whiteWineCount;
    }else{
        return self.model.otherWineCount;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    //Esto es cuando son celdas personalizadas, por ahora usamos esto:
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //tenemos una celda, si no tiene ninguna devuelve nil
    
    if (cell==nil){
        //Tenemos que crearla a mano con
        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                    reuseIdentifier:CellIdentifier];
        
        // aplicamos diseño
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];

    }
    
    
    // Configure the cell...


   //Aviruguar de que modelo de vino nos esta hablando
    
    RBRWineModel *wine= [self wineForIndexPath:indexPath];

    
    //Sincornizar celda (vista) y modelo (vino)
    if (wine.photo){
        
         cell.imageView.image= wine.photo;

    }else{
         cell.imageView.image = [UIImage imageNamed:@"cell_icon_bg.png"];
    }
    cell.textLabel.text= wine.name;
    cell.detailTextLabel.text= wine.wineCompanyName;
    
    
    //Devolvemos la celda
    return cell;


}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Suponemos que estamo dentro de un NavigationController
    //Averiguanos d que vino se trata
    RBRWineModel *wine=nil;
    
    
    wine= [self wineForIndexPath: indexPath];

    
    if (IS_IPHONE){
        
   
        [self.delegate wineryTableViewController:self
                                 didSelectedWine:wine];
        
        
    }else{
        
        //Si estamo en IÂD notificaremos el camvio a los dos viewController sque podemos tener cargados en memoria
    //Hacer un mensaje a nuestro delegado para que la clase que sea delegada sepa que ha pasado este evento
    [self.delegate wineryTableViewController:self
                             didSelectedWine:wine];
    
    
    //Crear notificacion para que el webViewCOntroller se entere, ponermos constantes para el nombre de objeto y nombre de diccionario
    //Hay que dar de alta y de baja a la notifiacion las clases que quieren recibir esto
    
    NSNotification *n=[NSNotification notificationWithName:NEW_WINE_NOTIFICATION_NAME
                                                    object:self
                                                  userInfo:@{WINE_KEY:wine}]; //De est fofrma creamos un diccionario
    
    //enviarla
    [[NSNotificationCenter defaultCenter]postNotification:n];
    
    
    //Guardar el ultimo vino seleccionado el NSSuerDefaults
    [self saveLastSelectedWineAtSection:indexPath.section
                                    row:indexPath.row];
    
    }
    

    
    /*
     //Creamos un controlador para dcho vino
     
     RBRWineViewController *wineVC= [[RBRWineViewController alloc]initWithModel:wine];
     
    //Hacemo un pusch al navigtion contolle dentro del cual estamos
        [self.navigationController pushViewController:wineVC
                                         animated:YES];
    */
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    

    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // devolvemos el tamaño al mismo que el background que hemos puesto
    return 72;
}

#pragma mark - NSUserDefaults


-(RBRWineModel *)lastSelectWine
{
    
    NSIndexPath *indexPath= nil;
    NSDictionary *coords= nil;
    
    coords= [[NSUserDefaults standardUserDefaults]objectForKey:LAST_WINE_KEY];
    
    if (coords==nil) {
        //No habuia nigun untimo vino
        //Esto quiere decri que es la primera cvez que se llama a la app
        //Ponemos un valor por defecto; el primero de los tintos
        
       coords=[self setDefaults];
    }else{
        //Ya hay algo, es decir, el algun momento se guardo
        //No hay nada especial que hacer
    }
    
    //Transformamos esas coordenas en un indexpath
    indexPath= [NSIndexPath indexPathForRow:[[coords objectForKey:ROW_KEY]integerValue ]
                                  inSection:[[coords objectForKey:SECTION_KEY]integerValue ] ];
    
    //Devolvemos el vino en cuestion
    return [self wineForIndexPath:indexPath];
    
}



-(NSDictionary *) setDefaults{

    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    
    //Por defecto, mostramos el primero de los tintos
    
    NSDictionary *defaultWineCoords=@{SECTION_KEY: @(RED_WINE_SECTION), ROW_KEY: @0};
    
    //Lo asignamos
    [defaults setObject:defaultWineCoords
                 forKey:LAST_WINE_KEY];
    
    //Guarda,os por si las moscas
    [defaults synchronize];
    
    return defaultWineCoords;
    
}

-(void) saveLastSelectedWineAtSection:(NSUInteger) section
                                  row: (NSUInteger) row{
    
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@{SECTION_KEY: @(section),
                ROW_KEY: @(row)} forKey:LAST_WINE_KEY];
    
    [defaults synchronize]; //Por si acaso guardamos
}

#pragma mark - WineryTableViewControllerDelegate

-(void) wineryTableViewController: (RBRWineryTableViewController *) wineryVC
                  didSelectedWine: (RBRWineModel *) aWine{
    
    //Crear el controlador
    RBRWineViewController *wineVC= [[RBRWineViewController alloc]initWithModel:aWine];
    //Hacer un pusch
    [self.navigationController pushViewController:wineVC
                                         animated:YES];
}

#pragma mark - Utils

-(RBRWineModel *)wineForIndexPath: (NSIndexPath *) indexPath{
    //Averiguanos d que vino se trata
    RBRWineModel *wine=nil;
    
  
     if (indexPath.section==RED_WINE_SECTION){
     wine= [self.model redWineAtIndex:indexPath.row];
     }else if(indexPath.section==WHITE_WINE_SECTION){
     wine= [self.model whiteWineAtIndex:indexPath.row];
     }else{
     wine= [self.model otherWineAtIndex:indexPath.row];
     }
     
    return wine;
    
}



@end

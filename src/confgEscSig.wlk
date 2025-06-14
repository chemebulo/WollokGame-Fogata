import escenarios.*
import confgEscenarios.*
import videojuego.*
import puertas.*
/*
 CONFIGURADOR DE ESCENARIOS SIGUIENTE: 
    *tipo: bloque
    En el bloque se debe escribir
    el setter del irHacia de TODAS LAS PUERTAS delescenario
    si se vuelve a un escenario anterior...se deben settear tanto el confgEscSiguiente como el confgActual
    si un escenario tiene dinstintos configuradores, respetar nomenclatura y escribir al final v1,v2,v3 

  NOTAS: Los escenarios exclusivos para diapositivas no requieren un configurador de escenario siguiente
*/

const confg_escSig_escenarioInicial_v1       = {puertaNorte.irHacia(escenarioBifurcacion)}

const confg_escSig_escenarioBifurcacion_v1   = {puertaEste.irHacia(escenarioEntradaCabaña)}

const confg_escSig_escenarioBifurcacion_v2   = {puertaOeste.irHacia(escenarioEntradaCueva)}

const confg_escSig_escenarioEntradaCabaña_v1 = {puertaEntradaCabaña.irHacia(escenarioCabañaInicial)}

const confg_escSig_escenarioEntradaCabaña_v2 = {game.removeVisual(puertaEntradaCabaña); 
                                                puertaOeste.irHacia(escenarioBifurcacion);
                                                escenarioBifurcacion.configuradorTotal(confg_escenarioBifurcacion_v2,confg_escSig_escenarioBifurcacion_v2)
                                                }
                                                
const confg_escSig_escenarioCabañaInicial_v1    = {puertaOeste.irHacia(escenarioEntradaCabaña);
                                                    escenarioEntradaCabaña.configuradorTotal(confg_escenarioEntradaCabaña_v2,confg_escSig_escenarioEntradaCabaña_v2)}
                                               
const confg_escSig_escenarioEntradaCueva_v1 = {puertaEntradaCueva.irHacia(escenarioCueva)}       

const confg_esSig_cueva_v1 = {puertaEntradaCueva.irHacia(escenarioCueva);
                              escenarioCueva.configuradorTotal(confg_escenarioCueva_v2,confg_escSig_escenarioCueva_v2)}
                          
const confg_escSig_escenarioCueva_v2 = {puertaEntradaCueva.irHacia(escenarioCueva);
                                       escenarioCueva.configuradorTotal(confg_escenarioCueva_v3,confg_escSig_escenarioCueva_v3)}
                                                  

const confg_escSig_escenarioCueva_v3 = {puertaEntradaCueva.irHacia(escenarioCueva);
                                      escenarioCueva.configuradorTotal(confg_escenarioCueva_v4, confg_escSig_escenarioCueva_v4)}
                            

const confg_escSig_escenarioCueva_v4 = {puertaEntradaCueva.irHacia(escenarioEntradaCueva);
                                      escenarioEntradaCueva.configuradorTotal(confg_escenarioEntradaCueva_v2, confg_escSig_escenarioEntradaCueva_v2)  }
                                          

const confg_escSig_escenarioEntradaCueva_v2 = {puertaEste.irHacia(escenarioBifurcacion);
                                                  escenarioBifurcacion.configuradorTotal(confg_escenarioBifurcacion_v3,confg_escSig_escenarioBifurcacion_v3)}
                                            

const confg_escSig_escenarioBifurcacion_v3 = {puertaSur.irHacia(escenarioAmigaMuerta)}

const confg_escSig_escenarioBifurcacion_v4 = {puertaEste.irHacia(escenarioEntradaCabaña);
                                              escenarioEntradaCabaña.configuradorTotal(confg_escenarioEntradaCabaña_v3,confg_escSig_escenarioEntradaCabaña_v3)}
                                         

const confg_escSig_escenarioEntradaCabaña_v3 = {puertaEntradaCabaña.irHacia(escenarioCabañaInicial);
                                                escenarioCabañaInicial.configuradorTotal(confg_escenarioCabañaInicial_v2,confg_escSig_escenarioCabañaInicial_v2)}
                                           


const confg_escSig_escenarioCabañaInicial_v2 = {puertaEntradaCabaña.irHacia(escenarioEntradaCabaña);
                                                escenarioEntradaCabaña.configuradorTotal(confg_escenarioEntradaCabaña_v4,confg_escSig_escenarioEntradaCabaña_v4)}
                                             
//estoy aqui//modificar esta parte con los setters nuevos 
const confg_escSig_escenarioEntradaCabaña_v4 ={
                                               puertaNorte.irHacia(escenarioEntradaGranero)}

// configuradores granero
const confg_esSig_escenarioEntradaGranero_v1 = {puertaGranero.irHacia(escenarioDiapoGranero)}

const confg_esSig_escenarioGranero_v1 = {puertaGranero.irHacia(escenarioEntradaGranero);
                                          escenarioEntradaGranero.configuradorTotal(confg_escenarioEntradaGranero_v2,confg_esSig_escenarioEntradaGranero_v2)}
                                        

const confg_esSig_escenarioEntradaGranero_v2 = {puertaSur.irHacia(escenarioEntradaCabaña);
                                                  escenarioEntradaCabaña.configuradorTotal(confg_escenarioEntradaCabaña_v5,confg_esSig_escenarioEntradaCabaña_v5)}
                                                        
const confg_esSig_escenarioEntradaCabaña_v5 = {puertaEntradaCabaña.irHacia(escenarioCabañaInicial);
                                                escenarioCabañaInicial.configuradorTotal(confg_escenarioCabañaInicial_v3,confg_escSig_escenarioCabañaInicial_v3)}
                                                      
const confg_escSig_escenarioCabañaInicial_v3 = {puertaEntradaCabaña.irHacia(escenarioEntradaCabaña);
                                                escenarioEntradaCabaña.configuradorTotal(confg_escenarioEntradaCabaña_v6,confg_esSig_escenarioEntradaCabaña_v6)}
                                           

const confg_esSig_escenarioEntradaCabaña_v6 = {puertaOeste.irHacia(escenarioBifurcacion)
                                                escenarioBifurcacion.configuradorTotal(confg_escenarioBifurcacion_v5,confg_escSig_escenarioBifurcacion_v5)}
                                               
//aqui voy luego
const confg_escSig_escenarioBifurcacion_v5 = {puertaOeste.irHacia(escenarioEntradaCueva);
                                              escenarioEntradaCueva.configuradorTotal(confg_escenarioEntradaCueva_v3,confg_escSig_escenarioEntradaCueva_v3)}
                                            

const confg_escSig_escenarioEntradaCueva_v3 = {puertaEntradaCueva.irHacia(escenarioCueva);
                                                escenarioCueva.configuradorTotal(confg_escenarioCueva_v1,confg_escSig_escenarioCueva_v6)}
                                               

const confg_escSig_escenarioCueva_v6 ={puertaEntradaCueva.irHacia(escenarioCueva);
                                          escenarioCueva.configuradorTotal(confg_escenarioCueva_v2,confg_escSig_escenarioCueva_v7)}
                                     

const confg_escSig_escenarioCueva_v7 = {puertaEntradaCueva.irHacia(escenarioCueva);
                                          escenarioCueva.configuradorTotal(confg_escenarioCueva_v3,confg_escSig_escenarioCueva_v8)}                                     

const confg_escSig_escenarioCueva_v8 ={puertaEntradaCueva.irHacia(escenarioCueva);
                                          escenarioCueva.configuradorTotal(confg_escenarioCueva_v4,confg_escSig_escenarioCueva_v9)}
                                                                       
const confg_escSig_escenarioCueva_v9 ={    puertaEntradaCueva.irHacia(escenarioDiapoPeleaFinal)}

const confg_esSig_escenarioPeleaFinal = {puertaEntradaCueva.irHacia(escenarioEntradaCueva);
                                          escenarioEntradaCueva.configuradorTotal({},{})}                                      
                                          //borrar la puertaEntradaCueva cuando se pase al escenario en los configuradores                                        
//CONTINUAR AQUI....                                           
// TEXTOS
const confg_escSig_TEST = {game.removeVisual(puertaSur)}
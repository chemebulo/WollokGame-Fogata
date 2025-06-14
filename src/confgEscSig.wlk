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

const confg_escSig_escenarioInicial_v1       = {puertaNorte.irHacia(bifurcacion)}

const confg_escSig_escenarioBifurcacion_v1   = {puertaEste.irHacia(entradaCabaña)}

const confg_escSig_escenarioBifurcacion_v2   = {puertaOeste.irHacia(entradaCueva)}

const confg_escSig_escenarioEntradaCabaña_v1 = {puertaEntradaCabaña.irHacia(cabaña)}

const confg_escSig_escenarioEntradaCabaña_v2 = {game.removeVisual(puertaEntradaCabaña); 
                                                puertaOeste.irHacia(bifurcacion);
                                                bifurcacion.configuradorTotal(confg_escenarioBifurcacion_v2,confg_escSig_escenarioBifurcacion_v2)
                                                }
                                                
const confg_escSig_escenarioCabañaInicial_v1    = {puertaOeste.irHacia(entradaCabaña);
                                                    entradaCabaña.configuradorTotal(confg_escenarioEntradaCabaña_v2,confg_escSig_escenarioEntradaCabaña_v2)}
                                               
const confg_escSig_escenarioEntradaCueva_v1 = {puertaEntradaCueva.irHacia(cueva)}       

const confg_esSig_cueva_v1 = {puertaEntradaCueva.irHacia(cueva);
                              cueva.configuradorTotal(confg_escenarioCueva_v2,confg_escSig_escenarioCueva_v2)}
                          
const confg_escSig_escenarioCueva_v2 = {puertaEntradaCueva.irHacia(cueva);
                                       cueva.configuradorTotal(confg_escenarioCueva_v3,confg_escSig_escenarioCueva_v3)}
                                                  

const confg_escSig_escenarioCueva_v3 = {puertaEntradaCueva.irHacia(cueva);
                                      cueva.configuradorTotal(confg_escenarioCueva_v4, confg_escSig_escenarioCueva_v4)}
                            

const confg_escSig_escenarioCueva_v4 = {puertaEntradaCueva.irHacia(entradaCueva);
                                      entradaCueva.configuradorTotal(confg_escenarioEntradaCueva_v2, confg_escSig_escenarioEntradaCueva_v2)  }
                                          

const confg_escSig_escenarioEntradaCueva_v2 = {puertaEste.irHacia(bifurcacion);
                                                  bifurcacion.configuradorTotal(confg_escenarioBifurcacion_v3,confg_escSig_escenarioBifurcacion_v3)}
                                            

const confg_escSig_escenarioBifurcacion_v3 = {puertaSur.irHacia(diapoAmigaMuerta)}

const confg_escSig_escenarioBifurcacion_v4 = {puertaEste.irHacia(entradaCabaña);
                                              entradaCabaña.configuradorTotal(confg_escenarioEntradaCabaña_v3,confg_escSig_escenarioEntradaCabaña_v3)}
                                         

const confg_escSig_escenarioEntradaCabaña_v3 = {puertaEntradaCabaña.irHacia(cabaña);
                                                cabaña.configuradorTotal(confg_escenarioCabañaInicial_v2,confg_escSig_escenarioCabañaInicial_v2)}
                                           


const confg_escSig_escenarioCabañaInicial_v2 = {puertaEntradaCabaña.irHacia(entradaCabaña);
                                                entradaCabaña.configuradorTotal(confg_escenarioEntradaCabaña_v4,confg_escSig_escenarioEntradaCabaña_v4)}
                                             
//estoy aqui//modificar esta parte con los setters nuevos 
const confg_escSig_escenarioEntradaCabaña_v4 ={
                                               puertaNorte.irHacia(entradaGranero)}

// configuradores granero
const confg_esSig_escenarioEntradaGranero_v1 = {puertaGranero.irHacia(diapoGranero)}

const confg_esSig_escenarioGranero_v1 = {puertaGranero.irHacia(entradaGranero);
                                          entradaGranero.configuradorTotal(confg_escenarioEntradaGranero_v2,confg_esSig_escenarioEntradaGranero_v2)}
                                        

const confg_esSig_escenarioEntradaGranero_v2 = {puertaSur.irHacia(entradaCabaña);
                                                  entradaCabaña.configuradorTotal(confg_escenarioEntradaCabaña_v5,confg_esSig_escenarioEntradaCabaña_v5)}
                                                        
const confg_esSig_escenarioEntradaCabaña_v5 = {puertaEntradaCabaña.irHacia(cabaña);
                                                cabaña.configuradorTotal(confg_escenarioCabañaInicial_v3,confg_escSig_escenarioCabañaInicial_v3)}
                                                      
const confg_escSig_escenarioCabañaInicial_v3 = {puertaEntradaCabaña.irHacia(entradaCabaña);
                                                entradaCabaña.configuradorTotal(confg_escenarioEntradaCabaña_v6,confg_esSig_escenarioEntradaCabaña_v6)}
                                           

const confg_esSig_escenarioEntradaCabaña_v6 = {puertaOeste.irHacia(bifurcacion)
                                                bifurcacion.configuradorTotal(confg_escenarioBifurcacion_v5,confg_escSig_escenarioBifurcacion_v5)}
                                               
//aqui voy luego
const confg_escSig_escenarioBifurcacion_v5 = {puertaOeste.irHacia(entradaCueva);
                                              entradaCueva.configuradorTotal(confg_escenarioEntradaCueva_v3,confg_escSig_escenarioEntradaCueva_v3)}
                                            

const confg_escSig_escenarioEntradaCueva_v3 = {puertaEntradaCueva.irHacia(cueva);
                                                cueva.configuradorTotal(confg_escenarioCueva_v1,confg_escSig_escenarioCueva_v6)}
                                               

const confg_escSig_escenarioCueva_v6 ={puertaEntradaCueva.irHacia(cueva);
                                          cueva.configuradorTotal(confg_escenarioCueva_v2,confg_escSig_escenarioCueva_v7)}
                                     

const confg_escSig_escenarioCueva_v7 = {puertaEntradaCueva.irHacia(cueva);
                                          cueva.configuradorTotal(confg_escenarioCueva_v3,confg_escSig_escenarioCueva_v8)}                                     

const confg_escSig_escenarioCueva_v8 ={puertaEntradaCueva.irHacia(cueva);
                                          cueva.configuradorTotal(confg_escenarioCueva_v4,confg_escSig_escenarioCueva_v9)}
                                                                       
const confg_escSig_escenarioCueva_v9 ={    puertaEntradaCueva.irHacia(diapoPeleaFinal)}

const confg_esSig_escenarioPeleaFinal = {puertaEntradaCueva.irHacia(entradaCueva);
                                          entradaCueva.configuradorTotal({},{})}                                      
                                          //borrar la puertaEntradaCueva cuando se pase al escenario en los configuradores                                        
//CONTINUAR AQUI....                                           
// TEXTOS
const confg_escSig_TEST = {game.removeVisual(puertaSur)}
import escenarios.*
import confgEscenarios.*
import puertas.*

/*
 CONFIGURADOR DE ESCENARIOS SIGUIENTE: 
    *tipo: bloque
    En el bloque se debe escribir
    el setter del irHacia de TODAS LAS PUERTAS delescenario
    si se vuelve a un escenario anterior...se deben settear tanto el confgEscSiguiente como el confgActual
    si un escenario tiene dinstintos configuradores, respetar nomenclatura y escribir al final v1,v2,v3 

  NOTAS: Los escenarios exclusivos para diapositivas no requieren un configurador de escenario siguiente

  nomenclatura = escenarioCES_v*
*/

const fogataCES_v1 = {puertaNorte.irHacia(bifurcacion)}

const bifurcacionCES_v1 = {puertaEste.irHacia(entradaCabaña)}

const bifurcacionCES_v2 = {puertaOeste.irHacia(entradaCueva)}

const entradaCabañaCES_v1 = {puertaEntradaCabaña.irHacia(cabaña)}

const entradaCabañaCES_v2 = {game.removeVisual(puertaEntradaCabaña); 
                             puertaOeste.irHacia(bifurcacion);
                             bifurcacion.configuradorTotal(bifurcacionC_v2, bifurcacionCES_v2)}
                                                
const cabañaCES_v1 = {puertaOeste.irHacia(entradaCabaña);
                      entradaCabaña.configuradorTotal(entradaCabañaC_v2, entradaCabañaCES_v2)}
                                               
const entradaCuevaCES_v1 = {puertaEntradaCueva.irHacia(cueva)}       

const cuevaCES_v1 = {puertaEntradaCueva.irHacia(cueva);
                     cueva.configuradorTotal(cuevaC_v2, cuevaCES_v2)}
                          
const cuevaCES_v2 = {puertaEntradaCueva.irHacia(cueva);
                     cueva.configuradorTotal(cuevaC_v3, cuevaCES_v3)}

const cuevaCES_v3 = {puertaEntradaCueva.irHacia(cueva);
                     cueva.configuradorTotal(cuevaC_v4, cuevaCES_v4)}

const cuevaCES_v4 = {puertaEntradaCueva.irHacia(entradaCueva);
                     entradaCueva.configuradorTotal(entradaCuevaC_v2, entradaCuevaCES_v2)  }

const entradaCuevaCES_v2 = {puertaEste.irHacia(bifurcacion);
                           bifurcacion.configuradorTotal(bifurcacionC_v3, bifurcacionCES_v3)}

const bifurcacionCES_v3 = {puertaSur.irHacia(diapoAmigaMuerta)}

const bifurcacionCES_v4 = {puertaEste.irHacia(entradaCabaña);
                           entradaCabaña.configuradorTotal(entradaCabañaC_v3, entradaCabañaCES_v3)}
                                         
const entradaCabañaCES_v3 = {puertaEntradaCabaña.irHacia(cabaña);
                             cabaña.configuradorTotal(cabañaC_v2, cabañaCES_v2)}

const cabañaCES_v2 = {puertaEntradaCabaña.irHacia(entradaCabaña);
                      entradaCabaña.configuradorTotal(entradaCabañaC_v4, entradaCabañaCES_v4)}
                                             
// Modificar esta parte con los setters nuevos 
const entradaCabañaCES_v4 = {puertaNorte.irHacia(entradaGranero)}

// Configuradores granero
const entradaGraneroCES_v1 = {puertaGranero.irHacia(diapoGranero)}

const graneroCES_v1 = {puertaGranero.irHacia(entradaGranero);
                       entradaGranero.configuradorTotal(entradaGraneroC_v2, entradaGraneroCES_v2)}
                                        
const entradaGraneroCES_v2 = {puertaSur.irHacia(entradaCabaña);
                              entradaCabaña.configuradorTotal(entradaCabañaC_v5, entradaCabañaCES_v5)}
                                                        
const entradaCabañaCES_v5 = {puertaEntradaCabaña.irHacia(cabaña);
                             cabaña.configuradorTotal(cabañaC_v3, cabañaCES_v3)}
                                                      
const cabañaCES_v3 = {puertaEntradaCabaña.irHacia(entradaCabaña);
                      entradaCabaña.configuradorTotal(entradaCabañaC_v6, entradaCabañaCES_v6)}
                                           
const entradaCabañaCES_v6 = {puertaOeste.irHacia(bifurcacion)
                             bifurcacion.configuradorTotal(bifurcacionC_v5, bifurcacionCES_v5)}
                                               
const bifurcacionCES_v5 = {puertaOeste.irHacia(entradaCueva);
                           entradaCueva.configuradorTotal(entradaCuevaC_v3, entradaCuevaCES_v3)}

const entradaCuevaCES_v3 = {puertaEntradaCueva.irHacia(cueva);
                            cueva.configuradorTotal(cuevaC_v1, cuevaCES_v6)}

const cuevaCES_v6 = {puertaEntradaCueva.irHacia(cueva);
                     cueva.configuradorTotal(cuevaC_v2, cuevaCES_v7)}

const cuevaCES_v7 = {puertaEntradaCueva.irHacia(cueva);
                     cueva.configuradorTotal(cuevaC_v3, cuevaCES_v8)}                                     

const cuevaCES_v8 = {puertaEntradaCueva.irHacia(cueva);
                     cueva.configuradorTotal(cuevaC_v5, cuevaCES_v9)}
                                                                       
const cuevaCES_v9 = {puertaEntradaCueva.irHacia(diapoPeleaFinal)}

const peleaFinalCES_v1 = {puertaEntradaCueva.irHacia(entradaCueva);
                          entradaCueva.configuradorTotal(entradaCueva_v4, entradaCuevaCES_v4)}         

const entradaCuevaCES_v4 = {puertaEste.irHacia(bifurcacion);
                            bifurcacion.configuradorTotal(bifurcacionC_v6, bifurcacionCES_v6)}         

const bifurcacionCES_v6 = {puertaNorte.irHacia(estacionamiento)}       

// Borrar la puertaEntradaCueva cuando se pase al escenario en los configuradores                                        
// CONTINUAR AQUI....                                           
// TEXTOS
const escenarioTestCES_v1 = {game.removeVisual(puertaSur)}
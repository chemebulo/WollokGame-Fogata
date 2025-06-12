import escenarios.*
import confgEscenarios.*

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
                                                escenarioBifurcacion.confgEscSiguiente(confg_escSig_escenarioBifurcacion_v2);
                                                escenarioBifurcacion.confgActual(confg_escenarioBifurcacion_v2)}

const confg_escSig_escenarioCabañaInicial_v1    = {puertaOeste.irHacia(escenarioEntradaCabaña);
                                                escenarioEntradaCabaña.confgEscSiguiente(confg_escSig_escenarioEntradaCabaña_v2);
                                                escenarioEntradaCabaña.confgActual(confg_escenarioEntradaCabaña_v2)}

const confg_escSig_escenarioEntradaCueva_v1 = {puertaEntradaCueva.irHacia(escenarioCueva)}       

const confg_esSig_cueva_v1 = {puertaEntradaCueva.irHacia(escenarioCueva);
                              escenarioCueva.confgActual(confg_escenarioCueva_v2)
                              escenarioCueva.confgEscSiguiente(confg_escSig_escenarioCueva_v2)}

const confg_escSig_escenarioCueva_v2 = {puertaEntradaCueva.irHacia(escenarioCueva);
                              escenarioCueva.confgActual(confg_escenarioCueva_v3)
                              escenarioCueva.confgEscSiguiente(confg_escSig_escenarioCueva_v3)}                              

const confg_escSig_escenarioCueva_v3 = {puertaEntradaCueva.irHacia(escenarioCueva);
                              escenarioCueva.confgActual(confg_escenarioCueva_v4)
                              escenarioCueva.confgEscSiguiente(confg_escSig_escenarioCueva_v4)}  

const confg_escSig_escenarioCueva_v4 = {puertaEntradaCueva.irHacia(escenarioEntradaCueva);
                                          escenarioEntradaCueva.confgActual(confg_escenarioEntradaCueva_v2);
                                          escenarioEntradaCueva.confgEscSiguiente(confg_escSig_escenarioEntradaCueva_v2)}     

const confg_escSig_escenarioEntradaCueva_v2 = {puertaEste.irHacia(escenarioBifurcacion)}// estoy aqui





const confg_escSig_TEST = {game.removeVisual(puertaSur)}
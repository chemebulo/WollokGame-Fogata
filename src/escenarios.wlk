import puertas.*
import direccion.*
import escenariosManager.*
import confgEscenarios.*
import confgEscSig.*

// #################################################################### PUERTAS PARA TODO EL JUEGO ####################################################################

const puertaNorte = new Puerta(image = "puerta.png",position = norte.ubicacion(), irHacia = escenarioInicial)    
const puertaOeste = new Puerta(image = "puerta.png",position = oeste.ubicacion(), irHacia = escenarioInicial)
const puertaEste  = new Puerta(image = "puerta.png",position = este.ubicacion() , irHacia = escenarioInicial)
const puertaSur   = new Puerta(image = "puerta.png",position = sur.ubicacion()  , irHacia = escenarioInicial)

const puertaEntradaCabaña = new Puerta(image = "puerta.png", irHacia= escenarioCabañaInicial)
const puertaEntradaCueva = new Puerta(image ="puerta.png",irHacia = escenarioCueva)
const puertaGranero = new Puerta(image = "puerta.png",irHacia= escenarioGranero)


// CONSTRUCTOR DE ESCENARIOS
object esc{
    method construir (confg_esc,confg_esc_sig,fondoEsc){
        return new Escenario(confgActual = confg_esc,
                             confgEscSiguiente = confg_esc_sig,
                             fondoEscenario = fondoEsc)
    }
}

// ####################################################################################################################################################################
/*                                         ESCENARIOS PARA TODO EL JUEGO:
    TEMPLATE escenario:
    const nombre_escenario = esc.construir(@param,    //configurador implementado en confgEscenarios.wlk
                                           @param,    //configurador implementado en confgEsSig.wlk
                                           @param     // imagen de 1300px * 900 px
                                           )    
IMPORTANTE!!!
Cuando de un escenario se va a otro escenario que ya se visito (donde ocurre una etapa distinta del juego), 
se debe settear los dos primeros parametros al escenario al que se ira dentro del configuradorEscenarioSiguiente
del escenarioActual

TEMPLATE escenarioDiapositivas:
    const nombre_escenario = esc.construir(@param, //configurador implementado en confgEscenarios.wlk
                                            {}   , // no requiere configuradorEscenario siguiente
                                             @param     // imagen de 1300px * 900 px que es la primer diapositiva que se muestra
    )
    
*/
// ########################################### ESCENARIO: inicioJuego ###########################################

const inicioJuego = esc.construir(confg_inicioJuego, {}, "inicio-v2.png")

// ######################################### ESCENARIO: escenarioInicial #########################################

const escenarioInicial = esc.construir(confg_EscenarioInicial_v1,
                                       confg_escSig_escenarioInicial_v1, 
                                       "fondo-escenario-inicial.png")

// ###################################### ESCENARIO: escenarioBifurcacion #######################################

const escenarioBifurcacion = esc.construir(confg_escenarioBifurcacion_v1,
                                           confg_escSig_escenarioBifurcacion_v1,
                                           "fondo-escenario-inicial.png")

const escenarioEntradaCabaña = esc.construir(confg_escenarioEntradaCabaña_v1,
                                             confg_escSig_escenarioEntradaCabaña_v1,
                                             "fondo-escenario-inicial.png" )

// ##################################### ESCENARIO: escenarioEntrarACabaña ######################################

 const escenarioCabañaInicial = esc.construir(confg_escenarioCabañaInicial_v1,
                                              confg_escSig_escenarioCabañaInicial_v1,
                                              "cabaña.png")   

// ########################################## ESCENARIO: escenarioTEST ##########################################

const escenarioEntradaCueva = esc.construir(confg_escenarioEntradaCueva_v1,
                                             confg_escSig_escenarioEntradaCueva_v1,
                                             "fondo-entrada-cueva.png")

const escenarioCueva = esc.construir(confg_escenarioCueva_v1,
                             confg_esSig_cueva_v1,"fondo-cueva.png")


const escenarioTEST = esc.construir(confg_escenarioTEST,
                                    confg_escSig_TEST, 
                                    "fondo-escenario-inicial.png")

//const escenarioCueva = esc.construir({},{},"fondo-cueva.png")

// ##############################################################################################################
//  ESCENARIOS EXCLUSIVOS PARA LAS DIAPOSITIVAS
// ##############################################################################################################

const escenarioDiapoGranero = esc.construir(confg_graneroDiapo, {}, "granero-diapo1.png") 

const escenarioGranero = esc.construir({},{},"fondo-granero.png")

const escenarioAmigaMuerta = esc.construir(confg_escenarioAmigaMuerta,{},"diapo-amiga-muerta1.png")

const escenarioEntradaGranero = esc.construir({},{},"")
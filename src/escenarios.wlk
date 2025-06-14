import puertas.*
import direccion.*
import escenariosManager.*
import confgEscenarios.*
import confgEscSig.*



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

const inicioJuego = esc.construir(confg_inicioJuego, {}, "inicio.png")

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

const escenarioEntradaGranero = esc.construir(confg_escenarioEntradaGranero_v1,
                                                confg_esSig_escenarioEntradaGranero_v1,
                                                "fondo-entrada-granero.png")

const escenarioGranero = esc.construir(confg_escenarioGranero_v1,confg_esSig_escenarioGranero_v1,"fondo-granero.png")

const escenarioPeleaFinal = esc.construir(confg_escenarioPeleaFinal,confg_esSig_escenarioPeleaFinal,"fondo-cueva.png") // recordar borrar la puertade salida

// ##############################################################################################################
//  ESCENARIOS EXCLUSIVOS PARA LAS DIAPOSITIVAS
// ##############################################################################################################

const escenarioDiapoGranero = esc.construir(confg_graneroDiapo, {}, "granero-diapo1.png") 


const escenarioAmigaMuerta = esc.construir(confg_escenarioAmigaMuerta,{},"diapo-amiga-muerta1.png")

const escenarioDiapoPeleaFinal = esc.construir(confg_escenarioDiapoPeleaFinal,{},"diapo-pelea-final1.png")



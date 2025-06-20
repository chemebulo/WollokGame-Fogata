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

const inicio = esc.construir(inicioC_v1, {}, "inicio.png")

// ######################################### ESCENARIO: escenarioInicial #########################################

const fogata = esc.construir(fogataC_v1, fogataCES_v1, "fondo-escenario-inicial.png")

// ###################################### ESCENARIO: escenarioBifurcacion #######################################

const bifurcacion   = esc.construir(bifurcacionC_v1, bifurcacionCES_v1, "fondo-escenario-inicial.png")

const entradaCabaña = esc.construir(entradaCabañaC_v1, entradaCabañaCES_v1, "fondo-escenario-inicial.png" )

// ##################################### ESCENARIO: escenarioEntrarACabaña ######################################

const cabaña = esc.construir(cabañaC_v1, cabañaCES_v1, "cabaña.png")   

// ########################################## ESCENARIO: escenarioTEST ##########################################

const entradaCueva    = esc.construir(entradaCuevaC_v1, entradaCuevaCES_v1, "fondo-entrada-cueva.png")

const cueva           = esc.construir(cuevaC_v1, cuevaCES_v1,"fondo-cueva.png")

const escenarioTEST   = esc.construir(escenarioTestC_v1, escenarioTestCES_v1, "fondo-escenario-inicial.png")

const entradaGranero  = esc.construir(entradaGraneroC_v1, entradaGraneroCES_v1, "fondo-entrada-granero.png")

const granero         = esc.construir(graneroC_v1, graneroCES_v1, "fondo-granero.png")

const peleaFinal      = esc.construir(peleaFinalC_v1, peleaFinalCES_v1, "fondo-cueva.png") // Recordar borrar la puerta de salida

const estacionamiento = esc.construir(estacionamientoC_v1, {}, "fondo-escenario-final.png")

// ################################# ESCENARIOS EXCLUSIVOS PARA LAS DIAPOSITIVAS #################################

const diapoGranero     = esc.construir(diapoGraneroC_v1, {}, "granero-diapo1.png") 

const diapoAmigaMuerta = esc.construir(diapoAmigaMuertaC_v1, {}, "diapo-amiga-muerta1.png")

const diapoPeleaFinal  = esc.construir(diapoPeleaFinalC_v1, {}, "diapo-pelea-final1.png")
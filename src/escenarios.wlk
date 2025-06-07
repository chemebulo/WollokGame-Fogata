import wollok.game.*
import protagonista.*
import videojuego.*
import enemigos.*
import puertas.*
import direccion.*
import dialogos.*
import visualesExtra.*
import escenarioManager.*
import escenarios_mapas.*
import visualesDiapositivas.*
import eventos.*
import confgEscenarios.*
import confgEscSig.*


// #################################################################### PUERTAS PARA TODO EL JUEGO ####################################################################

const puertaNorte = new PuertaAbierta(image = "puerta.png", position = norte.ubicacion(), irHacia = escenarioInicial)    
const puertaOeste = new PuertaAbierta(image = "puerta.png", position = oeste.ubicacion(), irHacia = escenarioInicial)
const puertaEste  = new PuertaAbierta(image = "puerta.png", position = este.ubicacion() , irHacia = escenarioInicial)
const puertaSur   = new PuertaAbierta(image = "puerta.png", position = sur.ubicacion()  , irHacia = escenarioInicial)

const puertaEntradaCabaña = new PuertaAbierta(image = "puerta.png", irHacia= escenarioCabañaInicial)
  
const puertaNorteCerrada = new PuertaCerrada(image = "puerta.png", position = sur.ubicacion()  , mensaje = "Esta cerrada por ahora", irHacia = escenarioInicial)
const puertaOesteCerrada = new PuertaCerrada(image = "puerta.png", position = oeste.ubicacion(), mensaje = "Esta cerrada por ahora", irHacia = escenarioInicial)
const puertaEsteCerrada  = new PuertaCerrada(image = "puerta.png", position = este.ubicacion() , mensaje = "Esta cerrada por ahora", irHacia = escenarioInicial)
const puertaSurCerrada   = new PuertaCerrada(image = "puerta.png", position = sur.ubicacion()  , mensaje = "Esta cerrada por ahora", irHacia = escenarioInicial)


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
*/
// ########################################### ESCENARIO: inicioJuego ###########################################

const inicioJuego = esc.construir(confg_inicioJuego,{},"inicio-v2.png")

// ######################################### ESCENARIO: escenarioInicial #########################################

const escenarioInicial = esc.construir(confg_EscenarioInicial,
                                       confg_escSig_escenarioInicial, 
                                       "fondo-escenario-inicial.png")
// ###################################### ESCENARIO: escenarioBifurcacion #######################################


const escenarioBifurcacion = esc.construir(confg_escenarioBifurcacion,
                                           confg_escSig_escenarioBifurcacion_v1,
                                            "fondo-escenario-inicial.png")

const escenarioEntradaCabaña = esc.construir(confg_escenarioEntradaCabaña,
                                            confg_escSig_escenarioEntradaCabaña_v1,
                                            "fondo-escenario-inicial.png" )
// ##################################### ESCENARIO: escenarioEntrarACabaña ######################################

 const escenarioCabañaInicial = esc.construir(confg_escenarioCabañaInicial,
                                              confg_escSig_escenarioCabañaInicial,
                                              "cabaña.png")   

// ########################################## ESCENARIO: escenarioTEST ##########################################


const escenarioTEST = esc.construir(confg_escenarioTEST,
                                    confg_escSig_TEST,"fondo-escenario-inicial.png")

// ##############################################################################################################


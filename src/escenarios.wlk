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

// ####################################################################################################################################################################
/*                                         ESCENARIOS PARA TODO EL JUEGO:
    TEMPLATE escenario:
    const nombre_escenario = new Escenario (confgActual = ...       ,    // implementar en confEscenarios.wlk
                                            confgEscSiguiente = ... ,    // implementar confgEscSig.wlk
                                            fondoEscenario =  ...)      //  imagen de 1300px * 900px
*/
// ########################################### ESCENARIO: inicioJuego ###########################################

const inicioJuego = new Escenario(confgActual = confg_inicioJuego,
                                  fondoEscenario= "inicio-v2.png")


// ######################################### ESCENARIO: escenarioInicial #########################################

const escenarioInicial = new Escenario(confgActual = confg_EscenarioInicial,
                                       confgEscSiguiente = confg_escSig_escenarioInicial,
                                       fondoEscenario = "fondo-escenario-inicial.png")
 

// ###################################### ESCENARIO: escenarioBifurcacion #######################################


const escenarioBifurcacion = new Escenario(confgActual = confg_escenarioBifurcacion,
                                           confgEscSiguiente= confg_escSig_escenarioBifurcacion_v1,
                                           fondoEscenario= "fondo-escenario-inicial.png")
 


const escenarioEntradaCabaña = new Escenario(confgActual = confg_escenarioEntradaCabaña,
                                             confgEscSiguiente= confg_escSig_escenarioEntradaCabaña_v1,
                                             fondoEscenario = "fondo-escenario-inicial.png")
  

// ##################################### ESCENARIO: escenarioEntrarACabaña ######################################

const escenarioCabañaInicial = new Escenario (confgActual= confg_escenarioCabañaInicial,
                                              confgEscSiguiente= confg_escSig_escenarioCabañaInicial,
                                              fondoEscenario ="cabaña.png")
    

// ########################################## ESCENARIO: escenarioTEST ##########################################


const escenarioTEST = new Escenario(confgActual = confg_escenarioTEST,
                                    confgEscSiguiente= confg_escSig_TEST,
                                    fondoEscenario = "fondo-escenarioTEST.png")


// ##############################################################################################################
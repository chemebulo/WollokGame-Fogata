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
import configuradorEscenarios.*


// #################################################################### PUERTAS PARA TODO EL JUEGO ####################################################################

const puertaNorte = new PuertaAbierta(image = "puerta.png", position = norte.ubicacion(), irHacia = escenarioInicial)    
const puertaOeste = new PuertaAbierta(image = "puerta.png", position = oeste.ubicacion(), irHacia = escenarioInicial)
const puertaEste  = new PuertaAbierta(image = "puerta.png", position = este.ubicacion() , irHacia = escenarioInicial)
const puertaSur   = new PuertaAbierta(image = "puerta.png", position = sur.ubicacion()  , irHacia = escenarioInicial)
  
const puertaNorteCerrada = new PuertaCerrada(image = "puerta.png", position = sur.ubicacion()  , mensaje = "Esta cerrada por ahora", irHacia = escenarioInicial)
const puertaOesteCerrada = new PuertaCerrada(image = "puerta.png", position = oeste.ubicacion(), mensaje = "Esta cerrada por ahora", irHacia = escenarioInicial)
const puertaEsteCerrada  = new PuertaCerrada(image = "puerta.png", position = este.ubicacion() , mensaje = "Esta cerrada por ahora", irHacia = escenarioInicial)
const puertaSurCerrada   = new PuertaCerrada(image = "puerta.png", position = sur.ubicacion()  , mensaje = "Esta cerrada por ahora", irHacia = escenarioInicial)

// ####################################################################################################################################################################

// ########################################### ESCENARIO: inicioJuego ###########################################

object inicioJuego inherits Escenario(configuracionActual = confg_inicioJuego){
}

// ######################################### ESCENARIO: escenarioInicial #########################################

object escenarioInicial  inherits Escenario(configuracionActual = confg_EscenarioInicial){
                                      
    override method configurarPuertas(){
        puertaNorte.irHacia(escenarioBifurcacion)
    }
} 

// ###################################### ESCENARIO: escenarioBifurcacion #######################################

object escenarioBifurcacion inherits Escenario(configuracionActual = confg_escenarioBifurcacion){

    override method configurarPuertas(){
        puertaNorte.irHacia(escenarioInicial)
        puertaOeste.irHacia(escenarioTEST)
        puertaEste.irHacia(escenarioTEST)
    }

    
}


// ######################################### ESCENARIO: escenarioGalpon #########################################

object escenarioGalpon{}


// ##################################### ESCENARIO: escenarioEntrarACabaña ######################################

object escenarioEntrarACabaña{}


// ########################################## ESCENARIO: escenarioTEST ##########################################

object escenarioTEST inherits Escenario(configuracionActual = confg_escenarioTEST){


    override method configurarPuertas(){
        puertaOeste.irHacia(escenarioBifurcacion)
    }
}


// ##############################################################################################################


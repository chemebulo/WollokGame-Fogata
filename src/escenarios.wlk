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

const puertaEntradaCabaña = new PuertaAbierta(image = "puerta.png", irHacia= escenarioCabañaInicial)
  
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
                                      
    override method configurarEscenarioSiguiente(){
        puertaNorte.irHacia(escenarioBifurcacion)
    }
} 

// ###################################### ESCENARIO: escenarioBifurcacion #######################################

/*
object escenarioBifurcacion inherits Escenario(fondoEscenario   = "fondo-escenario-inicial.png"
                                               mapa             = mapa_escenarioBifurcacion,
                                               visualesEnEscena = [puertaNorte, puertaOeste, puertaEste, amiga, protagonista,loboAgresivo, loboPasivo],
                                               ost              = game.sound("musica-escenarioInicial-v1.mp3"),
                                               eventos= ["Lobo persigue al personaje"]){
*/
object escenarioBifurcacion inherits Escenario(configuracionActual = confg_escenarioBifurcacion){


    override method configurarEscenarioSiguiente(){
        
        puertaEste.irHacia(escenarioEntradaCabaña)
    }
}

object escenarioBifurcacion_v2 inherits Escenario(configuracionActual = confg_escenarioBifurcacion_v2){
    override method configurarEscenarioSiguiente(){
        puertaOeste.irHacia(escenarioTEST)
    }
}





// ######################################### ESCENARIO: escenarioGalpon #########################################

object escenarioGalpon{}

object escenarioEntradaCabaña inherits Escenario(configuracionActual = confg_escenarioEntradaCabaña){

    override method configurarEscenarioSiguiente(){
        puertaEntradaCabaña.irHacia(escenarioCabañaInicial)
    }
}

object escenarioEntradaCabaña_v2 inherits Escenario(configuracionActual = confg_escenarioEntradaCabaña_v2){

    override method configurarEscenarioSiguiente(){
        puertaOeste.irHacia(escenarioBifurcacion_v2)
    }
}


// ##################################### ESCENARIO: escenarioEntrarACabaña ######################################

object escenarioCabañaInicial inherits Escenario (configuracionActual= confg_escenarioCabañaInicial){
    override method configurarEscenarioSiguiente(){
        puertaOeste.irHacia(escenarioInicial)
    }

    override method limpiar(){
        super()
        game.removeVisual(puertaOeste)
    }
}


// ########################################## ESCENARIO: escenarioTEST ##########################################


object escenarioTEST inherits Escenario(configuracionActual = confg_escenarioTEST){



    override method configurarEscenarioSiguiente(){

        puertaOeste.irHacia(escenarioCabañaInicial)
    }
}

// ##############################################################################################################
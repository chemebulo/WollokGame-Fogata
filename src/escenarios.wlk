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

object inicioJuego inherits Escenario(fondoEscenario   = "inicio-v2.png",
                                      mapa             = mapa_inicioJuego,
                                      visualesEnEscena = [],
                                      ost              = game.sound("inicio_v1.mp3")){


    
}

// ######################################### ESCENARIO: escenarioInicial #########################################

object escenarioInicial  inherits Escenario(fondoEscenario   = "fondo-escenario-inicial.png",
                                            mapa             = mapa_escenarioInicial,
                                            visualesEnEscena = [amiga, carpa, fogata, puertaNorte, protagonista],
                                            ost              = game.sound("musica-escenarioInicial-v1.mp3"),
                                            dialogo = dialogoEscenarioInicial){
                                      
 


    override method configurarPuertas(){
        puertaNorte.irHacia(escenarioBifurcacion)
    }
  
} 


// ###################################### ESCENARIO: escenarioBifurcacion #######################################

object escenarioBifurcacion inherits Escenario(fondoEscenario   = "fondo-escenario-inicial.png",
                                               mapa             = mapa_escenarioBifurcacion,
                                               visualesEnEscena = [puertaNorte, puertaOeste, puertaEste, protagonista,lobo],
                                               ost              = game.sound("musica-escenarioInicial-v1.mp3"),
                                               eventos= [persecucionLobo]){

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

object escenarioTEST inherits Escenario(mapa             = mapa_escenarioTest,
                                        fondoEscenario   = "fondo-escenarioTEST.png",
                                        visualesEnEscena = [carpa, amiga, protagonista, puertaOeste],
                                        ost              = game.sound("musica-escenarioInicial.mp3"),
                                        dialogo = dialogoEscenarioTest){


    override method configurarPuertas(){
        puertaOeste.irHacia(escenarioInicial)
    }
}


// ##############################################################################################################


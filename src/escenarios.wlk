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

    override method puestaEnEscena(){
         ost.shouldLoop(true)
         ost.play()
         self.dibujarFondo()
         //self.dibujarTablero()
    }
    
    override method limpiar(){
        ost.stop()
        game.removeVisual(fondo)
    }
}

// ######################################### ESCENARIO: escenarioInicial #########################################

object escenarioInicial  inherits Escenario(fondoEscenario   = "fondo-escenario-inicial.png",
                                            mapa             = mapa_escenarioInicial,
                                            visualesEnEscena = [amiga, carpa, fogata, puertaNorte, protagonista],
                                            ost              = game.sound("musica-escenarioInicial-v1.mp3")){

    // Solo usar si en el escenario hay un NCP con el que interactuar. Esto a fututo se tendría que refactorizar...
    const npc           = amiga 
    const dialogoNPC    = amigaConversacion.inicializar()
    const ultimoDialogo = amigaConversacion.dialogoFinal()

    override method configurarPuertas(){
        puertaNorte.irHacia(escenarioBifurcacion)
    }

    override method configurarConversacion(){
        protagonista.npcActual(npc)
        protagonista.conversacionNPC(dialogoNPC)
        protagonista.codUltimoDialogo(ultimoDialogo)
    }
} 


// ###################################### ESCENARIO: escenarioBifurcacion #######################################

object escenarioBifurcacion inherits Escenario(fondoEscenario   = "fondo-escenario-inicial.png",
                                               mapa             = mapa_escenarioBifurcacion,
                                               visualesEnEscena = [puertaNorte, puertaOeste, puertaEste, protagonista],
                                               ost              = game.sound("musica-escenarioInicial-v1.mp3")){

    override method configurarPuertas(){
        puertaNorte.irHacia(escenarioInicial)
        puertaOeste.irHacia(escenarioTEST)
        puertaEste.irHacia(escenarioTEST)
    }

    override method eventosIniciar() {
        game.onTick(800, "Lobo persigue al personaje", {lobo.perseguirAPresaYAtacar()})
    }

    override method eventosFinalizar() {
        game.removeTickEvent("Lobo persigue al personaje")
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
                                        ost              = game.sound("musica-escenarioInicial.mp3")){


    // Implementar a gusto y usar este escenario para testear a futuro las funcionalidades.
    override method puestaEnEscena(){
        ost.shouldLoop(true)
         ost.play()
         self.dibujarFondo()
         self.configurarPuertas()
         self.dibujarTablero()
         self.agregarVisualesEscena()
    }

   


    override method configurarPuertas(){
        puertaOeste.irHacia(escenarioInicial)
    }
}


// ##############################################################################################################


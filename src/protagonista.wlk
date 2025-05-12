import escenarios.*
import wollok.game.*
import direccion.*
import videojuego.*

import enemigos.*
import dialogos.*
//import estado.*

object protagonista{
    // ############################################## ATRIBUTOS ############################################## //

    var property position = game.at(6,4)
    var property vida = 10
    var property daño = 1

    //********************** VARIABLES PARA CONVERSACION ***********************************//

    
    var property conversacionNPC = new Dictionary()
    var property npcActual = amiga // depende el escenario hablara con amiga o guardabosques
    var property estadoConversacion = 1
    var property conversadorActual = self
    var property codUltimoDialogo = 0

    //**************************************************************************************//



    
    const property vg = videojuego
    
    var property image = "protagonista-abajo.png"

 
    var property objetosColision = #{amiga}


   // ########################################## MOVIMIENTO GENERAL ######################################### //

    method mover(direccion){
        self.validarSiEstaVivo()
        self.validarSiPuedeMover(direccion)
        self.moverAl(direccion)
    }

    method validarSiEstaVivo(){
        if (not self.estaVivo()) { self.error("Estoy muerto") }
    }

    method validarSiPuedeMover(direccion){ 
        const posicionAMover = direccion.siguientePosicion(position)

        if(not self.puedoMover(posicionAMover)){ self.error("No puedo atravesar objetos o salir del mapa") }
    }

    method moverAl(direccion){
        position = direccion.siguientePosicion(position)
        self.cambiarImagen(direccion)
    }

    // ####################################### MOVIMIENTO - COLISIONES ####################################### // 
    
    method puedoMover(posicionAMover) = self.estaDentroDelTablero(posicionAMover) and
                                        not self.colisionoConAlgoEn(posicionAMover)

    method estaDentroDelTablero(posicionAMover) = posicionAMover.x().between(0, game.width()  - 1) and 
                                                  posicionAMover.y().between(0, game.height() - 1) 
    
    method colisionoConAlgoEn(posicionAMover) = self.posicionesDeObjetosConColision().contains(posicionAMover)

    method posicionesDeObjetosConColision() = objetosColision.map({cosa => cosa.position()})
    
    method cambiarImagen(direccion){ 
        self.image("protagonista-"+direccion.toString()+".png") 
    }


    method estaVivo() = self.vida() > 0


    method objetosColision(_objetosColision){ 
        objetosColision = _objetosColision
        }
    // ############################################# INTERACCIÓN ############################################# // 

    method interaccion(visual) {
        // Por ahora nada...
    }


    // ############################################ DIALOGOS NPC ###########################################

    method interactuarNPC(){
        if (self.estaAlLadoDe(npcActual)){
            self.conversar()
        }
    }
    method estaAlLadoDe(npc){
        return (self.xPos() - (npc.xPos())).abs() == 1 //estoy exactamente a 1 celda del npc
    }

    method conversar(){

        
        if(not self.esDialogoFinal()){
        
        
        game.say(conversadorActual,conversacionNPC.get(estadoConversacion))

        self.cambiarConversador()
        estadoConversacion = estadoConversacion + 1 // AVANZA LA CONVERSACION
            
            
        }
        else {
           
            game.say(conversadorActual, conversacionNPC.get(estadoConversacion)) // si la conversacion termina siempre se dira el ultimo dialogo
        }
    }

    method cambiarConversador(){
        if (estadoConversacion == 0 || estadoConversacion.even()){
            conversadorActual = self
        }
        else{
            conversadorActual = npcActual
        }
    }

    

    method esDialogoFinal() = estadoConversacion == self.codUltimoDialogo()

    
    method xPos(){
        return self.position().x()
    }


    
}

object amiga{
    var property position = game.at(2,4)

    method image() = "amiga.png"

    method xPos(){
        return self.position().x()
    }
}

object fogata{
    var property image = "fogata.png"

    method position() = game.at(3,4)
}

object carpa {

    var property carpa = "carpa.png"

    method position() = game.at(6,4)
}

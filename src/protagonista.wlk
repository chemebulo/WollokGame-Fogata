import escenarios.*
import wollok.game.*
import direccion.*
import videojuego.*
import enemigos.*
import dialogos.*
import elementos.*
//import estado.*


object protagonista{
    // ############################################## ATRIBUTOS ############################################## //

    var property position = game.at(0,0)
    var property vida = 10
    var property daño = 1
    const property vg = videojuego
    var property image = "protagonista-abajo.png"

    //********************** VARIABLES PARA CONVERSACION ***********************************//

    
    var property conversacionNPC = new Dictionary()
    var property npcActual = amiga // depende el escenario hablara con amiga o guardabosques
    var property estadoConversacion = 1
    var property conversadorActual = self
    var property codUltimoDialogo = 0


   // ######################################### ESTADO #################################################


    method validarSiEstaVivo(){ 
        if (not self.estaVivo()) { self.error("Estoy muerto") }
    }

     method estaVivo() = self.vida() > 0

   // ########################################## MOVIMIENTO GENERAL ######################################### //

    method mover(direccion){
        self.validarSiEstaVivo() 
        if(self.puedoMover(direccion)){
            self.moverHacia(direccion)
        }
    }

     method moverHacia(direccion){
        position = direccion.siguientePosicion(position)
        self.cambiarImagen(direccion)
    }

    // ####################################### COMPROBAR MOVIMIENTO ####################################### // 
    
    method puedoMover(direccion) {
        const posicionAMover = direccion.siguientePosicion(position)

        return self.estaDentroDelTablero(posicionAMover) and
                 not self.hayObstaculos(posicionAMover)
    }

    

    method estaDentroDelTablero(posicionAMover) = self.existeX(posicionAMover.x()) and self.existeY(posicionAMover.y())
    
                                                
	method existeX(x){
        const anchoJuego = game.width()
		return self.enLimite(x, anchoJuego)
		
	} 

	method existeY(y){
        const altoJuego = game.height()
		return self.enLimite(y, altoJuego)
		
	}                                                                                              
    
    method enLimite(coord, max){
		return coord.between(0, max - 1) 
	}
 
    
    method hayObstaculos(posicion) {
        return not self.objetosEnPosicion(posicion).all({visual => visual.esAtravesable()})
    }

    method objetosEnPosicion(posicion){
        return game.getObjectsIn(posicion).copyWithout(self)
    }



    method cambiarImagen(direccion){ 
        self.image("protagonista-"+direccion.toString()+".png") 
    }

  

    // ####################### INTERACCIÓN CON ENEMIGOS U OBJETOS############################################# // 


    method interaccion(visual) {
        // Por ahora nada...
    }


    // ############################################ DIALOGOS NPC ############################################# //

    /*   esto va a cambiarse a futuro a un objeto distinto quitando responsabilidad al protagonista, 
        es prototipo de momento*/

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

    method cambiarConversador(){ // cambiar todo esto a un ESTADO
        if (self.esTurnoDelProtagonista()){
            conversadorActual = self
        }
        else{
            conversadorActual = npcActual
        }
    }

    method esTurnoDelProtagonista() = estadoConversacion == 0 || estadoConversacion.even()

    method esDialogoFinal() = estadoConversacion == self.codUltimoDialogo()

    method xPos(){
        return self.position().x()
    }


    //############ PARA TESTEAR #################

    method mover(direccion,cantidad){
        (1 .. cantidad).forEach({n => self.mover(direccion)})
    }
    //###########################################

}


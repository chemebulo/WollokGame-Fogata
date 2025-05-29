import escenarios.*
import wollok.game.*
import direccion.*
import videojuego.*
import enemigos.*
import dialogos.*
import visualesExtra.*
//import estado.*

object protagonista{
    // ################################################ ATRIBUTOS ################################################

    var property position = game.at(0,0)
    var property image    = "protagonista-abajo.png"
    var property vida     = 10
    const property daño   = 1
    const property vg     = videojuego

    // ####################################### VARIABLES PARA CONVERSACION #######################################
    
    var  conversacionNPC = []
    var property npcActual          = null 
    var property conversadorActual  = self
  
   // ################################################## ESTADO ##################################################

    method validarSiEstaVivo(){ 
        if (not self.estaVivo()) { self.error("Estoy muerto") }
    }

     method estaVivo() = self.vida() > 0

   // ############################################ MOVIMIENTO GENERAL ############################################

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

    // ########################################### COMPROBAR MOVIMIENTO ########################################## 
    
    method puedoMover(direccion) {
        const posicionAMover = direccion.siguientePosicion(position)

        return self.estaDentroDelTablero(posicionAMover) and not self.hayObstaculos(posicionAMover)
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
        self.image("protagonista-" + direccion.toString() + ".png") 
    }

    // #################################### INTERACCIÓN CON ENEMIGOS U OBJETOS ################################### 

    method interaccion(visual) {
        // Por ahora nada...
    }

    // ############################################## DIALOGOS NPC ###############################################

  

    method interactuarNPC(){
      
        if (self.estaAlLadoDe(npcActual)){self.conversar()}
    }

    method estaAlLadoDe(npc){
        return (self.xPos() - (npc.xPos())).abs() == 1 // Estoy exactamente a 1 celda del NPC.
    }

    method conversar() {
    if(not self.esDialogoFinal()){
        game.say(conversadorActual,self.dialogoActual())
        conversacionNPC.remove(self.dialogoActual())
        self.cambiarConversador()
    }
    }

    method dialogoActual() = conversacionNPC.first()

    method esDialogoFinal() = conversacionNPC.isEmpty()

    method cambiarConversador(){ 
       
        if (self.esMiTurnoDeHablar()){conversadorActual = self}else {conversadorActual = npcActual}
    }

    method esMiTurnoDeHablar() = conversacionNPC.size().even()
    
    method conversacionNPC(_conversacionNPC){conversacionNPC=_conversacionNPC}

    method resetearDialogo(){
        conversacionNPC= []
        conversadorActual=self
    }
    
    method xPos() = self.position().x()


    // ############################################### PARA TESTEAR ###############################################

    method mover(direccion,cantidad){
        (1 .. cantidad).forEach({n => self.mover(direccion)})
    }

}






import direccion.*
import videojuego.*
import visualesExtra.*
import gestores.*
import npcEstados.*

object protagonista inherits Visual{
    // ################################################ ATRIBUTOS ################################################

    var property position = game.at(0,0)
    var property image    = "prota-desarmado-abajo.png"
    var property vida     = 10
    const property daño   = 1
    const property vg     = videojuego
    var property estoyAtacando = false
    const colisionesGestor = gestorDeColisiones
    var property estadoProta = desarmadoProtagonista // Verifica si estoy dentro del tablero y los objetos que no puedo atravesar.

    // ####################################### VARIABLES PARA CONVERSACION #######################################
    
    var property conversacionNPC    = []
    var property npcActual          = null 
    var property conversadorActual  = self
  
   // ################################################## ESTADO ##################################################

    method validarSiEstaVivo(){ 
        if (not self.estaVivo()) { vg.finalizarJuego()}
    }

     method estaVivo() = self.vida() > 0

   // ############################################ MOVIMIENTO GENERAL ############################################

    method mover(direccion){
        // self.validarSiEstaVivo() 
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

        return colisionesGestor.estaDentroDelTablero(posicionAMover) and not colisionesGestor.hayObstaculoEn(posicionAMover,self)
    }

    method cambiarImagen(direccion){
        self.image(estadoProta.actual() + direccion.toString() + ".png")
    }
    
    method estadoProta(_estadoProta){
        estadoProta = _estadoProta
    }

    // #################################### INTERACCIÓN CON ENEMIGOS U OBJETOS ################################### 

    method interaccion(visual) {
        // Por ahora nada...
    }

    method atacadoPor(visual) {
        self.validarSiEstaVivo()
        self.vida(vida - visual.daño())
        game.say(self, "Mi vida es "+vida+"")
    }

    // ############################################## DIALOGOS NPC ###############################################

    method interactuarNPC(){
        if (self.estaAlLadoDe(npcActual)){self.conversar()}
    }

    method estaAlLadoDe(npc){
        return (self.estoyEnMismoEjeY(npc)) and self.estoyAUnaCeldaEnX(npc)
    }

    method estoyEnMismoEjeY(npc) = ejeY.estaEnMismoEje(self, npc)

    method estoyAUnaCeldaEnX(npc) = ejeX.estaAlLado(self, npc)
    

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
        if (self.esMiTurnoDeHablar()){conversadorActual = self} else {conversadorActual = npcActual}
    }

    method esMiTurnoDeHablar() = conversacionNPC.size().even()
    
    method conversacionNPC(_conversacionNPC){ conversacionNPC = _conversacionNPC }

    method resetearDialogo(){
        conversacionNPC = []
        conversadorActual = self
    }
    
    /*######################
        ATAQUE
    
    ##############################*/

    method atacar(){
        estadoProta.ataque()
    }

    //PARA CUANDO ME ATACA EL GUARDABOSQUES
    override method atacado(){
        game.say(self,"AUXILIO ME ATACA EL GUARDABOSQUES o el lobo")
    }

    // ############################################### PARA TESTEAR ###############################################

    method mover(direccion,cantidad){
        (1 .. cantidad).forEach({n => self.mover(direccion)})
    }

    method miCeldaArriba() = arriba.siguientePosicion(position)
    method miCeldaAbajo() = abajo.siguientePosicion(position)
    method miCeldaIzquierda()= izquierda.siguientePosicion(position)
    method miCeldaDerecha()= derecha.siguientePosicion(position)
}
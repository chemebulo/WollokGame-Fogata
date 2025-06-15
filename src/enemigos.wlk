import protagonista.*
import visualesExtra.*
import npcEstados.*
import eventos.*
import escenarios.*
import puertas.*
import gestores.gestorAccionesGuardabosques

class Enemigo inherits VisualConMovimiento(position = game.at(5,5)){
    var property estadoCombate 
    var property estado        = new EnemigoVivo(visual = self) // Describe el estado del enemigo. Por defecto, está vivo.
    const property enemigo     = protagonista  // Describe el enemigo que tiene el enemigo (el protagonista).


    method perseguirEnemigo(){
        // El enemigo persigue a su enemigo hasta estar sobre él para poder atacarlo dependiendo de su estado.
        estado.perseguirEnemigo()
    }

    override method atacadoPor(visual){
        // Emite un mensaje cuando el enemigo es atacado por su enemigo.
        estado.atacadoPor(visual)
    }

    override method actualizarAMuerto(){
        // Actualiza el estado del enemigo a muerto y además modifica la imagen del enemigo.
        super()
        estado = new EnemigoMuerto()
        image = self.imagenMuerto()
    }

    method estaSobreEnemigo(){
        // Indica si el enemigo se encuentra sobre su enemigo o no.
        return self.position() == enemigo.position()
    }

    override method esAtravesable(){
        // Indica si el enemigo si tiene colisión o no. En este caso describe que tiene colisión.
        return false
    }

    method atacarEnemigo(){
        // Representa el ataque del enemigo hacia su enemigo.
        estado.atacarEnemigo()
    }

    method puedeAtacarAlEnemigo(){
        // Indica si el enemigo puede atacar a su enemigo. 
        return estado.puedeAtacarAlEnemigo()
    }
}

// ################################################################################################################# \\

class Lobo inherits Enemigo(image = "lobo-derecha.png", estadoCombate = new Agresivo(pj = self), vida = 10, daño = 1){ 
    const property eventoLobo = new EventoLobo(loboEv = self)

    override method imagenNueva(direccion){
        // Describe la imagen nueva del lobo en base a la dirección dada.
        return "lobo-"+direccion.toString()+".png"
    }

    method emitirSonidoEnojado(){
        game.sound("lobo-enojado.mp3").play()
    }
}

// ################################################################################################################# \\

class LoboEspecial inherits Lobo(eventoLobo = new EventoLoboEspecial(loboEv = self), vida = 30){
    const salida
    var puedeSalir = true
     
    method verEntorno(){
        if( not self.estaVivo() and puedeSalir){
            puedeSalir=false
            game.addVisual(salida)
        }
    }
}

// ################################################################################################################# \\

object guardabosques inherits Enemigo(image = "guardabosques-cabaña.png", estadoCombate = desarmadoGuardabosques, vida = 40, daño = 2){
   
  
    override method imagenNueva(direccion){ 
        // Describe la imagen nueva del guardabosques en base a la dirección dada.
        return estadoCombate.actual()+direccion.toString()+".png"
    }

    

    // ################# REFACTORIZAR Y MOVER LA MAYOR PARTE POSIBLE A OTRO LADO DE TODO ESTO: ################# //
   
    method estoyMuerto() = not self.estaVivo()

    method termineDialogo(){
        // Indica si el diálogo con su enemigo (el protagonista) terminó.
        return enemigo.conversacionNPC().isEmpty() 
    }   

}    

// pequeñas acciones que realiza el guardabosques en 3 puntos de la historia en los eventos
class AccionGuardabosques{
    const property gestorAC = gestorAccionesGuardabosques
  
    var accionHecha = false

    method hacerAccion(){ // se usa el booleano para que haga la accion una sola vez
        if(not accionHecha){
            self.hacer()
            accionHecha = true
        }
    }
    method hacer()
    method esTiempoDeRealizarAccion()

}
object darLaLeña inherits AccionGuardabosques{
    
     override method hacer()  { gestorAC.darLeña()}
  

    override method esTiempoDeRealizarAccion() =  guardabosques.termineDialogo()
}
 
object prepararseParaGranero inherits AccionGuardabosques{
    
    override method hacer()  {  gestorAC.darSalidaCabaña()}
        
    override method esTiempoDeRealizarAccion() =  guardabosques.termineDialogo()
}

object peleaFinalEstado inherits AccionGuardabosques { // cuidado si cambian nombre, un escenario se llama peleaFinal
     
    override method hacer() {  gestorAC.darSalidaCueva() }    
               
     override method esTiempoDeRealizarAccion() = guardabosques.estoyMuerto()
}




import protagonista.*
import visualesExtra.*
import npcEstados.*
import eventos.*
import escenarios.*
import puertas.*
import gestores.gestorAccionesGuardabosques
import videojuego.*

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
    method escenarioDondeEstoy() = videojuego.escenario() // agregado solo para que lo usen el loboEspecial y el guardabosques
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
// JEFE DEL GRANERO
object loboEspecial inherits Lobo( vida = 30){

    const musicaVictoria = game.sound("victoria-lobo.mp3")

    method estoyMuerto() = not self.estaVivo()

    method darSalidaGranero() {game.addVisual(puertaGranero)}

    override method actualizarAMuerto(){ //cuando lo matas corta la musica y emite una musica de victoria
        super()
        game.schedule(1,{self.escenarioDondeEstoy().bajarVolumen();musicaVictoria.play()})
       
    }
}
//accion que hace el lobo cuando lo matas
object darSalidaGranero inherits AccionUnica(sujeto=loboEspecial){
        override method hacer() { sujeto.darSalidaGranero() }    
               
     override method esTiempoDeRealizarAccion() = sujeto.estoyMuerto()
}



// ################################################################################################################# \\

object guardabosques inherits Enemigo(image = "guardabosques-cabaña.png", estadoCombate = desarmadoGuardabosques, vida = 40, daño = 2){
   
    const musicaVictoria = game.sound("victoria-guardabosques.mp3")

    override method imagenNueva(direccion){ 
        // Describe la imagen nueva del guardabosques en base a la dirección dada.
        return estadoCombate.actual()+direccion.toString()+".png"
    }

     override method actualizarAMuerto(){ //cuando lo matas corta la musica y emite una musica de victoria
        super()
        game.schedule(1,{self.escenarioDondeEstoy().bajarVolumen();musicaVictoria.play()})
        
        
        
    }

    method darLeña(){
         game.addVisual(leña);
    }
    method darSalidaCabaña(){
         game.addVisual(puertaEntradaCabaña)
    }

    method darSalidaCueva(){
        game.addVisual(puertaEntradaCueva)
    }

    // ################# REFACTORIZAR Y MOVER LA MAYOR PARTE POSIBLE A OTRO LADO DE TODO ESTO: ################# //
   
    method estoyMuerto() = not self.estaVivo()

    method termineDialogo(){
        // Indica si el diálogo con su enemigo (el protagonista) terminó.
        return enemigo.conversacionNPC().isEmpty() 
    }   

}    

// pequeñas acciones que realiza el guardabosques en 3 puntos de la historia en los eventos
class AccionUnica{
    const  property sujeto= null
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
object darLaLeña inherits AccionUnica(sujeto=guardabosques){
    
     override method hacer()  { sujeto.darLeña()}
  

    override method esTiempoDeRealizarAccion() =  sujeto.termineDialogo()
}
 
object prepararseParaGranero inherits AccionUnica(sujeto=guardabosques){
    
    override method hacer()  {  sujeto.darSalidaCabaña()}
        
    override method esTiempoDeRealizarAccion() =  sujeto.termineDialogo()
}

object peleaFinalEstado inherits AccionUnica(sujeto=guardabosques) { // cuidado si cambian nombre, un escenario se llama peleaFinal
     
    override method hacer() {  sujeto.darSalidaCueva() }    
               
     override method esTiempoDeRealizarAccion() = sujeto.estoyMuerto()
}




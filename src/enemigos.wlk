import protagonista.*
import visualesExtra.*
import direccion.*
import npcEstados.*
import eventos.*
import escenarios.*

class Enemigo inherits VisualConMovimiento{
    var property estado    = new EnemigoVivo(visual = self) // Describe el estado del enemigo. Por defecto, está vivo.
    const property enemigo = protagonista  // Describe el enemigo que tiene el enemigo (el protagonista).

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

    method atacarEnemigo() // Representa el ataque del enemigo hacia su enemigo.

    method puedeAtacarAlEnemigo() // Indica si el enemigo puede atacar a su enemigo. 

    method imagenMuerto() // Describe la imagen del enemigo muerto.
}

// ################################################################################################################# \\

class Lobo inherits Enemigo(position = game.at(6,0), image = "lobo-derecha.png", vida = 10, daño = 1){
    const property comportamiento = agresivo // Representa el comportamiento del lobo: agresivo o pasivo.
    const property eventoLobo     = new EventoLobo(loboEv = self)

    override method imagenNueva(direccion){
        // Describe la imagen nueva del lobo en base a la dirección dada.
        return "lobo-"+direccion.toString()+".png"
    }

    override method imagenMuerto(){
        // Describe la imagen del lobo cuando muere.
        return "lobo-muerto.png"
    }

    override method atacarEnemigo(){
        // El lobo ataca al enemigo cada 1 segundo.
        estado.atacarEnemigo()
    }

    override method puedeAtacarAlEnemigo(){
        // Indica si el lobo puede atacar a su enemigo. 
        return comportamiento.puedeAtacarAlEnemigo(self)
    } 
}

class LoboEspecial inherits Lobo(eventoLobo = new EventoLoboEspecial(loboEv=self),vida=30){
     const salida
     var puedeSalir = true
     
     method verEntorno(){
        if(puedeSalir and not self.estaVivo()){
            puedeSalir=false
            game.addVisual(salida)
        }
     }
}

// ################################################################################################################# \\

object guardabosques inherits Enemigo(position = game.at(5,5), image = "guardabosques-cabaña.png", vida = 20, daño = 1){
    var property estadoCombate = armadoGuardabosques // Representa al estado de combate del guardabosques.
    
    var property estadoCabaña = inicioLenia
    override method imagenNueva(direccion){ 
        // Describe la imagen nueva del guardabosques en base a la dirección dada.
        return estadoCombate.actual()+direccion.toString()+".png"
    }

    override method imagenMuerto(){
        // Describe la imagen del guardabosques cuando muere.
        return "guardabosques-muerto.png"
    }

    override method atacarEnemigo(){
        // Representa el ataque del guardabosques hacia el enemigo.
        estadoCombate.ataque()
    } 

    override method puedeAtacarAlEnemigo(){ 
        // Indica si el guardabosques puede atacar a su enemigo. 
        // El guardabosques puede atacarlo si su enemigo se encuentra en una celda lindante a la suya.
        return estadoCombate.posicionesParaCalcularAtaque().contains(enemigo.position())
    }

    // ################# REFACTORIZAR Y MOVER LA MAYOR PARTE POSIBLE A OTRO LADO DE TODO ESTO: ################# //
    /*
        Estos dos metodos los llama eventoCabaña en eventos.wlk
    */

    method comprobarDialogo(){
        // Comprueba si el diálogo terminó para poder darle la leña a su enemigo (el protagonista). 
        if(self.terminoDialogo()){
           estadoCabaña.realizarAccion()
        }
    }

    method terminoDialogo(){
        // Indica si el diálogo con su enemigo (el protagonista) terminó.
        return enemigo.conversacionNPC().isEmpty() 
    }       
           
}    
/*
ESTOS DOS OBJETOS SON LAS ACCIONES QUE HACE EL GUARDABOSQUES LAS DOS VECES QUE ESTA EN LA CABAÑA
SOLO SE ACTIVAN CUANDO EL PROTAGONISTA AGOTA EL DIAOGO.  LUEGO NO HACEN NADA HASTA QUE SE FINALIZA EL 
EVENTO CAMBIANDO DE ESCENARIO
EL BOOLEANO SE CAMBIA A TRUE LUEGO DE REALIZAR ACCION PARA HACERLO UNA SOLA VEZ
*/
object inicioLenia{
    var dioLeña = false

        method realizarAccion(){
            if(not dioLeña){
                     game.addVisual(leña);
                     dioLeña=true 
            }
        }
}
 

object prepararseParaGranero{
     var iremosAGranero = false
        method realizarAccion(){
            if(not iremosAGranero)
                    game.addVisual(puertaEntradaCabaña);
                    iremosAGranero = true
        }
}


// ################################################################################################################# \\
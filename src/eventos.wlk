import protagonista.*
import enemigos.*
import gestores.*
import escenariosManager.*
import npcAtaques.*

class EventoLoopIndividual{
    const sujetoUnico
    const nombreEvento = self.toString()
    const bloque
    const tiempo = 800

    method iniciarEvento(){
        game.onTick(tiempo, nombreEvento, {self.orden(sujetoUnico)})
    }

    method finalizarEvento(){
        game.removeTickEvent(nombreEvento)
    }
    
    method orden(visual){
        bloque.apply(visual)
    }

    method nombreEvento(){
        return nombreEvento
    }
}

// ####################################### EVENTO LOBOS #######################################

class EventoLoboPersecucion inherits EventoLoopIndividual(tiempo = 1000.randomUpTo(2000), bloque = bloquePersecucion){}

class EventoLoboAtaque inherits EventoLoopIndividual(tiempo = 1000, bloque = bloqueAtaque){}
    
const bloquePersecucion = {e => e.perseguirEnemigo()}  

const bloqueAtaque = {e => e.atacarEnemigo()}

//#################### EVENTOS GUARDABOSQUES  ##########################
 
const ataqueGuardabosques = new EventoLoopIndividual(tiempo = 1000.randomUpTo(2000), sujetoUnico = guardabosques, bloque = bloqueAtaqueGuardabosques)

const bloqueAtaqueGuardabosques = {g => g.perseguirEnemigo()}

const ataqueEscopetaGuardabosques = new EventoLoopIndividual(sujetoUnico = guardabosques, tiempo = 1500, bloque = bloqueEscopeta)

const bloqueEscopeta= {g => g.atacarEnemigo()}

// ################################# EVENTOS DE DIALOGOS AL INICIO DEL ESCENARIO #################################

class EventoHablar {
    const sujetoUnico = protagonista
    const mensaje 
    
    method iniciarEvento(){
       game.say(sujetoUnico,mensaje)
    }
    method finalizarEvento(){}
}

class EventoHablarConSonido inherits EventoHablar{
    const ost

    override method iniciarEvento(){
        super()   
       game.sound(ost).play()
    }
}

// ############################################# EVENTOS DE DIALOGOS ############################################

const escucharLobos = new EventoHablarConSonido(mensaje = "¿¿Qué fue eso??", ost = track_manada)

const hablarProta   = new EventoHablar(mensaje = "Laura está muerta...")

const hablarProta2  = new EventoHablarConSonido(mensaje = "Dios mío... ¡¡¡LAURAAA!!!", ost = track_prota_preocupado)   

const hablarProta3  = new EventoHablar(mensaje = "Ya mismo lo mato a ese #&%&#$%&")  

const hablarProta4  = new EventoHablar(mensaje = "¿¿Qué carajo??")

const hablarProta5  = new EventoHablar(mensaje = "Mierda, voy a esa cueva")

const hablarProta6  = new EventoHablar(mensaje = "AHHHHHH")

const hablarProta7  = new EventoHablar(mensaje = "¡¡Lo voy a matar!!")

const hablarProta8  = new EventoHablar(mensaje = "Laura...")

const hablarProta9  = new EventoHablar(mensaje = "¡¡¡AHHHHHHHH!!!")

const guardabosquesHabla  = new EventoHablar(sujetoUnico = guardabosques, mensaje = "Aca al norte está el granero")

const guardabosquesHabla2 = new EventoHablar(sujetoUnico = guardabosques, mensaje = "Aca adentro, apurate")
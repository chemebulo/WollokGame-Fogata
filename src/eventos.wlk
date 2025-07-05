import protagonista.*
import enemigos.*
import escenariosManager.*

// ############################################################################################################################ \\

class EventoLoopIndividual{
    const nombreEvento = self.toString()
    const tiempo       = 800
    const sujetoUnico
    const comportamiento

    // ====================================================================================================================== \\

    method iniciarEvento(){
        game.onTick(tiempo, nombreEvento, {self.aplicarEventoEn(sujetoUnico)})
    }

    method finalizarEvento(){
        game.removeTickEvent(nombreEvento)
    }
    
    method aplicarEventoEn(visual){
        comportamiento.apply(visual)
    }

    method nombreEvento(){
        return nombreEvento
    }
}

// ########################################################################################################################### \\

class EventoEnemigoPersecucion inherits EventoLoopIndividual(tiempo = 1000.randomUpTo(1500), comportamiento = bloquePersecucion){}

class EventoEnemigoAtaque inherits EventoLoopIndividual(tiempo = 1200, comportamiento = bloqueAtaque){}
    
const ataqueGuardabosques         = new EventoEnemigoPersecucion(sujetoUnico = guardabosques)
const ataqueEscopetaGuardabosques = new EventoEnemigoAtaque(sujetoUnico = guardabosques)

const bloquePersecucion = {npc => npc.perseguirEnemigo()}  
const bloqueAtaque      = {npc => npc.atacarEnemigo()}

// ####################################### EVENTOS DE DIALOGOS AL INICIO DEL ESCENARIO ####################################### \\

class EventoHablar{
    const sujetoUnico = protagonista
    const mensaje 
    
    // ====================================================================================================================== \\

    method iniciarEvento(){
       game.say(sujetoUnico, mensaje)
    }

    method finalizarEvento(){}
}

// ########################################################################################################################## \\

class EventoHablarConSonido inherits EventoHablar{
    const ost

    // ====================================================================================================================== \\

    override method iniciarEvento(){
        super()   
        game.sound(ost).play()
    }
}

// ################################################## EVENTOS DE DIALOGOS ################################################### \\

const escucharLobos = new EventoHablarConSonido(mensaje = "¿¿Qué fue eso??", ost = trackManada)

const hablarProta   = new EventoHablar(mensaje = "Laura está muerta...")

const hablarProta2  = new EventoHablarConSonido(mensaje = "Dios mío... ¡¡¡LAURAAA!!!", ost = trackProtaPreocupado)   

const hablarProta3  = new EventoHablar(mensaje = "Ya mismo lo mato a ese #&%&#$%&")  

const hablarProta4  = new EventoHablar(mensaje = "¿¿Qué carajo??")

const hablarProta5  = new EventoHablar(mensaje = "Mierda, voy a esa cueva.")

const hablarProta6  = new EventoHablar(mensaje = "¡¡AHHHHH!!")

const hablarProta7  = new EventoHablar(mensaje = "¡¡Lo voy a matar!!")

const hablarProta8  = new EventoHablar(mensaje = "Laura...")

const hablarProta9  = new EventoHablar(mensaje = "¡¡¡AHHHHHHHH!!!")

const guardabosquesHabla  = new EventoHablar(sujetoUnico = guardabosques, mensaje = "Aca al norte está el granero.")

const guardabosquesHabla2 = new EventoHablar(sujetoUnico = guardabosques, mensaje = "Aca adentro, apurate.")

// ########################################################################################################################## \\
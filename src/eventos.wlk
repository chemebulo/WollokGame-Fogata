import protagonista.*
import enemigos.*
import gestores.*
import escenariosManager.*

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

// ####################################### EVENTO PARA PERSECUCION DE LOBO #######################################

class EventoLoboPersecucion inherits EventoLoopIndividual(tiempo = 1000.randomUpTo(2000), bloque = bloquePersecucion){}

class EventoLoboAtaque inherits EventoLoopIndividual(tiempo = 800, bloque = bloqueAtaque){}
    
const bloquePersecucion = {l => l.perseguirEnemigo()}  

const bloqueAtaque = {l => l.atacarEnemigo()}

// ################################# EVENTOS DE DIALOGOS AL INICIO DEL ESCENARIO #################################

class EventoHablar {
    const tiempo      = 1
    const sujetoUnico = protagonista
    const bloque      = bloqueEventoHablar
    const mensaje 
    
    method ordenUnica(visual){
        bloque.apply(visual,mensaje)
    }

    method iniciarEvento(){
        game.schedule(tiempo, {self.ordenUnica(sujetoUnico)})
    }
}

const bloqueEventoHablar = {v,m => game.say(v,m)}

class EventoHablarConSonido inherits EventoHablar(bloque=bloqueEventoHablarSonido){
    const ost

    override method ordenUnica(visual){
        bloque.apply(visual,ost,mensaje)
    }
}

// ############################################# EVENTOS DE DIALOGOS ############################################

const bloqueEventoHablarSonido = {v,o,m => game.sound(o).play();game.say(v,m) }

const escucharLobos = new EventoHablarConSonido(mensaje = "¿¿Qué fue eso??", ost = track_manada)

const hablarProta   = new EventoHablar(mensaje = "Laura está muerta...")

const hablarProta2  = new EventoHablarConSonido(mensaje = "La puta madre... ¡¡¡LAURAAA!!!", ost = track_prota_preocupado)   

const hablarProta3  = new EventoHablar(mensaje = "Ya mismo lo mato a ese hijo de p@ta")  

const hablarProta4  = new EventoHablar(mensaje = "¿¿Qué carajo??")

const hablarProta5  = new EventoHablar(mensaje = "Mierda, voy a esa cueva")

const hablarProta6  = new EventoHablar(mensaje = "Buehhhh")

const hablarProta7  = new EventoHablar(mensaje = "¡¡¡Ahora si los hago cagar!!!")

const hablarProta8  = new EventoHablar( mensaje = "Laura....")

const hablarProta9  = new EventoHablar( mensaje = "¡¡¡AHHHHHHHH!!!")

const guardabosquesHabla  = new EventoHablar(sujetoUnico = guardabosques, mensaje = "Aca al norte está el granero")

const guardabosquesHabla2 = new EventoHablar(sujetoUnico = guardabosques, mensaje = "Aca adentro, apurate")


 
const ataqueGuardabosques   = new EventoLoopIndividual(sujetoUnico = guardabosques, bloque = bloqueAtaqueGuardabosques)


const bloqueAtaqueGuardabosques = {g => g.perseguirEnemigo()}

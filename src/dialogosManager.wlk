import enemigos.*
import protagonista.*
import puertas.*
import visualesExtra.*

object gestorDeDialogo{
    var property esTiempoDeDialogo = false
    var property dialogo = dialogoEscenarioInicial
    const conversador    = protagonista
  
    // =============================================================================================================================== \\

    method interactuarNPC(){
        if (self.sePuedeConversar()){
           self.conversar()
        }
    }     

    method sePuedeConversar(){
        return esTiempoDeDialogo and conversador.estaAlLadoDelNPC(dialogo.npcDialogo())
    }

    method conversar(){
        if(not dialogo.esUltimoDialogo()){
            dialogo.decirDialogo()
        } else {
           self.accionFinalDialogo()
        }
    }

    method accionFinalDialogo(){
        self.esTiempoDeDialogo(false)       
        dialogo.finalizarDialogo()
    }
}

// ################################################################################################################################### \\

class Dialogo{
    var property conversadorActual  = protagonista
    const property npcDialogo       = null
    const property dialogoEscenario = []
    const property bloque           = {}
    const miGestorDialogo = gestorDeDialogo

    // =============================================================================================================================== \\

    method actualizarADialogoSiguiente(){
        dialogoEscenario.remove(self.dialogoActual())
        self.actualizarConversador()
    }

    method esUltimoDialogo(){
        return dialogoEscenario.isEmpty()
    }

    method decirDialogo(){
        game.say(self.conversadorActual(), self.dialogoActual())
        self.actualizarADialogoSiguiente()
    }

    method dialogoActual(){
        return dialogoEscenario.first()
    }

    method actualizarConversador(){
        if (self.esElTurnoDelProta()){ self.conversadorActual(protagonista) } else 
                                     { self.conversadorActual(npcDialogo)   }
    }

    method esElTurnoDelProta(){
        // Si la cantidad de frases de dialogo es par, es turno del protagonista
        
        return dialogoEscenario.size().even()
    }

    method finalizarDialogo(){
        bloque.apply(npcDialogo,miGestorDialogo)
    }
}

// ############################################################ DIALOGOS ############################################################# \\

const dialogoEnCabaña  = new Dialogo(npcDialogo = guardabosques, dialogoEscenario = dialogoCabaña, bloque = accionCabaña1)

const dialogoEnCabaña2 = new Dialogo(npcDialogo = guardabosques, dialogoEscenario = dialogoCabaña2, bloque = accionCabaña2)

const  dialogoEscenarioInicial = new Dialogo(npcDialogo = amiga, dialogoEscenario = dialogoAmiga, bloque = accionAmiga)

// ######################################################## GUION DE DIALOGOS ######################################################## \\

const dialogoCabaña  = ["Hola, ¿cómo va?", " Juan..emm.. ¿Todo en orden?", "Excelente, me preguntaba si tendría algo de leña", "Claro"]

const dialogoCabaña2 = ["¡¡¡AUXILIOO!!!", "¿Qué pasó Juan?", "Esta lleno de lobos, mataron a mi amiga", "Carajo. No pensé que se acercarían", "¿Qué hago ahora?...Laura...", "Tranquilo, vamos al granero", "¿Porqué?, ¿Qué hay ahi?", "Tengo... armas"]

const dialogoAmiga   = ["¿Dónde quedaba la cabaña?", "Al Norte y a la derecha", "Dale, ahí vengo", "Dale, te espero"]

// ###################################################### BLOQUES FINAL DIALOGO ###################################################### \\

const accionAmiga   = {a, g => game.say(a, "Ve con cuidado"); g.dialogo(dialogoEnCabaña); game.addVisual(puertaNorte);}

const accionCabaña1 = {gu, g => game.addVisual(leña); game.say(gu, "Agarrá de la chimenea un poco"); g.dialogo(dialogoEnCabaña2)}

const accionCabaña2 = {gu, g => game.addVisual(puertaEntradaCabaña); game.say(gu, "Vamos ya mismo hacia allá")}


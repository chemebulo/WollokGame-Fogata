import enemigos.*
import protagonista.*
import puertas.*
import visualesExtra.*

// ################################################################################################################################### \\

object gestorDeDialogo{
    var property esMomentoDeDialogar = false
    var property dialogo = dialogoEscenarioInicial
    const conversador    = protagonista
  
    // =============================================================================================================================== \\

    method interactuarConNPC(){
        if (self.sePuedeConversar()){ self.conversar() }
    }     

    method sePuedeConversar(){
        return esMomentoDeDialogar and conversador.estaAlLadoDelNPC(dialogo.npcDialogo())
    }

    method conversar(){
        if(not dialogo.esUltimoDialogo()){
            dialogo.decirDialogoActual()
        } else {
           self.terminarDialogo()
        }
    }

    method terminarDialogo(){
        self.esMomentoDeDialogar(false)       
        dialogo.finalizarDialogo()
    }
}

// ################################################################################################################################### \\

class Dialogo{
    var property conversadorActual  = protagonista
    const bloque           = {}
    const npcDialogo       = null
    const dialogoEscenario = []
    const dialogoGestor    = gestorDeDialogo

    // =============================================================================================================================== \\

    method decirDialogoActual(){
        game.say(conversadorActual, self.dialogoActual())
        self.actualizarADialogoSiguiente()
    }

    method dialogoActual(){
        return dialogoEscenario.first()
    }

    method actualizarADialogoSiguiente(){
        dialogoEscenario.remove(self.dialogoActual())
        self.actualizarConversador()
    }

    method actualizarConversador(){
        if (self.esElTurnoDelProtagonista()){ self.conversadorActual(protagonista) } else 
                                            { self.conversadorActual(npcDialogo)   }
    }

    method esElTurnoDelProtagonista(){
        // Si la cantidad de frases de dialogo es par, es turno del protagonista
        return dialogoEscenario.size().even()
    }

    method esUltimoDialogo(){
        return dialogoEscenario.isEmpty()
    }

    method finalizarDialogo(){
        bloque.apply(npcDialogo, dialogoGestor)
    }

    // =============================================================================================================================== \\

    method npcDialogo(){
        return npcDialogo
    }

    method dialogoEscenario(){
        return dialogoEscenario
    }
}

// ############################################################ DIALOGOS ############################################################# \\

const dialogoEnCabaña  = new Dialogo(npcDialogo = guardabosques, dialogoEscenario = dialogoCabaña, bloque = accionCabaña1)

const dialogoEnCabaña2 = new Dialogo(npcDialogo = guardabosques, dialogoEscenario = dialogoCabaña2, bloque = accionCabaña2)

const dialogoEscenarioInicial = new Dialogo(npcDialogo = amiga, dialogoEscenario = dialogoAmiga, bloque = accionAmiga)

// ######################################################## GUION DE DIALOGOS ######################################################## \\

const dialogoCabaña  = ["Hola, ¿cómo va?", " Juan... emm... ¿todo en orden?", "Excelente, me preguntaba si tendría algo de leña.", "Claro."]

const dialogoCabaña2 = ["¡¡¡AUXILIOO!!!", "¿Qué pasó Juan?", "Esta lleno de lobos, mataron a mi amiga.", "Carajo. No pensé que se acercarían.", 
                        "¿Qué hago ahora? Laura...", "Tranquilo, vamos al granero.", "¿Por qué? ¿qué hay ahí?", "Tengo... armas."]

const dialogoAmiga   = ["¿Dónde quedaba la cabaña?", "Hacia el Norte y al Este.", "Dale, ahí vengo.", "Dale, te espero."]

// ###################################################### BLOQUES FINAL DIALOGO ###################################################### \\

const accionAmiga   = {a, g => game.say(a, "Andá con cuidado."); g.dialogo(dialogoEnCabaña); game.addVisual(puertaNorte);}

const accionCabaña1 = {gu, g => game.addVisual(leña); game.say(gu, "Agarrá un poco de la chimenea."); g.dialogo(dialogoEnCabaña2)}

const accionCabaña2 = {gu, g => game.addVisual(puertaEntradaCabaña); game.say(gu, "Vamos ya mismo hacia allá.")}

// ################################################################################################################################### \\
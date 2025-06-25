import diapositivasManager.*
import enemigos.*
import protagonista.*
import puertas.*
import visualesExtra.*

object gestorDeDialogo{
    
    var property esTiempoDeDialogo = false
    const conversador = protagonista
    var property dialogo = dialogoEscenarioInicial
  
    method interactuarNPC(){
        if (self.sePuedeConversar()){
           self.conversar()
        }
    }     

    method sePuedeConversar() = esTiempoDeDialogo and conversador.estaAlLadoDelNPC(dialogo.npcDialogo())

    method conversar(){
        if( not dialogo.esUltimoDialogo()){
               dialogo.decirDialogo()
        }
        else{
           self.accionFinalDialogo()
        }
    }

    method accionFinalDialogo(){
        self.esTiempoDeDialogo(false)
       self.hacerLoQueIndicaMiDialogo()

    }

    method hacerLoQueIndicaMiDialogo(){
        dialogo.bloque().apply(dialogo.npcDialogo(),self)
    }
}

class Dialogo{

    const property npcDialogo = null
    const property dialogoEscenario = []
    var property conversadorActual = protagonista
    const property bloque = {}

    method actualizarADialogoSiguiente(){
        dialogoEscenario.remove(self.dialogoActual())
        self.cambiarConversador()
    }

    method esUltimoDialogo(){
        return dialogoEscenario.isEmpty()
    }

    method decirDialogo(){
         game.say(self.conversadorActual(), self.dialogoActual())
             self.actualizarADialogoSiguiente()
    }

    method dialogoActual() = dialogoEscenario.first()

    method cambiarConversador(){
        if (self.esElTurnoDelProta()){ 
            self.conversadorActual(protagonista) 
        } else { 
            self.conversadorActual(npcDialogo) 
        }
    }

    method esElTurnoDelProta(){
        return dialogoEscenario.size().even()
    }
  
}

// DIALOGOS:

const dialogoEnCabaña  = new Dialogo(npcDialogo = guardabosques, dialogoEscenario = dialogoCabaña, bloque = accionCabaña1)

const dialogoEnCabaña2 = new Dialogo(npcDialogo = guardabosques, dialogoEscenario = dialogoCabaña2, bloque = accionCabaña2)

const  dialogoEscenarioInicial = new Dialogo(npcDialogo = amiga, dialogoEscenario = dialogoAmiga, bloque = accionAmiga)

// GUION DE DIALOGOS:

const dialogoCabaña  = ["Hola, ¿cómo va?", "Buenas Juan, ¿cómo va el lugar?", "Excelente, me preguntaba si tendría algo de leña", "Claro"]

const dialogoCabaña2 = ["¡¡¡AUXILIOO!!!", "¿Qué paso Juan?", "Esta lleno de lobos, mataron a mi amiga", "Mierda, no pensé que se acercarían", "¿Qué hago ahora?", "Tranquilo, vamos al granero", "¿Qué hay ahi?", "Tengo... armas"]

const dialogoAmiga   = ["¿Dónde quedaba la cabaña?", "Al Norte y después a la derecha", "Dale, ahí vengo", "Dale, te espero"]

// BLOQUES FINAL DIALOGO:

const accionAmiga   = {a,g => game.say(a,"Adiosss"); g.dialogo(dialogoEnCabaña); game.addVisual(puertaNorte);}

const accionCabaña1 = {gu,g => game.addVisual(leña); game.say(gu,"Agarrá la que está en la chimenea"); g.dialogo(dialogoEnCabaña2)}

const accionCabaña2 = {gu,g => game.addVisual(puertaEntradaCabaña); game.say(gu,"Vamos ya mismo hacia allá")}

// ################# DIALOGOS EN ESCENARIO TEST #################

const dialogoTEST          = ["Hola de nuevo", "Ya habíamos hablado", "Enloquecí, ¿no?", "Sí, andate"]
const dialogoEscenarioTest = [amiga, dialogoTEST]
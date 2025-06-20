import diapositivasManager.*
import enemigos.*
import protagonista.*
import puertas.*
import visualesExtra.*

object gestorDeDialogo{
    var property esTiempoDeDialogo = false

    var property dialogo = dialogoEscenarioInicial
  
    method interactuarNPC(){
        if (esTiempoDeDialogo){
            dialogo.conversar()
        }
    }     
}

class Dialogo{

    const miGestor= gestorDeDialogo
    const prota = protagonista
    const property npcDialogo 
    const property dialogoEscenario
    var property conversadorActual = protagonista
    const bloque ={}

    method conversar(){
        if(prota.estaAlLadoDelNPC(npcDialogo)){
           self.gestionarDialogo()
                
        }
    }

    method gestionarDialogo(){
        if(not self.esUltimoDialogo()){
            self.decirDialogo()
            self.cambiarConversador()
        }
        else{ self.accionFinalDialogo()}
    }

    method actualizarADialogoSiguiente(){dialogoEscenario.remove(dialogoEscenario.first())}

    method esUltimoDialogo() = dialogoEscenario.isEmpty()

    method decirDialogo(){
         game.say(self.conversadorActual(), dialogoEscenario.first())
             self.actualizarADialogoSiguiente()
    }


    method cambiarConversador(){
        if (self.esElTurnoDelProta()){ 
            self.conversadorActual(protagonista) 
        } else { 
            self.conversadorActual(npcDialogo) 
        }
    }

    method esElTurnoDelProta() = dialogoEscenario.size().even()

    method accionFinalDialogo(){
        miGestor.esTiempoDeDialogo(false)
        
        bloque.apply(npcDialogo,miGestor)
    }
    

}

//DIALOGOS
const dialogoEnCabaña  = new Dialogo(npcDialogo=guardabosques,dialogoEscenario=dialogoCabaña,bloque=accionCabaña1)

const dialogoEnCabaña2 = new Dialogo(npcDialogo=guardabosques,dialogoEscenario=dialogoCabaña2,bloque=accionCabaña2)

const  dialogoEscenarioInicial = new Dialogo(npcDialogo=amiga,dialogoEscenario=dialogoAmiga,bloque=accionAmiga)

//GUION DE DIALOGOS

const dialogoCabaña    = ["Hola, ¿cómo va?", "Buenas Juan, ¿cómo va el lugar?", "Excelente, me preguntaba si tendría algo de leña", "Claro"]

const dialogoCabaña2   = ["¡¡¡AUXILIOO!!!", "¿Qué paso chango?", "Esta lleno de lobos, mataron a mi amiga", "Mierda, no pensé que se acercarían", "¿Qué hago ahora?", "Tranquilo, vamos al granero", "¿Qué hay ahi?", "Tengo... armas"]

const dialogoAmiga = ["¿Dónde quedaba la cabaña?", "Al Norte y después a la derecha", "Dale, ahí vengo", "Dale, te espero"]

//BLOQUES FINAL DIALOGO
const accionAmiga = {a,g => game.say(a,"Adiosss");g.dialogo(dialogoEnCabaña);game.addVisual(puertaNorte);}

const accionCabaña1 = {gu,g => game.addVisual(leña);game.say(gu,"Toma la de la chimenea");g.dialogo(dialogoEnCabaña2)}

const accionCabaña2 = {gu,g => game.addVisual(puertaEntradaCabaña);game.say(gu,"Vamos ya mismo hacia alla")}
    




// ################# DIALOGOS EN ESCENARIO TEST #################
const dialogoTEST          = ["Hola de nuevo", "Ya habíamos hablado", "Enloquecí, no?", "Sí, andate"]
const dialogoEscenarioTest = [amiga, dialogoTEST]
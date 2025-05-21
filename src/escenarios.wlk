import wollok.game.*
import protagonista.*
import videojuego.*
import enemigos.*
import puertas.*
import direccion.*
import dialogos.*
import elementos.*
import escenarioManager.*
import escenarios_mapas.*
import visualesDiapositivas.*

//################ PUERTAS PARA TODO EL JUEGO ###########################

 const puertaNorte = new PuertaAbierta (image="puerta.png", position = norte.ubicacion(),irHacia=escenarioInicial)    
 const puertaOeste = new PuertaAbierta (image="puerta.png", position = oeste.ubicacion(),irHacia=escenarioInicial )
 const puertaEste  = new PuertaAbierta (image="puerta.png", position = este.ubicacion() ,irHacia=escenarioInicial )
 const puertaSur   = new PuertaAbierta (image="puerta.png", position = sur.ubicacion()  ,irHacia=escenarioInicial )
  
const puertaNorteCerrada = new PuertaCerrada(image="puerta.png",position=sur.ubicacion(), mensaje="Esta cerrada por ahora",irHacia=escenarioInicial)
const puertaOesteCerrada = new PuertaCerrada(image="puerta.png",position=oeste.ubicacion(), mensaje="Esta cerrada por ahora",irHacia=escenarioInicial)
const puertaEsteCerrada = new PuertaCerrada (image="puerta.png",position=este.ubicacion(), mensaje="Esta cerrada por ahora",irHacia=escenarioInicial)
const puertaSurCerrada = new PuertaCerrada  (image="puerta.png",position =sur.ubicacion(), mensaje="Esta cerrada por ahora",irHacia=escenarioInicial)


//############################## DIAPOSITIVAS PARA INICIO JUEGO
 /*   const d0 = new Diapositiva(image="diapositiva1.png")
    const d1 = new Diapositiva(image="diapositiva2.png")
    const d2 = new Diapositiva(image="diapositiva3.png")
    const d3 = new Diapositiva(image="diapositiva4.png")*/
//##############################


//############### ESCENARIOS PARA TODO EL JUEGO #########################
/*
object escenarioPrologo inherits Escenario(fondoEscenario="",mapa=[],visualesEnEscena=[d0,d1,d2,d3],ost=game.sound("inicio_v1.mp3")){
    const vs = videojuego
    
    const numDiapositivas = 4
    method numDiapositivas() =numDiapositivas
    
    override method puestaEnEscena(){
       ost.shouldLoop(true)
       ost.play()
       game.addVisual(d0)
       visualesEnEscena.remove(d0)
    }

    method cambiarDiapositiva(){
        game.addVisual(visualesEnEscena.first())
        visualesEnEscena.remove(visualesEnEscena.first())
        vs.numDiapositiva(vs.numDiapositiva()+1)
        
    }
   
    
    
    override method limpiar(){
        ost.stop()
        game.removeVisual(d0)
        game.removeVisual(d1)
        game.removeVisual(d2)
        game.removeVisual(d3)


        videojuego.cambiarEscenario(escenarioInicial)
    }
}
*/
object inicioJuego inherits Escenario(fondoEscenario="inicio-v1.png",mapa=mapa_inicioJuego,visualesEnEscena=[],ost=game.sound("inicio_v1.mp3")){

    override method puestaEnEscena(){
         ost.shouldLoop(true)
         ost.play()
         self.dibujarFondo()
         self.dibujarTablero()
    }
    override method limpiar(){
        ost.stop()
        game.removeVisual(fondo)
       
        //videojuego.cambiarEscenario(escenarioPrologo)
        
    }
}
   

object escenarioInicial  inherits Escenario(fondoEscenario="fondo-escenario-inicial.png",mapa=mapa_escenarioInicial,
                                             visualesEnEscena = [amiga,carpa,fogata,puertaNorte,protagonista],ost=game.sound("musica-escenarioInicial-v1.mp3" ) ){

    //##################################DIALOGO CON LOS NPC ###################################
    // solo usar si hay en el escenario un npc con el que interactuar
    //Esto a fututo re refactoriza
    const npc = amiga 
    const dialogoNPC = amigaConversacion.inicializar()
    const ultimoDialogo = amigaConversacion.dialogoFinal()

     //#######################################################################################
    
    override method configurarPuertas(){
        puertaNorte.irHacia(escenarioTEST)
    }

    

    // ######################## CONVERSACION #################
    override method configurarConversacion(){
        protagonista.npcActual(npc)
        protagonista.conversacionNPC(dialogoNPC)
        protagonista.codUltimoDialogo(ultimoDialogo)
        
    }
    

} 

object escenarioBifurcacion{}

object escenarioGalpon{}

object escenarioEntrarACabaña{}


// #################################
// implementar a gusto y usar este escenario para 
// testear a futuro las funcionalidades
object escenarioTEST{}
// #################################








// VERSION OBSOLETA: No borrar de momento
/*
     //##################################DIALOGO CON LOS NPC ###################################
    // solo usar si hay en el escenario un npc con el que interactuar
    const npc = amiga 
    const dialogoNPC = amigaConversacion.inicializar()
    const ultimoDialogo = amigaConversacion.dialogoFinal()

     //#######################################################################################
    const pj = protagonista

    const puertaNorte = new PuertaAbierta (image = "puerta.png", position = norte.ubicacion(), irHacia = escenarioBifurcacion)

    const visualesEnEscena = [amiga,fogata, carpa,puertaNorte,pj]

    

    method puestaEnEscena(){
        
        
        self.configurarConversacion()  // SI HAY UN NPC CON EL QUE DIALOGAR AGREGAR ESTO EN PUESTA EN ESCENA DEL ESCENARIO  
        
        self.agregarVisuales()
        

        game.onCollideDo(pj, {objeto => objeto.interaccion()})
        
            game.onTick...en caso de que hagan falta eventos
        


        //############################################ DIALOGOS ###############################################
        // SOLO USAR SI HAY UN NPC EN EL ESCENARIO CON EL QUE INTERACTUAR

        keyboard.f().onPressDo({pj.interactuarNPC()})

        //#####################################################################################################
    }
   

    method agregarVisuales(){
        visualesEnEscena.forEach({visual => game.addVisual(visual)})
        
    }

    method configurarConversacion(){
        pj.npcActual(npc)
        pj.conversacionNPC(dialogoNPC)
        pj.codUltimoDialogo(ultimoDialogo)
    }


    method limpiar(){
        visualesEnEscena.forEach({visual => game.removeVisual(visual)})
        game.removeVisual(pj)

        
           // game.removeTickEvent(event)..en caso de que haya eventos en los escenarios
        
    }

    
    
}*/

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



object inicioJuego inherits Escenario(fondoEscenario="inicio-v2.png",
                                      mapa=mapa_inicioJuego,
                                      visualesEnEscena=[],
                                      ost=game.sound("inicio_v1.mp3")){

    override method puestaEnEscena(){
         ost.shouldLoop(true)
         ost.play()
         self.dibujarFondo()
         //self.dibujarTablero()
    }
    override method limpiar(){
        ost.stop()
        game.removeVisual(fondo)
       
        
        
    }
}
   

object escenarioInicial  inherits Escenario(fondoEscenario="fondo-escenario-inicial.png",
                                            mapa=mapa_escenarioInicial,
                                            visualesEnEscena = [amiga,carpa,fogata,puertaNorte,protagonista],
                                            ost=game.sound("musica-escenarioInicial-v1.mp3" ) ){

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
object escenarioTEST inherits Escenario(mapa=mapa_escenarioTest,
                                        fondoEscenario="fondo-escenarioTEST.png",
                                        visualesEnEscena=[carpa,amiga,protagonista,puertaOeste],
                                        ost=game.sound("musica-escenarioInicial.mp3")){

    override method puestaEnEscena(){
        ost.shouldLoop(true)
         ost.play()
         self.dibujarFondo()
         self.configurarPuertas()
         self.dibujarTablero()
         self.agregarVisualesEscena()
    }

    override method configurarPuertas(){
        puertaOeste.irHacia(escenarioInicial)
    }

}
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



import wollok.game.*
import protagonista.*
import videojuego.*
import enemigos.*
import puertas.*
import direccion.*
import dialogos.*
import elementos.*
import escenarioManager.*


object escenarioInicial  { // VERSION OBSOLETA
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
}
object escenarioBifurcacion{}
object escenarioGalpon{}
object escenarioEntrarACabaña{}
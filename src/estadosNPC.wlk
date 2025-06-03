import protagonista.*
import visualesExtra.*
import guardabosques.*

/*
    El protagonista inicia el juego desarmado y solo cuando interactua con el hacha pasa a estar armado el resto del juego hasta 
    el final
*/
object desarmadoProtagonista{
    method actual() = "prota-desarmado-"

    method ataque(){}
}
object armadoProtagonista{

    const pj = protagonista
    method actual() = "prota-armado-"
    const modoAtaque = new HachazoCruz(atacante=protagonista)
     method ataque(){

        const imagenActual = pj.image()
            game.removeVisual(pj)
            pj.image("ataque-prota.png")   
            game.addVisual(pj) 
           
            modoAtaque.ataqueEnCruz()
            game.schedule(200,{game.removeVisual(pj);pj.image(imagenActual);game.addVisual(pj)})
        
     } 
            
}

object desarmadoGuardabosques{
    
     method actual()= ""

    method ataque(){}
}
object armadoGuardabosques{  //IMPLEMENTAR LUEGO
    const pj = guardabosques
    method actual() = "guardabosques-armado-" // IMPLEMENTAR LUEGO
    const modoAtaque = new HachazoEnLugar(atacante=guardabosques)
     method ataque(){
        const imagenActual = pj.image()
        pj.image("ataque-guardabosques.png")   //implementar luego
            game.addVisual(pj) 
            modoAtaque.ataqueEnLugar()
           
            game.schedule(200,{game.removeVisual(pj);pj.image(imagenActual);game.addVisual(pj)})
        
    }

}

class HachazoCruz{
    /*
        FUNCIONAMIENTO DEL ATAQUE EN CRUZ:
        atacarEnPosiciones(posiciones) : dada una coleccion de posiciones(celdas) ataca a los objetos en esas posiciones
        atacarObjetos(objetos) : dada una coleccion de objetos de una posicion(celda) ataca a esos objetos
        objetosEnPosicionAtacada(pos) : dada una posicion, retorna una lista con todos los objetos en esa posicion
        posicionesAtacar() : retorna las posiciones donde se atacara el cruz a partir de la posicion del personaje
        

    */
 const atacante 

 
    method ataqueEnCruz(){
        self.atacarEnPosiciones(self.posicionesAAtacar() )
    }

    method atacarEnPosiciones(coleccionPosiciones){
        coleccionPosiciones.forEach({pos => self.atacarObjetos(self.objetosEnPosicionAtacada(pos))})
    }

    method atacarObjetos(coleccionObjetos){ 
        coleccionObjetos.forEach({obj => obj.atacado()})
    }
    method objetosEnPosicionAtacada(posicion) = game.getObjectsIn(posicion) // coleccion

    
    method posicionesAAtacar() = [atacante.miCeldaAbajo(),
                                  atacante.miCeldaArriba(),
                                  atacante.miCeldaIzquierda(),
                                  atacante.miCeldaDerecha()]


}


    
class HachazoEnLugar inherits HachazoCruz{
     method ataqueEnLugar(){
        self.atacarObjetos(self.objetosEnPosicionAtacada(atacante.position()))
    }      
}
                                     
    
   





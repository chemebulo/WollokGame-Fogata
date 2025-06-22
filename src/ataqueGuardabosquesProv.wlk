import protagonista.*
import enemigos.*
import npcMovimiento.*
import gestores.*
import direccion.*
import visualesExtra.*
import npcEstados.*

/*
    AVISO!!!
    *este archiv es provisorio, quizas se mueva a estadosNPC pero se recomienda que se mantenga aqui de momento
   * El gestorDeDirecciones tiene metodos para indicarle a la bala hacia donde disparar.

   *La bala vive hasta que interactue con un objeto o llegue al fin del escenario(rocas)
   *La bala tambien daña a los lobos
   *La baja jamas ataca al guardabosques

   IMPORTANTE: El escenario entero debe tener al borde rocas para culminar su recorrido si 
              no interactua con ningun visual.Caso contrario la bala continua viviendo fuera del
              escenario sin morir y se acumularian visuales, malgastando recursos
              


*/
class ArmadoEscopeta inherits Armado(pj=guardabosques,
                                     modoAtaque= new Escopetazo(tirador=guardabosques,enemigo=protagonista),
                                     imagenTemporal="guardabosques-dispara.png"){

    // va a disparar en todo momento, no me importa donde este el prota
    override method puedeAtacarAlEnemigo() = true 
}

class Escopetazo{
  
    const gestorDireccionBala = gestorDeDirecciones
    const tirador 
    const enemigo 
    
    method posTirador() = tirador.position()

    method posEnemigo() = enemigo.position()

    method ataqueArma() {
        const miPosicion = self.posTirador()
        const direccion = self.direccionDisparo(miPosicion)
        const bala = new Bala(dir=direccion,position=miPosicion)
        game.addVisual(self) 
        bala.dispararHacia(direccion)
    }
    

    method direccionDisparo(miPos)= self.direccionADisparar(self.posEnemigo(),miPos)
    
    method direccionADisparar(posEnemigo,posTirador){
            return gestorDireccionBala.direccionDeBala(posEnemigo,posTirador)
        }
            
}

    

class Bala inherits VisualAtravasable{

    const dir
    const gestorColision = gestorDeColisiones
    const velocidadBala = 200  
    var sigoSinInteractuar= true
    /*
    Explicacion de @variable: sigoSinInteractuar: 
        Cuando la bala interactua con un objeto, esta se borra del escenario,
        Sin embargo, el metodo recursivo que termina cuando llega al final del escenario sigue activo 
        hasta el final del escenario. Esto es un uso extra de recursos Debido a esto:
            *Al interactuar con un objeto la variable sigoSinInteractuar cambia su valor a false
            *el metodo recursivo evalua todo el tiempo sigoSinInteractuar para que cuando la bala 
             impacte con un objeto tambien culmine el metodo recursivo
       
    */
    
    override method image() = "bala-"+dir.toString()+".png"
    
    method dispararHacia(direccion){
        /*
            PROPOSITO: La bala partiendo de la posicion del guardabosquesse mueve una vez y luego se invoca 
            a un metodo de orden recursivo que finaliza cuando:
                            *la bala impacta con un visual o el borde del escenario,representado con rocas
        */                  
        
        self.seguirHacia(direccion)                                   
        self.gestionarTrayectoria(direccion)
     }

    method gestionarTrayectoria(direccion){
    /*
        Proposito: la bala se mueve recursivamente hasta que se den las condiciones
        para terminar su recorrido
    */
        
         if(sigoSinInteractuar and self.puedeSeguirTrayectoria()) {
            self.continuarTrayectoria(direccion)
             }
        else {self.muerteBala()}
    }

    method continuarTrayectoria(direccion){

           game.schedule(velocidadBala, {self.seguirHacia(direccion)
                                self.gestionarTrayectoria(direccion)
                                })
}
    
    
    method muerteBala(){
      
        game.removeVisual(self)
    }

    override method interaccion(){
        self.objetosDondePenetre().forEach({o => o.atacadoPor(self)})
        self.muerteBala()
        sigoSinInteractuar= false 
    }

    method objetosDondePenetre() = game.getObjectsIn(self.position()).copyWithout(guardabosques)

    // #########################################################
    // #########################################################


    method daño() = 10

    method seguirHacia(direccion){ 
        // es codigo repetido pero la bala no necesita cambiar su imagen,
        //por ende no uso el gestorDeMovimiento.Se puede refactorizar agregando 
        //un metodo al gestor que no cambie imagen solo para la bala y mandar mensaje directamente
        self.position(direccion.siguientePosicion(self.position()))
    }

    method puedeSeguirTrayectoria(){
        
        return (gestorColision.estaDentroDelTablero(self.position()))
    }

    method cambiarImagen(imagen){
        // la bala nunca cambia su imagen pero es necesario este metodo por polimorfismo
    }

  override   method atacadoPor(visual){}
  //necesario por polimorfismo porque podria 
}

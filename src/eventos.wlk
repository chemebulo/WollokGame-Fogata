import protagonista.*
import enemigos.*

class EventoMultiple{
    /*
        ATRIBUTOS:
            
        @variable visualesEvento : lista de los visuales que realizaran el evento,deben estar en la lista de visualesEnEscena de escenarios
        
        @abstractMethod  tiempo():   el tiempo en milisegundos de loop del evento
        @abstractMethod nombreEvento(): nombre que requiere el evento 
        @abstractMethod orden(visual): mensaje de orden que entienden los visuales que participan del evento

        @method finalizarEventos() : metodo que requiere el escenario para finalizar eventos
        @method iniciarEventos() : metodo que requiere el escenario para iniciar Eventos      

        Como crear evento Multiple: 
        crear objeto que herede de Evento con una lista de los visuales que participaran en el evento,
        implementar tiempo() , nombreEvento()

        Como implementar orden(visual): 
            override method orden(visual){ 
                    visual.metodoPolimorficoQueEntiendenLosVisuales()
            } 

        INV.REP: La orden implementada en orden(visual) es un metodo polimorfico para todos los visuales que participan el evento
                 se espera que todos los visuales sepan cumplir la misma orden
            
    */
    const visualesEvento

    method nombreEvento() 
    
    method tiempo() 

    method finalizarEvento(){
        game.removeTickEvent(self.nombreEvento())
    }
 
    method iniciarEvento(){
        game.onTick(self.tiempo(), self.nombreEvento(), {visualesEvento.forEach({v => self.orden(v)})})
    }
      
    method orden(visual){}
}

class EventoLobo{ // solo funciona para lobos que se agregan directamente a la matriz
    const nombre       = self.toString()
    const tiempoRandom = 1000.randomUpTo(2000)
    const loboEv

    method nombre(){
        return nombre
    }

    method iniciarEvento(){
        game.onTick(tiempoRandom,nombre,{loboEv.perseguirEnemigo()})
    }
}

class EventoUnico inherits EventoMultiple(visualesEvento=[]){ 
    /*
        Evento para un solo visual,
        en la instancia implementar tiempo(), nombreEvento() y ordenUnica(sujeto)
    */
    const sujetoUnico

    override method iniciarEvento(){
        game.onTick(self.tiempo(), self.nombreEvento(), {self.ordenUnica(sujetoUnico)})
    }

    method ordenUnica(visual)
}

//######################################################
        //EVENTOS PARA PERSECUCION DE LOBO
//######################################################

object ataqueGuardabosques inherits EventoMultiple(visualesEvento=[guardabosques]){
    override method tiempo()= 1000

    override method nombreEvento(){
        return "Guardabosques persigue al protagonista"
    }
 
    override method orden(visual){
        visual.perseguirEnemigo()
    }
}

//######################################################
        //EVENTOS UNICOS
//######################################################

object personajeHabla inherits EventoUnico(sujetoUnico=protagonista){

    override method tiempo(){
        return 800
    }
    override method nombreEvento(){
        return "Hablar"
    }
 
    override method ordenUnica(visual){
        game.say(visual,"Hola, estoy hablando por un evento")
    }
}

object recojerLeña inherits EventoUnico(sujetoUnico= guardabosques){

    override method tiempo(){
        return 800
    }
    override method nombreEvento(){
        return "Recojer leña"
    }

    override method ordenUnica(visual){
        visual.comprobarDialogo()
    }
}
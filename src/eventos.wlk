import enemigos.*
import protagonista.*

class Evento{
    /*
        ATRIBUTOS:
            *visualesEvento : lista de los visuales que realizaran el evento,deben estar en la lista de visualesEnEscena de escenarios
            *tiempo : el tiempo en milisegundos de loop del evento
           
            *bloque: codigo que ejecutan todos los visualesEnEscena (implementar en las herencia,ver ejemplo en PersecucionLobo),
                     
                     
        METODOS:
            finalizarEventos() : metodo que requiere el escenario para finalizar eventos
            iniciarEventos() : metodo que requiere el escenario para iniciar Eventos      

        INSTANCIAS DE EVENTOS: la instancia creada debe pasarse a la lista de eventos en el configuradorEscenarios,
                               el visual o visuales que realizan el evento deben encontrarse 
                               en el escenario(en visualesEnEscena del configuradorEscenarios)    
        REQUERIMIENTOS: lo unico que hay que hacer es crear la clase que herede de Evento e implementar el bloque(), luego al crear
                        la instancia pasar la lista de visuales y el tiempo,(ejemplo. persecucionLoboAgresivo)                                           
        */
    
    const visualesEvento
    const nombresGenericos = ["evento1","evento2","evento3","evento4","evento5","evento6","evento7"]
    const nombresEventos = #{}
    const tiempo 
    method tiempo() = tiempo
    method bloque(visual)
   
    method finalizarEventos(){
        nombresEventos.forEach({nombre => game.removeTickEvent(nombre)})
    }
 
  
    method iniciarEventos(){
        visualesEvento.forEach({visual => self.bloque(visual)})
        nombresGenericos.forEach({n=> nombresGenericos.remove(n)})
    }

     method dameNombreGenerico(){
        const nombreGenerico = nombresGenericos.first()
        nombresEventos.add(nombreGenerico)
         nombresGenericos.remove(nombresGenericos.first())
         return nombreGenerico
     }

     method reponer(set){
        set.forEach({elem => nombresGenericos.add(elem)})

     }
}


//######################################################
        //EVENTOS PARA PERSECUCION DE LOBO
//######################################################

class PersecucionLobo inherits Evento{
     /*
        INV.REP: El o los lobos que realizan el evento y el o los lobos que estan 
                 en la lista de VisualesEnEscena del escenario son los mismos.
    */          
      
    override method bloque(lobo){
        game.onTick(self.tiempo(),self.dameNombreGenerico(),{lobo.perseguirAPresa()})
    }
    
}  

   
//## Evento para el lobo
const persecucionLoboAgresivo = new PersecucionLobo(
                                     visualesEvento = [loboAgresivo],
                                      tiempo = 800
                                      )
                                      




// ######CODIGO VIEJO, NO BORRAR #####################
//######################################################
        //EVENTOS PARA HABLAR
//######################################################
/*
class EventoHablar inherits Evento(bloque ={game.say(self.visualEnEvento(),self.mensaje())}){
    
        
    
    const mensaje = ""
    method mensaje() = mensaje
}

const ejemploEvento = new EventoHablar(
                                 visualQueRealizaEvento = protagonista,
                                 nombreEvento="Hablar",
                                 tiempo=1000,
                                 mensaje = "Estoy hablando a travez de un evento"
)


*/
/*
class Evento{
    
        ATRIBUTOS:
            *visualQueRealizaEvento : el visual que va a realizar el codigo que se ejecuta en el closure
            *tiempo : el tiempo en milisegundos de loop del evento
            *nombreEvento : string con el nombre del evento
            *bloque: codigo que ejecuta el visualQueRealizaEvento(implementar en la herencia,ver ejemplo en PersecucionLobo),
                     
                     
        METODOS:
            nombreEvento() : nombre que requiere el escenario para finalizar eventos
            iniciarEvento() : metodo que requiere el escenario para iniciar Eventos      

        INSTANCIAS DE EVENTOS: la instancia creada debe pasarse a la lista de eventos en el configuradorEscenarios,
                               el visual o visuales que realizan el evento deben encontrarse 
                               en el escenario(en visualesEnEscena del configuradorEscenarios)                
        
    
    const visualQueRealizaEvento 
    const tiempo 
    const nombreEvento 
    const bloque  
    method nombreEvento() = nombreEvento
    method iniciarEvento(){
        game.onTick(tiempo,nombreEvento,bloque)
    }

    method visualEnEvento() = visualQueRealizaEvento  
}
//######################################################
        //EVENTOS PARA PERSECUCION DE LOBO
//######################################################

class PersecucionLobo inherits Evento(bloque = {self.visualEnEvento().perseguirAPresa()}){
    
        INV.REP: El lobo que realiza el evento y el lobo que esta en la lista de VisualesEnEscena del escenario son el mismo.
                
       
    
}  

   
//## Evento para el lobo
const persecucionLoboAgresivo = new PersecucionLobo(
                                     visualQueRealizaEvento=loboAgresivo,
                                      nombreEvento= "Lobo persigue al personaje", 
                                      tiempo = 800
                                      )

const persecucionLoboAgresivo2 = new PersecucionLobo(
                                     visualQueRealizaEvento=loboAgresivo2,
                                      nombreEvento= "Lobo 2 persigue al personaje", 
                                      tiempo = 800
                                      )
const persecucionLoboAgresivo3 = new PersecucionLobo(
                                     visualQueRealizaEvento=loboAgresivo3,
                                      nombreEvento= "Lobo 3 persigue al personaje", 
                                      tiempo = 800
                                      )


*/                                      
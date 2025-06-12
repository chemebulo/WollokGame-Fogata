import protagonista.*
import enemigos.*
import visualesExtra.*
import escenarios.*
import gestores.*
import npcEstados.*
import eventos.*

/*
    USAR ESTAS MEDIDAS PARA TODOS LOS ESCENARIOS:
        * 9 listas     -> Formando el alto del escenario.
        * 13 elementos -> Formando el ancho del escenario.

    IMPORTANTE: 
        * Para crear:
	        - Las puertas Norte, Sur, Este, Oeste (con ubicaciones),
            - Las puertas cerradas Norte, Sur, Este, Oeste (con mensajes),
            - Las puertas genéricas.
        
	      No es necesario crear objetos de tipo Elemento (véase escenarioManager.wlk) para dibujarlas,
          solo se agregaran como visuales en los objetos "escenario" con el método agregarVisualesEscena().

          Luego de dibujar el escenario reemplazar la N con _ si dibujamos todas las puertas. Si por ejemplo un 
          escenario tiene solo puertas Oeste y Este, se puede dibujar algo en las N que simbolizan Norte y Sur.
          Es importante sobreescribir el método configurarPuertas() con los requerimientos del escenario actual.

    [

        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ]

    ].reverse() 
    
    nombres de variables recomendados = mapa_nombreEscenario
*/

//################# ELEMENTOS PARA CONSTRUIR EL MAPA ###################

// Referencias a los distintos visuales para setter sus posiciones a la matriz o instanciarlos.
class Elemento{ 
    const visual = null

    method construir(position){
        visual.position(position)
    }
}

// #####################################################################

object _ inherits Elemento{
    override method construir(position){} // Por las dudas.
}


// #####################################################################

object z inherits Elemento(visual=protagonista){} 


// #####################################################################

object f inherits Elemento(visual=fogata){}


// #####################################################################

object c inherits Elemento(visual=carpa){}


// #####################################################################

object a inherits Elemento(visual=amiga){}
   

// #####################################################################

object o{
    method construir(posicion){
        const temp = new Obstaculo(position = posicion);
        game.addVisual(temp);
        gestorDeObstaculos.agregar(temp)
    }
}

// #####################################################################
 //                    ENEMIGOS
// #####################################################################

object la {  
    method construir(posicion){
        const loboTemp = new Lobo(position=posicion);
        const eventoTemp = new EventoLobo(loboEv = loboTemp)
        game.addVisual(loboTemp);
        gestorDeLobos.agregarLobos(loboTemp,eventoTemp);
        eventoTemp.iniciarEvento()
    }
}

object lp inherits Elemento(visual = new Lobo(comportamiento = pasivo)){}

// #####################################################################

object g inherits Elemento(visual=guardabosques){ // Guardabosques -> No implementado, no usar.
    
}

object ca inherits Elemento(visual= cabaña){}

object le inherits Elemento(visual=leña){}

object h inherits Elemento(visual=hacha){}

// ################################################################################
// PUERTAS 
object po inherits Elemento(visual=puertaOeste){}

object pn inherits Elemento(visual=puertaNorte){}

object pe inherits Elemento(visual=puertaEste){}

object ps inherits Elemento(visual=puertaSur){}

object pec inherits Elemento(visual= puertaEntradaCabaña){}
//###########################################################

const mapa_inicioJuego =
    [
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_]
     
    ].reverse()

// ################################################################################

const mapa_escenarioInicial = 
    [
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,o,o,o,o,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,a,z,_,f,c,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_]
     
     ].reverse()

// ################################################################################

const mapa_escenarioBifurcacion =
    [
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,la,_,_,_,_,_,la,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,z,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_]
     
    ].reverse()

// ################################################################################



const mapa_entradaCabaña = 
[
    
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , la , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ ,z  , _ , _ , _ ,ca ,pec, _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , la , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ]

    ].reverse() 

const mapa_entradaCabaña_v2 = 
[
    
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [po , _ , _ , _ , _ , z , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ]

    ].reverse()     


const mapa_cabañaInicial = 
   [
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,le,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,pec,z,_,_,_,_,g,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_]
     
    ].reverse()    


const mapa_escenarioBifurcacion_v2 =     

    [

        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , o , o , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , o , o , _ , o , _ , _ , _ ],
        [ _ , _ ,la , _ , _ , _ , o , _ , _ , _ , _ , z , _ ],
        [ _ , _ , la , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , la , _ , _ , _ , o , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ]

    ].reverse() 

const mapa_escenarioTest =
    [
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,h,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,la,_,_,_,la,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,z,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_]
     
    ].reverse()




//######################## EXCLUSIVO PARA REALIZAR LOS TEST, NO TOCAR O AVISAR SI SE MODIFICA
    const mapa_TEST =
    [
        [_,_,_,_,_,_,pn,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [po,_,_,_,_,_,_,_,_,_,_,_,_],       
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [z,_,_,_,_,h,_,_,_,_,_,_,_]
     
    ].reverse()
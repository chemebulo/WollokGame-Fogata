import protagonista.*
import gestores.*
import visualesExtra.*
import enemigos.*
import escenariosMapas.*
import dialogosManager.* 
import eventos.*
import diapositivasManager.*
import puertas.*
import npcEstados.*

// #############################################################################################################################

class Escenario{ 
    var property eventos           = []
    var property mapa              = mapa_comun
    var property fondoEscenario    = ""
    var property visualesEnEscena  = []
    var property ost               = game.sound("")
    var property confgActual       = {} 
    var property confgEscSiguiente = {}
    
    const gestorFondo           = gestorFondoEscenario
    const gestorEvento          = gestorDeEventos
    const gestorObstaculos      = gestorDeObstaculos
    const gestorLobos           = gestorDeLobos
    const gestorListasEscenario = gestorDeListasEscenario
    
    method puestaEnEscena(){ 
        self.configurar()
        self.configurarEscenarioSiguiente()
        self.configurarSonido()
        gestorFondo.visualizarFondo(fondoEscenario)
        self.dibujarTablero()
        gestorListasEscenario.agregarVisualesEscena(self)
        gestorEvento.gestionarInicio(eventos)
    }

    method configurarSonido(){
        ost.volume(0.5)
        ost.shouldLoop(true)
        ost.play()
    }
    
    method dibujarTablero() {
         (0 .. game.width() - 1).forEach({x =>  
            (0 .. game.height() - 1).forEach( {y => 
                const constructor = mapa.get(y).get(x)
                constructor.construir(game.at(x, y))
            })
        })
    }

    method bajarVolumen(){
        ost.volume(0)
    }

    method configuradorTotal(confgAct,confgEscenarioSiguiente){
        self.confgActual(confgAct);
        self.confgEscSiguiente(confgEscenarioSiguiente) 
    }

    method configurar(){
        confgActual.apply(self)
    }
 
    method configurarEscenarioSiguiente(){
        confgEscSiguiente.apply()
    }
 
    method limpiar(){     
        gestorFondo.borrarFondo()
        ost.stop()
        gestorListasEscenario.limpiarListas(self)
        gestorEvento.gestionarFin(eventos);
        gestorObstaculos.limpiarObstaculos()
        gestorLobos.limpiarLobos()
        
    }
  
    method esAtravesable() = true

    method atacadoPor(visual){}

    method removerSiEsta(visual){
        if(game.hasVisual(visual)){
            game.removeVisual(visual)
        }
    }
} 


/* A PARTIR DE AQUI EL RESTO SON INSTANCIAS DE ESCENARIOS E INSTANCIAS DE LOS DOS CONFIGURADORES
    QUE REQUIEREN LOS ESCENARIOS Y LA MUSICA */

// #############################################################################################################################

// CONSTRUCTOR DE ESCENARIOS
object esc{
    method construir (confg_esc,confg_esc_sig,fondoEsc){
        return new Escenario(confgActual = confg_esc,
                             confgEscSiguiente = confg_esc_sig,
                             fondoEscenario = fondoEsc)
    }
}

// #############################################################################################################################
/*                                         ESCENARIOS PARA TODO EL JUEGO:
    TEMPLATE escenario:
    const nombre_escenario = esc.construir(@param,    //configuracion actual
                                           @param,    //configurador para el escenario siguiente:
                                                          *hacia que escenario iran las puertas
                                                          *si hay escenarios repetidos, un setter con nuevos 
                                                          configuradores
                                                        
                                           @param     // imagen de 1300px * 900 px
                                           )    
IMPORTANTE!!!
Cuando de un escenario se va a otro escenario que ya se visito (donde ocurre una etapa distinta del juego), 
se debe settear los dos primeros parametros al escenario al que se ira dentro del configuradorEscenarioSiguiente
del escenarioActual

TEMPLATE escenarioDiapositivas:
    const nombre_escenario = esc.construir(@param, //configurador implementado en confgEscenarios.wlk
                                            {}   , // no requiere configuradorEscenario siguiente
                                             @param     // imagen de 1300px * 900 px que es la primer diapositiva que se muestra
    )
    
*/

// ########################################### ESCENARIO: inicioJuego ###########################################

const inicio = esc.construir(inicioC_v1, {}, "inicio.png")

// ######################################### ESCENARIO: escenarioInicial #########################################

const fogata = esc.construir(fogataC_v1, fogataCES_v1, "fondo-escenario-inicial.png")

// ###################################### ESCENARIO: escenarioBifurcacion #######################################

const bifurcacion   = esc.construir(bifurcacionC_v1, bifurcacionCES_v1, "fondo-escenario-inicial.png")

const entradaCabaña = esc.construir(entradaCabañaC_v1, entradaCabañaCES_v1, "fondo-escenario-inicial.png" )

// ##################################### ESCENARIO: escenarioEntrarACabaña ######################################

const cabaña = esc.construir(cabañaC_v1, cabañaCES_v1, "cabaña.png")   

// ########################################## ESCENARIO: escenarioTEST ##########################################

const entradaCueva    = esc.construir(entradaCuevaC_v1, entradaCuevaCES_v1, "fondo-entrada-cueva.png")

const cueva           = esc.construir(cuevaC_v1, cuevaCES_v1,"fondo-cueva.png")

const escenarioTEST   = esc.construir(escenarioTestC_v1, escenarioTestCES_v1, "fondo-escenario-inicial.png")

const entradaGranero  = esc.construir(entradaGraneroC_v1, entradaGraneroCES_v1, "fondo-entrada-granero.png")

const granero         = esc.construir(graneroC_v1, graneroCES_v1, "fondo-granero.png")

const peleaFinal      = esc.construir(peleaFinalC_v1, peleaFinalCES_v1, "fondo-cueva.png") // Recordar borrar la puerta de salida

const estacionamiento = esc.construir(estacionamientoC_v1, {}, "fondo-escenario-final.png")

// ################################# ESCENARIOS EXCLUSIVOS PARA LAS DIAPOSITIVAS #################################

const diapoGranero     = esc.construir(diapoGraneroC_v1, {}, "diapo-granero-1.png") 

const diapoAmigaMuerta = esc.construir(diapoAmigaMuertaC_v1, {}, "diapo-amiga-muerta1.png")

const diapoPeleaFinal  = esc.construir(diapoPeleaFinalC_v1, {}, "diapo-pelea-final1.png")

// ###########################################################################################################
//                                      CONFIGURADORES DE ESCENARIOS
// ###########################################################################################################

/*
TEMPLATE CONFIGURADORES:
        
const nombreEscenarioC_v* = {e => e.visualesEnEscena();
                                    e.mapa();
                                    e.ost();
                                
                                    e.eventos()}  // Si no hay eventos borrar esta linea.

  

  IMPORTANTE: Si un escenario va a repetirse en distintos puntos del juego,
              los configuradores deben nombrarse al final con v1,v2,v3 para guiarse
              *tanto dialogos como eventos son LISTAS:
                  e.eventos(persecucionLobo)... MAL!!!
                  e.eventos([persecucionLobo]) ..BIEN!!!
*/

// ##########################################################################################################################

const inicioC_v1 = {e => e.ost(track_inicio)}

const fogataC_v1 = {e => gestorDeDialogo.esTiempoDeDialogo(true)
                         e.mapa(mapa_escenarioInicial_v1);
                         e.visualesEnEscena([amiga, carpa, fogataOBJ, protagonista]);
                         e.ost(track_fogata)}
                        

// ########################################## CONFIGURADORES ESCENARIO BIFURCACION ##########################################

const bifurcacionC_v1 = {e => game.removeVisual(puertaNorte)
                              e.mapa(mapa_escenarioBifurcacion_v1);
                              e.visualesEnEscena([puertaEste, protagonista]);
                              e.ost(track_fogata)}
      
const bifurcacionC_v2 = {e => e.mapa(mapa_escenarioBifurcacion_v2);
                              e.visualesEnEscena([protagonista, puertaOeste]);
                              e.ost(track_ataque_lobos);
                              e.eventos([hablarProta4])}

const bifurcacionC_v3 = {e => e.mapa(mapa_escenarioBifurcacion_v3);
                              e.visualesEnEscena([protagonista, puertaSur]);
                              e.ost(track_suspence);
                              e.eventos([hablarProta2])}

const bifurcacionC_v4 = {e => e.visualesEnEscena([protagonista, puertaEste]);
                              e.mapa(mapa_escenarioBifurcacion_v4);
                              e.ost(track_tramo_a_cabaña);
                              e.eventos([hablarProta])}

const bifurcacionC_v5 = {e => e.visualesEnEscena([protagonista, puertaOeste]);
                              e.mapa(mapa_escenarioBifurcacion_v5);
                              e.ost(track_ataque_lobos);
                              e.eventos([hablarProta7])}

const bifurcacionC_v6 = {e => e.mapa(mapa_escenarioBifurcacion_v6);
                              e.visualesEnEscena([protagonista, puertaNorte]);
                              e.ost(track_tramo_final)}          

// ############################################## CONFIGURADORES ENTRADA CABAÑA ##############################################

const entradaCabañaC_v1 = {e => e.mapa(mapa_entradaCabaña_v1);
                                e.visualesEnEscena([cabañaOBJ, protagonista, puertaEntradaCabaña]);
                                e.ost(track_fogata)}

const entradaCabañaC_v2 = {e => game.removeVisual(puertaEntradaCabaña)
                                e.mapa(mapa_entradaCabaña_v2);
                                e.visualesEnEscena([cabañaOBJ, protagonista, puertaOeste] );
                                e.ost(track_suspence);
                                e.eventos([escucharLobos])}

const entradaCabañaC_v3 = {e => e.mapa(mapa_entradaCabaña_v1);
                                e.visualesEnEscena([cabañaOBJ, protagonista, puertaEntradaCabaña]);
                                e.ost(track_tramo_a_cabaña)}

const entradaCabañaC_v4 = {e => game.removeVisual(puertaEntradaCabaña);
                                guardabosques.image("guardabosques-abajo.png");
                                e.mapa(mapa_EntradaCabaña_v3);
                                e.visualesEnEscena([cabañaOBJ, protagonista, puertaNorte, guardabosques]);
                                e.ost(track_suspence);
                                e.eventos([guardabosquesHabla])}

const entradaCabañaC_v5 = {e => e.mapa(mapa_EntradaCabaña_v4);
                                e.visualesEnEscena([cabañaOBJ, protagonista, puertaEntradaCabaña]);
                                e.ost(track_suspence)}

const entradaCabañaC_v6 = {e => game.removeVisual(puertaEntradaCabaña);
                                e.mapa(mapa_EntradaCabaña_v3);
                                e.visualesEnEscena([cabañaOBJ, protagonista, puertaOeste]);
                                e.ost(track_suspence)}

// ################################### CONFIGURADORES  PARA TODA LA SECUENCIA DEL  GRANERO ###################################

const entradaGraneroC_v1 = {e => e.mapa(mapa_entradaGranero_v1);
                                 e.visualesEnEscena([graneroOBJ, protagonista, guardabosques, puertaGranero]);
                                 e.ost(track_suspence);
                                 e.eventos([guardabosquesHabla2])}

const graneroC_v1 ={ e => e.mapa(mapa_peleaGranero);
                          e.visualesEnEscena([protagonista,hacha,loboEspecial,tridente, manopla]);
                          e.ost(track_pelea_granero)}

const entradaGraneroC_v2 = {e => game.removeVisual(puertaGranero);
                                 e.mapa(mapa_entradaGranero_v2)
                                 e.visualesEnEscena([graneroOBJ, protagonista, puertaSur]);
                                 e.ost(track_suspence);
                                 e.eventos([hablarProta3])}

// ######################################################### CABAÑA #########################################################

const  cabañaC_v1 = {e => gestorDeDialogo.esTiempoDeDialogo(true);
                          e.mapa(mapa_cabañaInicial_v1);
                          e.visualesEnEscena([guardabosques, protagonista]);
                          e.ost(track_cabaña)}

const cabañaC_v2 = {e => gestorDeDialogo.esTiempoDeDialogo(true);
                         e.mapa(mapa_cabañaInicial_v1);
                         e.visualesEnEscena([guardabosques, protagonista]);
                         e.ost(track_suspence)}
                       
const cabañaC_v3 = {e => e.mapa(mapa_cabañaInicial_v2);
                         e.visualesEnEscena([protagonista, nota]);
                         e.ost(track_suspence)}                      

// ####################################################### ZONA CUEVA #######################################################

const entradaCuevaC_v1 = {e => e.mapa(mapa_entradaCueva_v1);
                               e.visualesEnEscena([cuevaOBJ, protagonista, puertaEntradaCueva])
                               e.ost(track_ataque_lobos);
                               e.eventos([hablarProta5])}    

const entradaCuevaC_v2 = {e => e.mapa(mapa_entradaCueva_v2);
                               e.visualesEnEscena([cuevaOBJ, protagonista, puertaEste]);
                               e.ost(track_suspence)} 

const entradaCuevaC_v3 = {e => e.mapa(mapa_entradaCueva_v3);
                               e.visualesEnEscena([cuevaOBJ, protagonista, puertaEntradaCueva]);
                               e.ost(track_ataque_lobos)}  

const entradaCueva_v4 = {e => protagonista.estadoCombate(desarmadoProtagonista);
                              protagonista.image("prota-desarmado-abajo.png");
                              game.removeVisual(puertaEntradaCueva)
                              e.mapa(mapa_entradaCueva_v2);
                              e.visualesEnEscena([cuevaOBJ, protagonista, puertaEste]);
                              e.ost(track_tramo_final)}

const cuevaC_v1 = {e => e.mapa(mapa_cueva_v1);
                        e.visualesEnEscena([protagonista, puertaEntradaCueva]);
                        e.ost(track_cueva);
                        e.eventos([hablarProta6])}

const cuevaC_v2 = {e => e.mapa(mapa_cueva_v2);
                        e.visualesEnEscena([protagonista, puertaEntradaCueva]);
                        e.ost(track_cueva)}

const cuevaC_v3 = {e => e.mapa(mapa_cueva_v3);
                        e.visualesEnEscena([protagonista, puertaEntradaCueva]);
                        e.ost(track_cueva)}

const cuevaC_v4 = {e => e.mapa(mapa_cueva_v4);
                        e.visualesEnEscena([protagonista, puertaEntradaCueva]);
                        e.ost(track_cueva)}      
                                       
const cuevaC_v5 = {e => e.mapa(mapa_cueva_v5);
                        e.visualesEnEscena([protagonista, puertaEntradaCueva]);
                        e.ost(track_cueva)}  

// ###################################################### PELEA FINAL #######################################################

const peleaFinalC_v1 = {e => protagonista.estadoCombate(protagonista.estadoCombateElejido());      
                             guardabosques.cambiarAAtravesable() ;                  
                             guardabosques.estadoCombate(armadoGuardabosques);
                             e.mapa(mapa_FinalJuego)
                             e.visualesEnEscena([protagonista, guardabosques]);
                             e.ost(track_pelea_final);
                             e.eventos([ hablarProta9,ataqueGuardabosques,ataqueEscopetaGuardabosques])} 

// const peleaFinalC_v1 = {e => guardabosques.soyAtravesable(true) ;                   
//                              guardabosques.estadoCombate(armadoGuardabosques);
//                              e.mapa(mapa_FinalJuego)
//                              e.visualesEnEscena([protagonista, guardabosques]);
//                              e.ost(track_pelea_final);
//                              e.eventos([hablarProta9,ataqueGuardabosques, ataqueEscopetaGuardabosques])}

const estacionamientoC_v1 = {e => e.mapa(mapa_estacionamiento_v1);
                                  e.visualesEnEscena([protagonista, auto]);
                                  e.ost(track_tramo_final);
                                  e.eventos([hablarProta8])}

// ################################### CONFIGURADORES EXCLUSIVOS PARA ESCENARIOS CON DIAPOS ##################################

const diapoAmigaMuertaC_v1 = {e => gestorDeDiapositivas.esHoraDeDiapositiva(true);
                                   e.ost(track_amiga_muerta)}

const diapoPeleaFinalC_v1 = {e => protagonista.estadoCombate(desarmadoProtagonista);
                                  e.removerSiEsta(protagonista)
                                  gestorDeDiapositivas.esHoraDeDiapositiva(true);
                                  e.ost(track_guardabosques_cueva)}

const diapoGraneroC_v1 = {e => gestorDeDiapositivas.esHoraDeDiapositiva(true);
                               game.removeVisual(puertaGranero);
                               e.ost(traicion_granero)}

// DEJAR ABAJO DE TODO
const escenarioTestC_v1 = {e => e.mapa(mapa_escenarioTest);
                                e.visualesEnEscena([protagonista, hacha, cuevaOBJ]);
                                e.ost(track_win)}


// ###########################################################################################################
//                                 CONFIGURADORES DE ESCENARIOS SIGUIENTES
// ###########################################################################################################

// CONFIGURADOR DE ESCENARIOS SIGUIENTE: 
//    *tipo: bloque
//    En el bloque se debe escribir
//    el setter del irHacia de TODAS LAS PUERTAS del escenario actual 
//    si se vuelve a un escenario anterior...se deben settear tanto el confgEscSiguiente como el confgActual
//    si un escenario tiene dinstintos configuradores, respetar nomenclatura y escribir al final v1,v2,v3 
//
//  NOTAS: Los escenarios exclusivos para diapositivas no requieren un configurador de escenario siguiente
//
//  nomenclatura = escenarioCES_v*

const fogataCES_v1 = {puertaNorte.irHacia(bifurcacion)}

const bifurcacionCES_v1 = {puertaEste.irHacia(entradaCabaña)}

const bifurcacionCES_v2 = {puertaOeste.irHacia(entradaCueva)}

const entradaCabañaCES_v1 = {puertaEntradaCabaña.irHacia(cabaña)}

const entradaCabañaCES_v2 = {game.removeVisual(puertaEntradaCabaña); 
                             puertaOeste.irHacia(bifurcacion);
                             bifurcacion.configuradorTotal(bifurcacionC_v2, bifurcacionCES_v2)}
                                                
const cabañaCES_v1 = {puertaOeste.irHacia(entradaCabaña);
                      entradaCabaña.configuradorTotal(entradaCabañaC_v2, entradaCabañaCES_v2)}
                                               
const entradaCuevaCES_v1 = {puertaEntradaCueva.irHacia(cueva)}       

const cuevaCES_v1 = {puertaEntradaCueva.irHacia(cueva);
                     cueva.configuradorTotal(cuevaC_v2, cuevaCES_v2)}
                          
const cuevaCES_v2 = {puertaEntradaCueva.irHacia(cueva);
                     cueva.configuradorTotal(cuevaC_v3, cuevaCES_v3)}

const cuevaCES_v3 = {puertaEntradaCueva.irHacia(cueva);
                     cueva.configuradorTotal(cuevaC_v4, cuevaCES_v4)}

const cuevaCES_v4 = {puertaEntradaCueva.irHacia(entradaCueva);
                     entradaCueva.configuradorTotal(entradaCuevaC_v2, entradaCuevaCES_v2)  }

const entradaCuevaCES_v2 = {puertaEste.irHacia(bifurcacion);
                           bifurcacion.configuradorTotal(bifurcacionC_v3, bifurcacionCES_v3)}

const bifurcacionCES_v3 = {puertaSur.irHacia(diapoAmigaMuerta)}

const bifurcacionCES_v4 = {puertaEste.irHacia(entradaCabaña);
                           entradaCabaña.configuradorTotal(entradaCabañaC_v3, entradaCabañaCES_v3)}
                                         
const entradaCabañaCES_v3 = {puertaEntradaCabaña.irHacia(cabaña);
                             cabaña.configuradorTotal(cabañaC_v2, cabañaCES_v2)}

const cabañaCES_v2 = {puertaEntradaCabaña.irHacia(entradaCabaña);
                      entradaCabaña.configuradorTotal(entradaCabañaC_v4, entradaCabañaCES_v4)}
                                             
// Modificar esta parte con los setters nuevos 
const entradaCabañaCES_v4 = {puertaNorte.irHacia(entradaGranero)}

// Configuradores granero
const entradaGraneroCES_v1 = {puertaGranero.irHacia(diapoGranero)}

const graneroCES_v1 = {puertaGranero.irHacia(entradaGranero);
                       entradaGranero.configuradorTotal(entradaGraneroC_v2, entradaGraneroCES_v2)}
                                        
const entradaGraneroCES_v2 = {puertaSur.irHacia(entradaCabaña);
                              entradaCabaña.configuradorTotal(entradaCabañaC_v5, entradaCabañaCES_v5)}
                                                        
const entradaCabañaCES_v5 = {puertaEntradaCabaña.irHacia(cabaña);
                             cabaña.configuradorTotal(cabañaC_v3, cabañaCES_v3)}
                                                      
const cabañaCES_v3 = {puertaEntradaCabaña.irHacia(entradaCabaña);
                      entradaCabaña.configuradorTotal(entradaCabañaC_v6, entradaCabañaCES_v6)}
                                           
const entradaCabañaCES_v6 = {puertaOeste.irHacia(bifurcacion)
                             bifurcacion.configuradorTotal(bifurcacionC_v5, bifurcacionCES_v5)}
                                               
const bifurcacionCES_v5 = {puertaOeste.irHacia(entradaCueva);
                           entradaCueva.configuradorTotal(entradaCuevaC_v3, entradaCuevaCES_v3)}

const entradaCuevaCES_v3 = {puertaEntradaCueva.irHacia(cueva);
                            cueva.configuradorTotal(cuevaC_v1, cuevaCES_v6)}

const cuevaCES_v6 = {puertaEntradaCueva.irHacia(cueva);
                     cueva.configuradorTotal(cuevaC_v2, cuevaCES_v7)}

const cuevaCES_v7 = {puertaEntradaCueva.irHacia(cueva);
                     cueva.configuradorTotal(cuevaC_v3, cuevaCES_v8)}                                     

const cuevaCES_v8 = {puertaEntradaCueva.irHacia(cueva);
                     cueva.configuradorTotal(cuevaC_v5, cuevaCES_v9)}
                                                                       
const cuevaCES_v9 = {puertaEntradaCueva.irHacia(diapoPeleaFinal)}

const peleaFinalCES_v1 = {puertaEntradaCueva.irHacia(entradaCueva);
                          entradaCueva.configuradorTotal(entradaCueva_v4, entradaCuevaCES_v4)}         

const entradaCuevaCES_v4 = {puertaEste.irHacia(bifurcacion);
                            bifurcacion.configuradorTotal(bifurcacionC_v6, bifurcacionCES_v6)}         

const bifurcacionCES_v6 = {puertaNorte.irHacia(estacionamiento)}       

// configurador para test
const escenarioTestCES_v1 = {game.removeVisual(puertaSur)}

// ###########################################################################################################
//                                                  MUSICA 
// ###########################################################################################################


const track_fogata         = game.sound("musica-escenarioInicial-v1.mp3")

const track_ataque_lobos   = game.sound("lobos-atacan.mp3")

const track_suspence       = game.sound("suspenso.mp3")

const track_cueva          = game.sound("cueva.mp3")

const track_pelea_final    = game.sound("pelea-final.mp3")

const track_cabaña         = game.sound("cabaña.mp3")

const track_tramo_a_cabaña = game.sound("tramo-a-cabaña.mp3")

const track_pelea_granero  = game.sound("pelea-granero.mp3")

const track_tramo_final    = game.sound("tramo-final.mp3")

// ########################################### MUSICA DIAPOSITIVAS ###########################################

const track_inicio              = game.sound("inicio_v1.mp3")

const track_amiga_muerta        = game.sound("terror-amiga-muerta.mp3")

const traicion_granero          = game.sound("traicion-guardabosques.mp3")

const track_guardabosques_cueva = game.sound("guardabosques-cueva.mp3")

// ############################################## MUSICA EVENTOS ##############################################

const track_prota_preocupado = "lobos-amiga.mp3"

const track_manada           = "manada-lobo.mp3"

const track_game_over        = "gameover.mp3"

const track_win              = "game-win.mp3"


const track_guardabosques_derrotado = "victoria-guardabosques.mp3"

const track_loboJefe_derrotado      = "victoria-lobo.mp3"

// ############################################# SONIDOS ENEMIGOS ############################################# 

const track_guardabosques_muerte = "muerte-guardabosques.mp3"

const track_lobo_muerto1         = "muerte-perro-normal.mp3"

const track_lobo_muerto2         = "muerte-perro-normal2.mp3"

const track_lobo_muerto3         = "muerte-perro-normal3.mp3"

const track_lobo_muerto4         = "muerte-perro-normal4.mp3"

const sonidosMuerteLobo          = [track_lobo_muerto1, track_lobo_muerto2, track_lobo_muerto3, track_lobo_muerto4]

const track_loboEnojado          = "lobo-enojado.mp3"
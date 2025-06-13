import visualesExtra.*
import protagonista.*
import enemigos.*
import escenarios.*
import escenariosMapas.*
import dialogos.*
import eventos.*
import videojuego.*

/*
TEMPLATE CONFIGURADORES:
        
const confg_escenarioNombre = {e => e.visualesEnEscena();
                                    e.mapa();
                                    e.ost();
                                    e.dialogo();  // si no hay dialogos borrar esta linea
                                    e.eventos()}  // si no hay eventos borrar esta linea


  * si no hay dialogos borrar e.dialogo();
  * si no hay eventos borra e.eventos(); 

  IMPORTANTE: Si un escenario va a repetirse en distintos puntos del juego,
              los configuradores deben nombrarse al final con v1,v2,v3 para guiarse
              *tanto dialogos como eventos son LISTAS:
                  e.eventos(persecucionLobo)... MAL!!!
                  e.eventos([persecucionLobo]) ..BIEN!!!
                                    

*/
const confg_inicioJuego = {e =>           
                           
                           e.ost(game.sound("inicio_v1.mp3"))}

const confg_EscenarioInicial_v1 = {e =>   
                                e.mapa(mapa_escenarioInicial_v1);
                                e.visualesEnEscena( [amiga, carpa, fogata, puertaNorte, protagonista]);
                                e.ost(game.sound("musica-escenarioInicial-v1.mp3"));
                                e.dialogo(dialogoEscenarioInicial)}
//CONFIGURADORESESCENARIO BIFURCACION
const confg_escenarioBifurcacion_v1 = {e =>        
                                    e.mapa(mapa_escenarioBifurcacion_v1);
                                    e.visualesEnEscena( [ puertaEste, protagonista]);
                                    e.ost(game.sound("musica-escenarioInicial-v1.mp3"))
                                   }
      
const confg_escenarioBifurcacion_v2 = {e =>         
                                       e.mapa(mapa_escenarioBifurcacion_v2);
                                       e.visualesEnEscena( [ protagonista,puertaOeste]);
                                       e.ost(game.sound("lobos-atacan.mp3"));
                                       }

const confg_escenarioBifurcacion_v3 = {e=> e.mapa(mapa_escenarioBifurcacion_v3);
                                          e.visualesEnEscena([protagonista,puertaSur]);
                                        e.ost(game.sound("calma-antes-de-tormenta.mp3"));
                                        e.eventos([hablarProta2])
                                        }
const confg_escenarioBifurcacion_v4 = { e=> e.visualesEnEscena([protagonista,puertaEste]);
                                            e.mapa(mapa_escenarioBifurcacion_v4);
                                            e.ost(game.sound("calma-antes-de-tormenta.mp3"));
                                            e.eventos([hablarProta])}

// CONFIGURADORES ENTRADACABAÑA
const confg_escenarioEntradaCabaña_v1 = {e => 
                                      e.mapa(mapa_entradaCabaña_v1);
                                      e.visualesEnEscena([cabaña,protagonista,puertaEntradaCabaña] );
                                      e.ost(game.sound("musica-escenarioInicial-v1.mp3"))}

const confg_escenarioEntradaCabaña_v2 = {e => 
                                         e.mapa(mapa_entradaCabaña_v2);
                                         e.visualesEnEscena([cabaña,protagonista, puertaOeste] );
                                         e.ost(game.sound("musica-escenarioInicial-v1.mp3"))}

const confg_escenarioEntradaCabaña_v3 = {e => e.mapa(mapa_entradaCabaña_v1);
                                              e.visualesEnEscena([cabaña,protagonista,puertaEntradaCabaña]);
                                              e.ost(game.sound("calma-antes-de-tormenta.mp3"));
                                              }


const  confg_escenarioCabañaInicial_v1 = {e =>           
                                       e.mapa(mapa_cabañaInicial_v1);
                                       e.visualesEnEscena([guardabosques,protagonista] );
                                       e.ost(game.sound("cabaña.mp3"));
                                       e.dialogo(dialogoEnCabaña);
                                       e.eventos([eventoCabaña])}

const confg_escenarioCabañaInicial_v2 = {e => guardabosques.estadoCabaña(prepararseParaGranero);
                                          e.mapa(mapa_cabañaInicial_v1);
                                          e.visualesEnEscena([guardabosques,protagonista]);
                                          e.ost(game.sound("calma-antes-de-tormenta.mp3"));
                                          e.dialogo(dialogoEnCabaña2);
                                          e.eventos([eventoCabaña])}

// ############ZONA CUEVA
const confg_escenarioEntradaCueva_v1 = {e => e.mapa(mapa_entradaCueva_v1);
                                          e.visualesEnEscena([cueva,protagonista,puertaEntradaCueva])
                                          e.ost(game.sound("lobos-atacan.mp3"))}    

const confg_escenarioEntradaCueva_v2  ={e => e.mapa(mapa_entradaCueva_v2);
                                              e.visualesEnEscena([cueva,protagonista,puertaEste]);
                                              e.ost(game.sound("calma-antes-de-tormenta.mp3"))}                                                

const confg_escenarioCueva_v1 = {e=> e.mapa(mapa_cueva_v1);
                                     e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                     e.ost(game.sound("cueva.mp3"))}
const confg_escenarioCueva_v2 ={e=> e.mapa(mapa_cueva_v2);
                                     e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                     e.ost(game.sound("cueva.mp3"))}

 const confg_escenarioCueva_v3 = {e=> e.mapa(mapa_cueva_v3);
                                     e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                     e.ost(game.sound("cueva.mp3"))}
 const confg_escenarioCueva_v4 =   {e=> e.mapa(mapa_cueva_v4);
                                        e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                       e.ost(game.sound("cueva.mp3"))}                          


//-----------DEJAR ABAJO DE TODO ---------
const confg_escenarioTEST = {e =>           
                             e.mapa(mapa_escenarioTest);
                             e.visualesEnEscena( [protagonista,hacha,cueva]);
                             e.ost(game.sound("game-win.mp3"));
                             }

// #########################################################################################################
// CONFIGURADORES EXCLUSIVOS PARA ESCENARIOS CON DIAPOS, NO REQUIEREN CONFIGURADOR DE ESCEANRIO SIGUIENTE
// #########################################################################################################
const confg_escenarioAmigaMuerta = {e=> videojuego.escenaAmigaMuerta(true);
                                        e.ost(game.sound("traicion-granero.mp3"))

                                      }

const confg_graneroDiapo = {e=> videojuego.estoyEnGranero(true);
                            //e.mapa(mapa_inicioJuego);
                            e.ost(game.sound("traicion-granero.mp3"))}
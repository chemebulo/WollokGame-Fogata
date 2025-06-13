import visualesExtra.*
import protagonista.*
import enemigos.*
import escenarios.*
import escenariosMapas.*
import dialogos.*
import eventos.*
import videojuego.*
import diapositivasManager.*
import puertas.*

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
                                       e.eventos([hablarProta4])
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

const confg_escenarioBifurcacion_v5 = {e => e.visualesEnEscena([protagonista,puertaOeste]);
                                             e.mapa(mapa_escenarioBifurcacion_v5);
                                             e.ost(game.sound("lobos-atacan.mp3"));
                                             e.eventos([hablarProta7])}
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

const confg_escenarioEntradaCabaña_v4 = {e=> game.removeVisual(puertaEntradaCabaña);
                                            guardabosques.image("guardabosques-abajo.png");
                                            e.mapa(mapa_EntradaCabaña_v3);
                                            e.visualesEnEscena([cabaña,protagonista,puertaNorte,guardabosques]);
                                            e.ost(game.sound("calma-antes-de-tormenta.mp3"));
                                            e.eventos([guardabosquesHabla])
                                        }
const confg_escenarioEntradaCabaña_v5  = {e =>  e.mapa(mapa_EntradaCabaña_v4);
                                                e.visualesEnEscena([cabaña,protagonista,puertaEntradaCabaña]);
                                                e.ost(game.sound("calma-antes-de-tormenta.mp3"))
}           
//aqui arranque
const confg_escenarioEntradaCabaña_v6 = {e => game.removeVisual(puertaEntradaCabaña);
                                              e.mapa(mapa_EntradaCabaña_v3);
                                              e.visualesEnEscena([cabaña,protagonista,puertaOeste]);
                                              e.ost(game.sound("calma-antes-de-tormenta.mp3"));

}

//########### CONFIGURADORES  PARA TODA LA SECUENCIA DEL  GRANERO

const confg_escenarioEntradaGranero_v1 = {e=> e.mapa(mapa_entradaGranero_v1);
                                                e.visualesEnEscena([granero,protagonista,guardabosques,puertaGranero]);
                                                e.ost(game.sound("calma-antes-de-tormenta.mp3"));
                                                e.eventos([guardabosquesHabla2])}
const confg_escenarioGranero_v1 ={e=> 
                                 e.mapa(mapa_peleaGranero);
                                  e.visualesEnEscena([protagonista,hacha]);
                                  e.ost(game.sound("lobos-atacan.mp3"))}

const confg_escenarioEntradaGranero_v2 ={e=> game.removeVisual(puertaGranero);
                                              e.mapa(mapa_entradaGranero_v2)
                                          e.visualesEnEscena([granero,protagonista,puertaSur]);
                                          e.ost(game.sound("calma-antes-de-tormenta.mp3"));
                                          e.eventos([hablarProta3])}

//## CABAÑA

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

const confg_escenarioCabañaInicial_v3 = {e => e.mapa(mapa_cabañaInicial_v2);
                                         e.visualesEnEscena([protagonista,nota]);
                                         e.ost(game.sound("calma-antes-de-tormenta.mp3"))}     // estoy aqui                       
// ############ZONA CUEVA
const confg_escenarioEntradaCueva_v1 = {e => e.mapa(mapa_entradaCueva_v1);
                                          e.visualesEnEscena([cueva,protagonista,puertaEntradaCueva])
                                          e.ost(game.sound("lobos-atacan.mp3"));
                                          e.eventos([hablarProta5])}    

const confg_escenarioEntradaCueva_v2  ={e => e.mapa(mapa_entradaCueva_v2);
                                              e.visualesEnEscena([cueva,protagonista,puertaEste]);
                                              e.ost(game.sound("calma-antes-de-tormenta.mp3"))} 
const confg_escenarioEntradaCueva_v3 = {e=> e.mapa(mapa_entradaCueva_v3);
                                            e.visualesEnEscena([cueva,protagonista,puertaEntradaCueva]);
                                            e.ost(game.sound("lobos-atacan.mp3"))}                                                 
                                                                                          

const confg_escenarioCueva_v1 = {e=> e.mapa(mapa_cueva_v1);
                                     e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                     e.ost(game.sound("cueva.mp3"));
                                     e.eventos([hablarProta6])}
const confg_escenarioCueva_v2 ={e=> e.mapa(mapa_cueva_v2);
                                     e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                     e.ost(game.sound("cueva.mp3"))}

 const confg_escenarioCueva_v3 = {e=> e.mapa(mapa_cueva_v3);
                                     e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                     e.ost(game.sound("cueva.mp3"))}
 const confg_escenarioCueva_v4 =   {e=> e.mapa(mapa_cueva_v4);
                                        e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                       e.ost(game.sound("cueva.mp3"))}                          

const confg_escenarioCueva_v5 = {e=> e.mapa(mapa_cueva_v5);
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
const confg_escenarioAmigaMuerta = {e=> gestorDeDiapositivas.esHoraDeDiapositiva(true);
                                        e.ost(game.sound("traicion-granero.mp3"))

                                      }

const confg_graneroDiapo = {e=> gestorDeDiapositivas.esHoraDeDiapositiva(true);
                            game.removeVisual(puertaGranero)
                            e.ost(game.sound("traicion-granero.mp3"))}
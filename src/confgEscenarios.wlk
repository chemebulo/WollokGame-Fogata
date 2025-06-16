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
import npcEstados.*
import gestores.gestorAccionesGuardabosques

/*
TEMPLATE CONFIGURADORES:
        
const nombreEscenarioC_v* = {e => e.visualesEnEscena();
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
const inicioC_v1 = {e =>           
                           
                           e.ost(game.sound("inicio_v1.mp3"))}

const fogataC_v1 = {e =>   
                                e.mapa(mapa_escenarioInicial_v1);
                                e.visualesEnEscena( [amiga, carpa, fogataOBJ, puertaNorte, protagonista]);
                                e.ost(game.sound("musica-escenarioInicial-v1.mp3"));
                                e.dialogo(dialogoEscenarioInicial)}
//CONFIGURADORESESCENARIO BIFURCACION
const bifurcacionC_v1 = {e =>        
                                    e.mapa(mapa_escenarioBifurcacion_v1);
                                    e.visualesEnEscena( [ puertaEste, protagonista]);
                                    e.ost(game.sound("musica-escenarioInicial-v1.mp3"))
                                   }
      
const bifurcacionC_v2 = {e =>         
                                       e.mapa(mapa_escenarioBifurcacion_v2);
                                       e.visualesEnEscena( [ protagonista,puertaOeste]);
                                       e.ost(game.sound("lobos-atacan.mp3"));
                                       e.eventos([hablarProta4])
                                       }

const bifurcacionC_v3 = {e=> e.mapa(mapa_escenarioBifurcacion_v3);
                                          e.visualesEnEscena([protagonista,puertaSur]);
                                        e.ost(game.sound("calma-antes-de-tormenta.mp3"));
                                        e.eventos([hablarProta2])
                                        }
const bifurcacionC_v4 = { e=> e.visualesEnEscena([protagonista,puertaEste]);
                                            e.mapa(mapa_escenarioBifurcacion_v4);
                                            e.ost(game.sound("calma-antes-de-tormenta.mp3"));
                                            e.eventos([hablarProta])}

const bifurcacionC_v5 = {e => e.visualesEnEscena([protagonista,puertaOeste]);
                                             e.mapa(mapa_escenarioBifurcacion_v5);
                                             e.ost(game.sound("lobos-atacan.mp3"));
                                             e.eventos([hablarProta7])}
// CONFIGURADORES ENTRADACABAÑA
const entradaCabañaC_v1 = {e => 
                                      e.mapa(mapa_entradaCabaña_v1);
                                      e.visualesEnEscena([cabañaOBJ,protagonista,puertaEntradaCabaña] );
                                      e.ost(game.sound("musica-escenarioInicial-v1.mp3"))}

const entradaCabañaC_v2 = {e => 
                                         e.mapa(mapa_entradaCabaña_v2);
                                         e.visualesEnEscena([cabañaOBJ,protagonista, puertaOeste] );
                                         e.ost(game.sound("calma-antes-de-tormenta.mp3"));
                                         e.eventos([escucharLobos])}

const entradaCabañaC_v3 = {e => e.mapa(mapa_entradaCabaña_v1);
                                              e.visualesEnEscena([cabañaOBJ,protagonista,puertaEntradaCabaña]);
                                              e.ost(game.sound("calma-antes-de-tormenta.mp3"));
                                              }

const entradaCabañaC_v4 = {e=> game.removeVisual(puertaEntradaCabaña);
                                            guardabosques.image("guardabosques-abajo.png");
                                            e.mapa(mapa_EntradaCabaña_v3);
                                            e.visualesEnEscena([cabañaOBJ,protagonista,puertaNorte,guardabosques]);
                                            e.ost(game.sound("calma-antes-de-tormenta.mp3"));
                                            e.eventos([guardabosquesHabla])
                                        }
const entradaCabañaC_v5  = {e =>  e.mapa(mapa_EntradaCabaña_v4);
                                                e.visualesEnEscena([cabañaOBJ,protagonista,puertaEntradaCabaña]);
                                                e.ost(game.sound("calma-antes-de-tormenta.mp3"))
}           
//aqui arranque
const entradaCabañaC_v6 = {e => game.removeVisual(puertaEntradaCabaña);
                                              e.mapa(mapa_EntradaCabaña_v3);
                                              e.visualesEnEscena([cabañaOBJ,protagonista,puertaOeste]);
                                              e.ost(game.sound("calma-antes-de-tormenta.mp3"));

}

//########### CONFIGURADORES  PARA TODA LA SECUENCIA DEL  GRANERO

const entradaGraneroC_v1 = {e=> e.mapa(mapa_entradaGranero_v1);
                                                e.visualesEnEscena([graneroOBJ,protagonista,guardabosques,puertaGranero]);
                                                e.ost(game.sound("calma-antes-de-tormenta.mp3"));
                                                e.eventos([guardabosquesHabla2])}
const graneroC_v1 ={e=> 
                                 e.mapa(mapa_peleaGranero);
                                  e.visualesEnEscena([protagonista,hacha,loboEspecial]);
                                  e.ost(game.sound("pelea-granero.mp3"));
                                  e.eventos([eventoLoboEspecial])}

const entradaGraneroC_v2 ={e=> game.removeVisual(puertaGranero);
                                              e.mapa(mapa_entradaGranero_v2)
                                          e.visualesEnEscena([graneroOBJ,protagonista,puertaSur]);
                                          e.ost(game.sound("calma-antes-de-tormenta.mp3"));
                                          e.eventos([hablarProta3])}

//## CABAÑA

const  cabañaC_v1 = {e =>           
                                       e.mapa(mapa_cabañaInicial_v1);
                                       e.visualesEnEscena([guardabosques,protagonista] );
                                       e.ost(game.sound("cabaña.mp3"));
                                       e.dialogo(dialogoEnCabaña);
                                       e.eventos([accionesGuardabosques])}

const cabañaC_v2 = {e => gestorAccionesGuardabosques.accionesGuardabosques(prepararseParaGranero);
                                          e.mapa(mapa_cabañaInicial_v1);
                                          e.visualesEnEscena([guardabosques,protagonista]);
                                          e.ost(game.sound("calma-antes-de-tormenta.mp3"));
                                          e.dialogo(dialogoEnCabaña2);
                                          e.eventos([accionesGuardabosques])}

const cabañaC_v3 = {e => e.mapa(mapa_cabañaInicial_v2);
                                         e.visualesEnEscena([protagonista,nota]);
                                         e.ost(game.sound("calma-antes-de-tormenta.mp3"))}     // estoy aqui                       
// ############ZONA CUEVA
const entradaCuevaC_v1 = {e => e.mapa(mapa_entradaCueva_v1);
                                          e.visualesEnEscena([cuevaOBJ,protagonista,puertaEntradaCueva])
                                          e.ost(game.sound("lobos-atacan.mp3"));
                                          e.eventos([hablarProta5])}    

const entradaCuevaC_v2  ={e => e.mapa(mapa_entradaCueva_v2);
                                              e.visualesEnEscena([cuevaOBJ,protagonista,puertaEste]);
                                              e.ost(game.sound("calma-antes-de-tormenta.mp3"))} 
const entradaCuevaC_v3 = {e=> e.mapa(mapa_entradaCueva_v3);
                                            e.visualesEnEscena([cuevaOBJ,protagonista,puertaEntradaCueva]);
                                            e.ost(game.sound("lobos-atacan.mp3"))}                                                 
                                                                                          

const cuevaC_v1 = {e=> e.mapa(mapa_cueva_v1);
                                     e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                     e.ost(game.sound("cueva.mp3"));
                                     e.eventos([hablarProta6])}
const cuevaC_v2 ={e=> e.mapa(mapa_cueva_v2);
                                     e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                     e.ost(game.sound("cueva.mp3"))}

 const cuevaC_v3 = {e=> e.mapa(mapa_cueva_v3);
                                     e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                     e.ost(game.sound("cueva.mp3"))}
 const cuevaC_v4 =   {e=> e.mapa(mapa_cueva_v4);
                                        e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                       e.ost(game.sound("cueva.mp3"))}                          

const cuevaC_v5 = {e=> e.mapa(mapa_cueva_v5);
                                        e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                       e.ost(game.sound("cueva.mp3"))}  

  /*  PELEA FINAL */                                     
const peleaFinalC_v1 = {e => protagonista.estadoCombate(armadoProtagonista);
                             gestorAccionesGuardabosques.accionesGuardabosques(peleaFinalEstado);
                             guardabosques.estadoCombate(armadoGuardabosques);
                             e.mapa(mapa_FinalJuego)
                             e.visualesEnEscena([protagonista,guardabosques]);
                             e.ost(game.sound("pelea-final.mp3"));
                             e.eventos([accionesGuardabosques,ataqueGuardabosques])}  
//-----------DEJAR ABAJO DE TODO ---------
const escenarioTestC_v1 = {e =>           
                             e.mapa(mapa_escenarioTest);
                             e.visualesEnEscena( [protagonista,hacha,cuevaOBJ]);
                             e.ost(game.sound("game-win.mp3"));
                             }

// #########################################################################################################
// CONFIGURADORES EXCLUSIVOS PARA ESCENARIOS CON DIAPOS, NO REQUIEREN CONFIGURADOR DE ESCEANRIO SIGUIENTE
// #########################################################################################################
const diapoAmigaMuertaC_v1 = {e=> gestorDeDiapositivas.esHoraDeDiapositiva(true);
                                        e.ost(game.sound("terror-amiga-muerta.mp3"))

                                      }

const diapoPeleaFinalC_v1 = {e => protagonista.estadoCombate(desarmadoProtagonista);gestorDeDiapositivas.esHoraDeDiapositiva(true);
                                            e.ost(game.sound("guardabosques-cueva.mp3"))}

const diapoGraneroC_v1 = {e=> gestorDeDiapositivas.esHoraDeDiapositiva(true);
                            game.removeVisual(puertaGranero)
                            e.ost(game.sound("traicion-guardabosques.mp3"))}
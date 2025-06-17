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
import musica.*
import acciones.*

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
                           
                           e.ost(track_inicio)}

const fogataC_v1 = {e =>   
                                e.mapa(mapa_escenarioInicial_v1);
                                e.visualesEnEscena( [amiga, carpa, fogataOBJ, puertaNorte, protagonista]);
                                e.ost(track_fogata);
                                e.dialogo(dialogoEscenarioInicial)}
//CONFIGURADORESESCENARIO BIFURCACION
const bifurcacionC_v1 = {e =>        
                                    e.mapa(mapa_escenarioBifurcacion_v1);
                                    e.visualesEnEscena( [ puertaEste, protagonista]);
                                    e.ost(track_fogata)
                                   }
      
const bifurcacionC_v2 = {e =>         
                                       e.mapa(mapa_escenarioBifurcacion_v2);
                                       e.visualesEnEscena( [ protagonista,puertaOeste]);
                                       e.ost(track_ataque_lobos);
                                       e.eventos([hablarProta4])
                                       }

const bifurcacionC_v3 = {e=> e.mapa(mapa_escenarioBifurcacion_v3);
                                          e.visualesEnEscena([protagonista,puertaSur]);
                                        e.ost(track_suspence);
                                        e.eventos([hablarProta2])
                                        }
const bifurcacionC_v4 = { e=> e.visualesEnEscena([protagonista,puertaEste]);
                                            e.mapa(mapa_escenarioBifurcacion_v4);
                                            e.ost(track_tramo_a_cabaña);
                                            e.eventos([hablarProta])}

const bifurcacionC_v5 = {e => e.visualesEnEscena([protagonista,puertaOeste]);
                                             e.mapa(mapa_escenarioBifurcacion_v5);
                                             e.ost(track_ataque_lobos);
                                             e.eventos([hablarProta7])}

const bifurcacionC_v6 = {e => e.mapa(mapa_escenarioBifurcacion_v6);
                               e.visualesEnEscena([protagonista,puertaNorte]);
                               e.ost(track_tramo_final)}                                             
// CONFIGURADORES ENTRADACABAÑA
const entradaCabañaC_v1 = {e => 
                                      e.mapa(mapa_entradaCabaña_v1);
                                      e.visualesEnEscena([cabañaOBJ,protagonista,puertaEntradaCabaña] );
                                      e.ost(track_fogata)}

const entradaCabañaC_v2 = {e => 
                                         e.mapa(mapa_entradaCabaña_v2);
                                         e.visualesEnEscena([cabañaOBJ,protagonista, puertaOeste] );
                                         e.ost(track_suspence);
                                         e.eventos([escucharLobos])}

const entradaCabañaC_v3 = {e => e.mapa(mapa_entradaCabaña_v1);
                                              e.visualesEnEscena([cabañaOBJ,protagonista,puertaEntradaCabaña]);
                                              e.ost(track_tramo_a_cabaña);
                                              }

const entradaCabañaC_v4 = {e=> game.removeVisual(puertaEntradaCabaña);
                                            guardabosques.image("guardabosques-abajo.png");
                                            e.mapa(mapa_EntradaCabaña_v3);
                                            e.visualesEnEscena([cabañaOBJ,protagonista,puertaNorte,guardabosques]);
                                            e.ost(track_suspence);
                                            e.eventos([guardabosquesHabla])
                                        }
const entradaCabañaC_v5  = {e =>  e.mapa(mapa_EntradaCabaña_v4);
                                                e.visualesEnEscena([cabañaOBJ,protagonista,puertaEntradaCabaña]);
                                                e.ost(track_suspence)
}           
//aqui arranque
const entradaCabañaC_v6 = {e => game.removeVisual(puertaEntradaCabaña);
                                              e.mapa(mapa_EntradaCabaña_v3);
                                              e.visualesEnEscena([cabañaOBJ,protagonista,puertaOeste]);
                                              e.ost(track_suspence);

}

//########### CONFIGURADORES  PARA TODA LA SECUENCIA DEL  GRANERO

const entradaGraneroC_v1 = {e=> e.mapa(mapa_entradaGranero_v1);
                                                e.visualesEnEscena([graneroOBJ,protagonista,guardabosques,puertaGranero]);
                                                e.ost(track_suspence);
                                                e.eventos([guardabosquesHabla2])}
const graneroC_v1 ={e=> 
                                 e.mapa(mapa_peleaGranero);
                                  e.visualesEnEscena([protagonista,hacha,loboEspecial,tridente]);
                                  e.ost(track_pelea_granero);
                                  e.eventos([eventoLoboEspecial])}

const entradaGraneroC_v2 ={e=> game.removeVisual(puertaGranero);
                                              e.mapa(mapa_entradaGranero_v2)
                                          e.visualesEnEscena([graneroOBJ,protagonista,puertaSur]);
                                          e.ost(track_suspence);
                                          e.eventos([hablarProta3])}

//## CABAÑA

const  cabañaC_v1 = {e =>           
                                       e.mapa(mapa_cabañaInicial_v1);
                                       e.visualesEnEscena([guardabosques,protagonista] );
                                       e.ost(track_cabaña);
                                       e.dialogo(dialogoEnCabaña);
                                       e.eventos([accionesGuardabosques])}

const cabañaC_v2 = {e => gestorAccionesGuardabosques.accionesGuardabosques(prepararseParaGranero);
                                          e.mapa(mapa_cabañaInicial_v1);
                                          e.visualesEnEscena([guardabosques,protagonista]);
                                          e.ost(track_suspence);
                                          e.dialogo(dialogoEnCabaña2);
                                          e.eventos([accionesGuardabosques])}

const cabañaC_v3 = {e => e.mapa(mapa_cabañaInicial_v2);
                                         e.visualesEnEscena([protagonista,nota]);
                                         e.ost(track_suspence)}     // estoy aqui                       
// ############ZONA CUEVA
const entradaCuevaC_v1 = {e => e.mapa(mapa_entradaCueva_v1);
                                          e.visualesEnEscena([cuevaOBJ,protagonista,puertaEntradaCueva])
                                          e.ost(track_ataque_lobos);
                                          e.eventos([hablarProta5])}    

const entradaCuevaC_v2  ={e => e.mapa(mapa_entradaCueva_v2);
                                              e.visualesEnEscena([cuevaOBJ,protagonista,puertaEste]);
                                              e.ost(track_suspence)} 
const entradaCuevaC_v3 = {e=> e.mapa(mapa_entradaCueva_v3);
                                            e.visualesEnEscena([cuevaOBJ,protagonista,puertaEntradaCueva]);
                                            e.ost(track_ataque_lobos)}                                                 
const entradaCueva_v4 = {e =>protagonista.estadoCombate(desarmadoProtagonista);
                            protagonista.image("prota-desarmado-abajo.png");
                              game.removeVisual(puertaEntradaCueva)
                              e.mapa(mapa_entradaCueva_v2);
                             e.visualesEnEscena([cuevaOBJ,protagonista,puertaEste]);
                             e.ost(track_tramo_final)
                             }


const cuevaC_v1 = {e=> e.mapa(mapa_cueva_v1);
                                     e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                     e.ost(track_cueva);
                                     e.eventos([hablarProta6])}
const cuevaC_v2 ={e=> e.mapa(mapa_cueva_v2);
                                     e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                     e.ost(track_cueva)}

 const cuevaC_v3 = {e=> e.mapa(mapa_cueva_v3);
                                     e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                     e.ost(track_cueva)}
 const cuevaC_v4 =   {e=> e.mapa(mapa_cueva_v4);
                                        e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                       e.ost(track_cueva)}                          

const cuevaC_v5 = {e=> e.mapa(mapa_cueva_v5);
                                        e.visualesEnEscena([protagonista,puertaEntradaCueva]);
                                       e.ost(track_cueva)}  

  /*  PELEA FINAL */                                     
const peleaFinalC_v1 = {e => protagonista.estadoCombate(protagonista.estadoCombateElejido());
                             gestorAccionesGuardabosques.accionesGuardabosques(peleaFinalEstado);
                             guardabosques.estadoCombate(armadoGuardabosques);
                             e.mapa(mapa_FinalJuego)
                             e.visualesEnEscena([protagonista,guardabosques]);
                             e.ost(track_pelea_final);
                             e.eventos([accionesGuardabosques,ataqueGuardabosques,hablarProta9])}  

const estacionamientoC_v1 ={e => e.mapa(mapa_estacionamiento_v1);
                                e.visualesEnEscena([protagonista,auto]);
                                 e.ost(track_tramo_final);
                                 e.eventos([hablarProta8])}                            
//-----------DEJAR ABAJO DE TODO ---------
const escenarioTestC_v1 = {e =>           
                             e.mapa(mapa_escenarioTest);
                             e.visualesEnEscena( [protagonista,hacha,cuevaOBJ]);
                             e.ost(track_win);
                             }

// #########################################################################################################
// CONFIGURADORES EXCLUSIVOS PARA ESCENARIOS CON DIAPOS, NO REQUIEREN CONFIGURADOR DE ESCEANRIO SIGUIENTE
// #########################################################################################################
const diapoAmigaMuertaC_v1 = {e=> gestorDeDiapositivas.esHoraDeDiapositiva(true);
                                        e.ost(track_amiga_muerta)

                                      }

const diapoPeleaFinalC_v1 = {e => protagonista.estadoCombate(desarmadoProtagonista);gestorDeDiapositivas.esHoraDeDiapositiva(true);
                                            e.ost(track_guardabosques_cueva)}

const diapoGraneroC_v1 = {e=> gestorDeDiapositivas.esHoraDeDiapositiva(true);
                            game.removeVisual(puertaGranero)
                            e.ost(traicion_granero)}
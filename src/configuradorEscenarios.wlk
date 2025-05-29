import visualesExtra.*
import protagonista.*
import dialogos.*
import escenarios.*
import escenarios_mapas.*
import enemigos.*
import eventos.*
/*
TEMPLATE CONFIGURADORES:
const confg_escenarioNombre = {e => e.fondoEscenario();           
                                      e.mapa();
                                      e.visualesEnEscena( );
                                      e.ost();
                                      e.dialogo();
                                      e.eventos()}

//BORRAR LOS QUE NO SE USEN, Respetar nomenclatura de variables para no marearse

*/
const confg_inicioJuego= {e => e.fondoEscenario("inicio-v2.png");           
                               e.mapa(mapa_inicioJuego);
                               e.ost(game.sound("inicio_v1.mp3"));
                                      
                         }

const confg_EscenarioInicial = {e => e.fondoEscenario("fondo-escenario-inicial.png");   
                                      e.mapa(mapa_escenarioInicial);
                                      e.visualesEnEscena( [amiga, carpa, fogata, puertaNorte, protagonista]);
                                      e.ost(game.sound("musica-escenarioInicial-v1.mp3"));
                                      e.dialogo(dialogoEscenarioInicial)}


const confg_escenarioBifurcacion = {e => e.fondoEscenario("fondo-escenario-inicial.png");           
                                      e.mapa(mapa_escenarioBifurcacion);
                                      e.visualesEnEscena( [puertaNorte, puertaOeste, puertaEste, protagonista,loboAgresivo]);
                                      e.ost(game.sound("musica-escenarioInicial-v1.mp3"));
                                      e.eventos([persecucionLoboAgresivo])}
                                       




//-----------DEJAR ABAJO DE TODO ---------
const confg_escenarioTEST = {e => e.fondoEscenario("fondo-escenarioTEST.png");           
                                      e.mapa(mapa_escenarioTest);
                                      e.visualesEnEscena( [carpa, amiga, protagonista, puertaOeste]);
                                      e.ost(game.sound("musica-escenarioInicial.mp3"));
                                      e.dialogo(dialogoEscenarioTest)
                                     }



                                     
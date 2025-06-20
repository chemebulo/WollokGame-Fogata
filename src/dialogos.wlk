import visualesExtra.amiga
import enemigos.*

/*
    INVARIANTE DE REPRESENTACION : *LA cantidad de dialogos es un numero par, 
                                    *El primer dialogo es del protagonista
                                    *la lista del dialogo que ira en el escenario debe ser [npcActual, dialogoActual]
                                     donde npcActual: es el npc con el que hablara, el npc debe estar en la lista de visualesEnEscena, véase ejemplo en amiga.
                                     dialogoActual = una lista con string de dialogos
                                    *el dialogo que recibe el escenario es SI O SI la lista[npcActual,dialogo]

*/
// ---------- DIALOGO ESCENARIO INICIAL -------

const dialogoAmiga = ["¿Dónde quedaba la cabaña?", "Al Norte y después a la derecha", "Dale, ahí vengo", "Dale, te espero"]

const dialogoEscenarioInicial = [amiga, dialogoAmiga]

const dialogoCabaña    = ["Hola, ¿cómo va?", "Buenas Juan, ¿cómo va el lugar?", "Excelente, me preguntaba si tendría algo de leña", "Claro, ahí al lado de la chimenea"]
const dialogoEnCabaña  = [guardabosques, dialogoCabaña]

const dialogoCabaña2   = ["¡¡¡AUXILIOO!!!", "¿Qué paso chango?", "Esta lleno de lobos, mataron a mi amiga", "Mierda, no pensé que se acercarían", "¿Qué hago ahora?", "Tranquilo, vamos al granero", "¿Qué hay ahi?", "Tengo... armas"]
const dialogoEnCabaña2 = [guardabosques, dialogoCabaña2]

// ################# DIALOGOS EN ESCENARIO TEST #################
const dialogoTEST          = ["Hola de nuevo", "Ya habíamos hablado", "Enloquecí, no?", "Sí, andate"]
const dialogoEscenarioTest = [amiga, dialogoTEST]
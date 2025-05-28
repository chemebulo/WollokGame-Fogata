import visualesExtra.amiga



/*
    INVARIANTE DE REPRESENTACION : *LA cantidad de dialogos es un numero par, 
                                    *El primer dialogo es del protagonista
                                    *la lista del dialogo que ira en el escenario debe ser [npcActual, dialogoActual]
                                    (ejemplo en escenario Inicial)

*/
// ---------- DIALOGO ESCENARIO INICIAL -------

const dialogoAmiga = ["Hola, como estas","Bien y tu?","Bien, estamos reimplementando los dialogos","Adios"]

const dialogoEscenarioInicial = [amiga,dialogoAmiga]
//--------------------------------------------

const dialogoTEST = ["Hola de nuevo","Ya habiamos hablado","Enloqueci verdad?","Si, ya vete"]
const dialogoEscenarioTest = [amiga,dialogoTEST]
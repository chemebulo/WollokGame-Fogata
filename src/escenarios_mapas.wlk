import escenarioManager.*
/*
    MEDIDA DE TODOS LOS ESCENARIOS: Usar estas medidas para TODOS los escenarios:
    9 listas(el alto) con 13 elementos (el ancho)

    IMPORTANTE: Las puertas norte,sur,este,oeste(con ubicaciones) 
    y puertas cerradas norte,sur,este,oeste(con mensajes) y las puertas genericas 
    no es necesario crear objetos de tipo Elemento(véase escenarioManager.wlk) para dibujarlas,
    solo se agregaran como visuales en los objetos "escenario" en metodo agregarVisualesEscena()
    Luego de dibujar el escenario reemplazar la N con _ si dibujamos todas las puertas,
    Si por ejemplo un escenario tiene solo puertas oeste y este, se puede dibujar algo en las N
    que simbolizan norte y sur
    Es importante sobreescribir el metodo
    configurarPuertas() con los requerimientos del escenario actual

    [
        [_,_,_,_,_,_,N,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [N,_,_,_,_,_,_,_,_,_,_,_,N],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,_,N,_,_,_,_,_,_]
     
    ].reverse()

    nombres de variables recomendados = mapa_nombreEscenario

*/

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

const mapa_escenarioInicial = 
    [
     [_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,a,z,_,f,c,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_],
     [_,_,_,_,_,_,_,_,_,_,_,_,_]
     
     ].reverse()

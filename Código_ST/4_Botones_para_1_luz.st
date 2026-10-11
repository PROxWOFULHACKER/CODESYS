VAR

Boton1, Boton2, Boton3, Boton4: BOOL;
STOP: BOOL;
Luz1: BOOL;

END_VAR

// Logica que controlara una luz atravez de 4 botones
// separados en 2 bloques de 2 botones en paralelo + un boton de paro
// Practica sobre compuertas logicas OR, AND y NOT

Luz1 := (Boton1 OR boton2) AND (Boton3 OR Boton4) AND NOT STOP;

 / / END
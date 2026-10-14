VAR

// Luces de los focos del semaforo
FocoVerde: BOOL;
FocoAmarillo: BOOL;
FocoRojo: BOOL;

// Simbolo de Paso de Peatones
Simbolo_Paso_Verde: BOOL;
Simbolo_Paso_Rojo: BOOL;

// Control del semaforo
Marcha: BOOL;
Paro: BOOL;
Sistema_ACTIVO: BOOL;
Solicitud_de_Paso: BOOL;

// Variables de TEMPORIZADORES
Timer_Verde: TON;
Timer_Amarillo: TON;
Timer_Rojo: TON;
Timer_Duracion_de_Paso: TP;
// Controla los 5 segundos que parpadeara el foco amarillo antes de cambiar a rojo

// Modos de funcionamiento
Parpadeo_FocoAmarillo: BLINK;

END_VAR

// Logica de control_CODESYS

// Arranque y paro del semaforo
IF Paro THEN
Sistema_ACTIVO := FALSE;
ELSIF Marcha THEN
Sistema_ACTIVO := TRUE;


// Temporizador del ciclo de PULSOS (Funcion_TP) del FocoAmarillo y de la botonera
Timer_Duracion_de_Paso(
    IN := Solicitud_de_Paso AND FocoVerde,
    PT := T#5s);

// Bloque BLINK para el parpadeo del foco amarillo
Parpadeo_FocoAmarillo(
    ENABLE := Timer_Duracion_de_Paso.Q,
    TIMEHIGH := T#500ms,
    TIMELOW := T#500ms,
    OUT => FocoAmarillo
);

// Control de los focos del semaforo usando la funcion IF


VAR

Boton_Verde: BOOL;
Boton_Rojo: BOOL;
Verde: BOOL; //
Rojo: BOOL; //
PARO: BOOL;

END_VAR

IF Boton_Verde THEN
Verde := TRUE;
END_IF

IF Boton_Rojo THEN
Verde := FALSE;
Rojo := TRUE;
END_IF

IF PARO THEN
Verde := FALSE;
Rojo := FALSE;
END_IF;

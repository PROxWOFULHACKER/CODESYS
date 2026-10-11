// ==============================================================================
// Control de Luz Verde con Enclavamiento (Marcha / Paro)
// Lenguaje: Texto Estructurado (Structured Text - ST) / IEC 61131-3 (CODESYS)
// ==============================================================================

VAR
    Boton_Marcha: BOOL; // Pulsador de encendido / marcha (NA - Normalmente Abierto)
    Boton_Paro: BOOL; // Pulsador de apagado / paro (Ver nota de contacto NA/NC)
    Luz_Verde: BOOL; // Salida / Luz verde retenida
END_VAR

// ------------------------------------------------------------------------------
// Opción 1: Lógica booleana clásica con auto-retención (Prioridad al Paro)
// ------------------------------------------------------------------------------
// Si el Boton_Paro es leído como TRUE al pulsarse (contacto NA en software):
Luz_Verde := (Boton_Marcha OR Luz_Verde) AND NOT Boton_Paro;

// ------------------------------------------------------------------------------
// Opción 2: Equivalente mediante estructura IF (Condicional con prioridad al Paro)
// Descomentar si se prefiere este estilo:
// ------------------------------------------------------------------------------
(*
IF Boton_Marcha THEN
    Luz_Verde := TRUE;
END_IF;

IF Boton_Paro THEN
    Luz_Verde := FALSE; // Tiene prioridad por ejecutarse después
END_IF;
 *)

// ------------------------------------------------------------------------------
// NOTA DE SEGURIDAD INDUSTRIAL (Contacto Físico NC):
// Si el pulsador de paro en la entrada física del PLC es normalmente cerrado (NC),
// la señal suele llegar en TRUE en reposo y FALSE al pulsarse.
// En ese caso, la línea sería:
// Luz_Verde := (Boton_Marcha OR Luz_Verde) AND Boton_Paro;
// ------------------------------------------------------------------------------

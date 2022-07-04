/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.csv' USING PigStorage(',') 
    AS (
        id:int, 
        name:chararray, 
        lastName:chararray,
        date:chararray,
        color:chararray

        );

aux_1 = FOREACH Data_ GENERATE ToString(date, 'yyyy-MM-dd') AS date, ToString(date, 'dd,d') AS dia, ToString(date, 'EEE') AS diaAbreviado, ToString(date, 'EEEE') AS nombre_dia;

sol = FOREACH aux_1 GENERATE date, dia, (diaAbreviado == 'Mon'? 'lun':(diaAbreviado == 'Tue'? 'mar':(diaAbreviado == 'Wed'? 'mie':
(diaAbreviado == 'Thu'? 'jue':(diaAbreviado == 'Fri'? 'vie':(diaAbreviado == 'Sat'? 'sab':(diaAbreviado == 'Sun'? 'dom':'falso'))))))) as diaAbreviado,
(nombre_dia == 'Monday'? 'lunes':(nombre_dia == 'Tuesday'? 'martes':(nombre_dia == 'Wednesday'? 'miercoles':
(nombre_dia == 'Thursday'? 'jueves':(nombre_dia == 'Friday'? 'viernes':(nombre_dia == 'Saturday'? 'sabado':(nombre_dia == 'Sunday'? 'domingo':'falso'))))))) as diaCompleto;

STORE sol INTO 'output' USING PigStorage(',');
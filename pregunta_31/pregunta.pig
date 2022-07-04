/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

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

date_1 = FOREACH data GENERATE ToDate(date, 'yyyy-MM-dd') AS date2;
date_2 = GROUP date_1 BY ToString(date2, 'yyyy');
sol = FOREACH date_2 GENERATE group, COUNT(date_1);

STORE sol INTO 'output' USING PigStorage(',');
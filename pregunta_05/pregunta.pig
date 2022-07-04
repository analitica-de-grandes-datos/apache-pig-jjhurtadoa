/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
data = LOAD 'data.tsv' USING PigStorage('\t')
  AS (

        col_1:chararray,
        col_2:bag{t: tuple(p:chararray)},
        col_3:map[]

);


regs = FOREACH data GENERATE FLATTEN(col_2) AS col_2;
groups = GROUP regs BY col_2;
count = FOREACH groups GENERATE group, COUNT(regs);
STORE count INTO 'output' USING PigStorage (',');
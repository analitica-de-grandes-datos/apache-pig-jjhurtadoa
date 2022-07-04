/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

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


regs = FOREACH data GENERATE FLATTEN(col_3) AS col_3;
groups = GROUP regs BY col_3;
count = FOREACH groups GENERATE group, COUNT(regs);
STORE count INTO 'output' USING PigStorage (',');

# Práctico Nº 3 – Estructuras de Control: T-SQL - Cursores - Transacciones 


**F) Instrucciones con Estructuras de Control Transact-SQL (IF, ELSE,...DECLARE, SET, )**

***Asignado a:*** Ivasiuta

**f.1)** Modificar los SP de tps anteriores, para que implementen los controles necesarios de integridad (verificar que no exista el registro, generar un siguiente nro de Id, etc.) antes de Realizar las Operaciones de (Ins, Upd, Del), y generar Msg de error, capturar err o datos en parámetros output (salida en el SP), lanzar excepciones (msg), (err) según error capturado / generado, invocar / ejecutar otro SP anidado, etc.- (utilizar estructuras de control de T-SQL).-

**f.2)** Escribir los SP con Instrucciones T-SQL necesarios para realizar y garantizar la correcta y  completa operatoria de un Proceso de TRANSFERENCIA entre 2 CUENTAS ( controlando y previendo absolutamente todo), 
SP_DEBITO (cuenta origen, monto, fecha, codOp, etc.)
SP_CREDITO (cuenta destino, monto, fecha, codOp, etc.)
SP_TRANSFERENCIA ( cuenta_origen, Cuenta_destino, monto, fecha, codOp1, CodOp2, .. etc.)

**Considerar:**  
- SP Completamente Parametrizado
- Controlar existencia de ambas cuentas
- Si el Saldo es suficiente
- Garantizar con transacciones las operaciones de debito / credito por separado
- Registrar los Movimientos
- Generar el registro de Auditoria
- Verificar valores variable @error
- Invocar internamente la ejecución de otros SP, como (SP_DEBITO, SP_CREDITO), según corresponda el caso, Etc.

**f.3) implemente mediante CASE, WHEN**

**f.3.a)** Un sp con parametro de entrada: nr cuenta,  y que devuelva un mensaje diciendo de que tipo 
es la cuenta, en base al “tipo de cuenta”: cta. Cte, caja ahorro,  realizando la selección mediante 
CASE

**f.3.b)** Realizar un SP, que clasifique las cuentas por su saldo en alguna de las 3 posibilidades: 
“saldo bajo” < de 10.000 $, “saldo medio” : entre 10.000 y 50.000,y/o “saldo alto”: > a 50.000),  informando con dichos mensajes, en base al rango donde se encuadre el saldo de cada cuenta. respectivamente.

**G) Implementar las soluciones a los siguientes casos,**

***Asignado a:*** Mior

Realizarlo en algun tipo de objeto que considere (vista, proced. Almacenado, disparador), utilizando las instrucciones y estructuras de control y utilizando las variables del sistema @, o @@ o definiendo las propias, como tambien los parámetros de entrada y salida:

**g.1-** Actualizar el saldo de una cuenta en cierto %

**g.2-** Modificar el domicilio de un cliente x

**g.3-** Obtener todas las cuentas pertenecientes a un cliente x

**g.4-** Obtener la suma de los saldos de todas las cuentas de un cliente x

**g.5-** Obtener el nombre de la ciudad y provincia donde se encuentra la sucursal que tiene registrada la cuenta nr. X

**g.6-** Calcular y mostrar el monto total (o suma) , en concepto de extracciones realizadas sobre una cuenta x, durante los ultimos n dias.

**g.7-** Obtener los ultimos n movimientos sobre la cuenta x, agrupados por tipoOp

**g.8-** incrementar en un valor x%, el sueldo de los empleados en base a su categoria

- Implementar todo sobre la Base de datos, entregar el archivo de datos, backup y log.
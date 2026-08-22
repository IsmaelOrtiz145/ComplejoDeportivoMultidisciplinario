# Decisiones de Diseño

## DD-001 Historial de membresia

Todo usuario tiene que tener si o si asociado una membresia (plan) activa, de tal forma, que la multiplicidad entre usuaria y membresia es de 1:N, tambien permitiendo mantener un historial de todas las membresias por las que paso el usuario.
Ademas tambien existe una relacion de plan a membresia (con relacion 1:N) para registrar cual es el plan que tiene o tuvo activo en un determinado momento.

## DD-002 Asociacion de equipamiento a sector

Los equipamientos (tantos los operativos como prestables) se relacionan directamente con sector y no con una instalacion para poder permitir que un mismo equipamiento pueda ser reutilizado en distintas instalaciones pertenecientes al mismo sector

## DD-003 Entidad pago

En el dominio del problema existe una sola tabla pago para relacionarse con las entidades que requieran de una transaccion monetaria y dicha tabla de pagos tendra atributos generales correspondientes a todos los pagos
A su vez la relaciones van a partir desde la entidad que tiene asociado un pago (a traves de un id_pago) hacia la entidad Pago.

## DD-004 Detalle Reserva

El proposito de esta entidad es poder registrar que para un determinado turno y para un determinado usuario, cuales seran los equipamientos prestables que se asociaran a los mismo y poder llevar un registro del mismo.

## DD-005 Separacion de tipos de equipamientos

Se decidio separa los tipos de equipamientos entre operativos y prestables, ya que cumplen con un rol diferente dentro del dominio.

## DD-006 Pago unico

Para estas primeras etapas del proyecto se va a decidir que solo se van a aceptar un solo pago unico por cada operacion monetaria, es decir, no se va a contemplar el pago en cuotas.

## DD-007 Duracion del plan gratis

El plan gratis afectara de la siguiente manera en el dominio:
- Dentro de la entidad Planes la duracion_dias va a ser 0, siendo cero el indicador de que no tiene vencimiento el plan
- Dentro de la entidad membresia, aquellas membresias activas que sean del plan gratuito, no deben tener una fecha_fin cargada, a su vez no deberan tener asociado un id_pago.

## DD-008 Tolerancia maxima

El porqué de la existencia del atributo tolerancia_maxima en estacionamiento se debe simplemente a que un usuario va a poder ingresar al estacionamiento por X minutos y si se retira antes de superar esos minutos no debera pagar ningun monto.

## DD-009 Check de capacidad maxima de estacionamiento

Dentro de la entidad estacionamiento al momento de crear un estacionamiento nuevo o modificar uno existente, este va a poder registrar como parametro de capacidad_maxima igual a 0, con el fin de que sistema tenga una medida de seguridad (ademas del estado) para prohibir la entrada de algun vehiculo.

## DD-010 Patente NULL

En la entidad Registro Estacionamiento se va a poder registrar un vehiculo sin patente, y estos estan orientados para aquellos vehiculos que no lleven una patente como tal, pudiendo ser un ejemplo de ello las bicicletas.

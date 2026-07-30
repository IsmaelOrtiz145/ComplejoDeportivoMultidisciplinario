# ✔ Reglas de Validación

## RN-001 – Beneficio de Reserva

### Condicion

Antes de permitir la creación de una reserva con beneficios de socio, el sistema deberá verificar el estado de la membresía del usuario.

#### Validacion

- Si el estado del plan se encuentra en ***ABONADO***, se activarán los beneficios correspondientes.
- Para cualquier otro estado que no sea ***ABONADO***, no estarán disponible los beneficios correspondientes

## RN-002 – Caducidad del plan

### Condicion

Al momento de terminar el quito (5) dial del mes, el sistema verificara el estado del plan de cada socio que haya solicitado el plan mensual
O al momento de que se cumpla el primer mes del plan anual, el sistema verificara el estado del mismo para cada socio con dicho plan

#### Validacion

- Si el estado del plan se encuentra en ***FALTA_PAGO***, el estado del mismo pasará a ***SUSPENDIDO***
- Si el estado del plan se encuentra en ***ABONADO***, no se modificará el estado del plan

## RN-003 - Cancelacion de subscripcion

## Condicion

Al momento de solicitar la devolucion del plan, el sistema tendra que verificar que de tipo de plan se trata y los dias que pasaron desde que se adquirio

#### Validacion

- Si se trata de plan mensual, el sistema debera obtener la fecha de pago y controlar que al momento de solicitar su devolucion, este se encuentre dentro de los primeros 10 dias de haber realizado el pago
-Si se trata del plan anual, el sistema debera obtener la fecha de pago y controlar que al momento de solicitar su devolucion, se encuentre dentro del primer mes de haber realizado el pago

## RN-004 - Acceso al estacionamiento gratuito

### Condicion

Al momento de ingresar al estacionamiento el sistema validara cual es el plan vigente que posee el cliente que entrege su ID

#### Validacion

- Si el tipo de plan ingresado es alguno correspondiente a un plan premium, el estacionamiento tendra un tiempo de validez el cual no se cobrara al momento de su salida
- Si el tipo de plan es ***INVITADO***, se cobrara la tarifa correspondiente al momento de su salida.

## RN-005 Ingreso al estacionamiento

### Condicion

Al momento del ingreso de algun vehiculo al estacionamiento, este debera verificar el estado de ocupacion del mismo, para permitir o no el ingreso del mismo

#### Validacion

- Si la capacidad de ocupacion actual es igual a la capacidad maxima, no se autorizara el ingreso vehicular al estacionamiento
- Si la capacidad de ocupacion es menor a la capacidad maxima, se autorizara el ingreso vehicular al estacionamiento

## RN-006 Tiempo de beneficio gratuito del estacionamiento

### Condicion

Al momento de la salida del vehiculo de estacionamiento, se verificara la hora de ingreso y salida si es que posee el beneficio del estacionamiento gratuito
Aqui se aplicara la validacion de la RN-004 Acceso al estacionamiento gratuito

#### Validacion

- Si el cliente posee el beneficio, el sistema debera encontrar el ultimo turno ya realizado del cliente y compara la que la hora del ingreso del vehiculo se encuentre dentro de los 30 minutos antes del turno, asi como tambien controlara que la hora de salida se encuentre dentro de los primeros 30 minutos pasado el turno, en caso de ser correcto, no se cobrara el estacionamiento del mismo
- Si el cliente posee el beneficio, el sistema debera encontrar el ultimo turno ya realizado del cliente y compara la que la hora del ingreso del vehiculo se encuentre dentro de los 30 minutos antes del turno, asi como tambien controlara que la hora de salida se encuentre dentro de los primeros 30 minutos pasado el turno, en caso de ser haber ingresado antes o haber salido despues, se cobrara un recargo por el tiempo extra

## RN-007 Requisito de logueo para reserva

### Condicion

Para poder confirmar la reserva, el sistema validara que el usuario este logueado

#### Validacion

- Al momento de confirmar una reserva, el sistema verificara que se encuentre un usuario logueado, si lo encuentra, confirmara la reserva (sujeto a la regla de negocio de maximas reservas disponibles), caso contrario, lo mandara a la pagina de logueo.
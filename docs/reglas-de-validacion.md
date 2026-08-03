# ✔ Reglas de Validación

## RN-001 – Beneficio de Reserva

### Condicion

Antes de permitir la creación de una reserva con beneficios de socio, el sistema deberá verificar el estado de la membresía del usuario.

#### Validacion

- Si el estado del plan se encuentra en ***ABONADO***, se activarán los beneficios correspondientes.
- Para cualquier otro estado que no sea ***ABONADO***, no estarán disponible los beneficios correspondientes

## RN-002 – Caducidad del plan

### Condicion

Al momento de terminar el quinto (5) dial del mes, el sistema verificara el estado del plan de cada socio que haya solicitado el plan mensual
O al momento de que se cumpla el primer mes del plan anual, el sistema verificara el estado del mismo para cada socio con dicho plan, pasando al plan ***GRATIS*** como activo

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

## RN-008 Propietario de la reserva

### Condicion

Para guardar los datos de la reserva, el sistema debera tomar el id de cliente para asociarla a la misma

#### Validacion

- Cuando el usuario confirma la reserva y este se encuentre logueado (se cumple correctamente las RN-007 y la regla de negocio de las tres reservas), el sistema debera tomar el id del usuario logueado y registrarlo en la misma.

## RN-009 Tiempo limite de cancelacion

### Condicion

El sistema debera controlar las horas restantes para el turno que se desee cancelar y en base a eso se aplicara o no una multa del 50% del valor.

#### Validacion

- Cuando el usuario desea dar de baja un turno y este lo confirma, el sistema debera controlar a que hora y dia estaba reservado ese turno y lo comparara con la hora actual del sistema, si faltan mas de 24 horas, no se aplicara ninguna sancion, caso contrario, se aplicara un recargo del 50% del valor de la reserva para la siguiente cuota que deba abonar

## RN-010 Maximas reservas disponibles

### Condicion

El sistema debera validar que al momento de confirmar una reserva, el usuario que lo solicite no deba superar dos reservas activas al momento

#### Validacion

- Cuando el usuario confirme la reserva, el sistema buscara la cantidad de reservas con estado ***RESERVADO***, y si el numero es menor a 3, se confirmara la reserva, caso contrario, no se podra realizar la reserva

## RN-011 Tolerancia de cancelacion para una reserva

### Condicion

Cuando el usuario cancele una reserva en menos de 24 horas para que se inicie, el sistema validara si tiene tolerancias disponibles y en base a eso se aplicara o no la multa, ademas tendra que controlar que el plan correspondiente sea el anual

#### Validacion

- Al momento de registrarse una cancelacion a menos de 24 horas de la reserva, el sistema verificara cual es el plan que dispone el usuario (y este es el plan anual), seguidamente, controlara si posee alguna tolerancia disponible (tolerancia > 0), en caso de poseerlo descontara en 1 la tolerancia disponible y no se sumara el costo adicional por cancelacion a la cuota del socio. Si no posee tolerancia, el sistema calculara el 50% del costo y lo sumara a la couta del socio que haya realizado la reserva.

## RN-012 Acceso al calendario de reserva

### Condicion

Al momento de mostrar el calendario para poder seleccionar un turno para reservar, el sistema mostrada la cantidad de fechas disponibles segun el estado del plan

#### Validacion

- Cuando un usuario quiere realizar una reserva o consultar las fechas disponibles, el sistema controlara el plan que posee la cuente, si el plan que posee es distinto al plan gratuito podra realizar una reserva incluso pasada las dos semanas desde la fecha actual, caso contrario, solo podra realizar una reserva dentro de las primeras dos semanas

## RN-013 Duracion del turno

### Condicion

Cuando se selecciona un turno para reservar, el sistema mostrara automaticamente el tiempo que puede seleccionar

#### Validacion

- El sistema al momento de seleccionar un hueco disponible para la reserva, este mostrara de forma automatica la seleccion de cantidad de horas disponibles para poder reservar (1 o 2 horas si la hora siguiente sigue sin turno)

## RN-014 Cancelacion por clima

### Condicion

Para los dias de lluvia el sistema debera ser capaz de poder suspender los turnos que no sean aptos para dicho clima

#### Validacion

El sistema debera buscar en las instalaciones el atributo apta_lluvia y/o es_techada y controlar que su valor boolenano sea false, seguido debera buscar en los turnos aquellos que sean correspondiente al dia actual y que no se hayan realizado/empezado y proceder a cancelar la misma

## RN-015 Devolucion de turnos cancelado

### Condicion

Para aquellos turnos cancelados, el sistema debera permitir la reasignacion o la cancelacion del mismo sin costo

#### Validacion

Al momento del que el cliente es notificado de la cancelacion del mismo, el sistema debera controlar que el estado de la reserva sea ***SUSPENDIDO*** y poder permitirle la reasignacion del mismo para otro turno sin asignar o cancerlar el mismo

## RN-016 Cancelacion de turno en curso

### Condicion

Cuando se cancela un turno en curso, el sistema debera permitir la reasignacion del turno, devolucion del mismo o el cobro del 50% segun el tiempo transcurrido

#### Validacion

Cuando el estado de un turno en curso (es decir, que la hora de actual del sistema, se encuentre entre la hora de inicio y fin del turno o directamente controlar el estado del turno como ***EN CURSO***), el sistema debera controlar si se trata de un turno de 1 o 2 horas y ademas controlar si paso ya la mitad del turno y en base a eso:
- En caso de haber pasado la mitad del turno, el sistema debera registrar el costo del mismo al 50% del valor original
- En caso de que no se cumplio la primera mitad, el sistema debera mostrar la opcion para reasignar el turno o simplemente registrar el valor del turno a sin costo si lo deseara el cliente.
Ademas debera registrar el estado del turno como ***CANCELADO***

## RN-017 Ausencia en un turno

### Condicion

El sistema controlara que al momento de haber pasado 15 minutos de haber comenzado un turno, el estado del mismo

#### Validacion

Una vez pasado los 15 minutos, el sistema debera controlar el estado del turno en curso
- Si el estado de la reserva es ***ESPERANDO***,el sistema cancelara el turno y cobrara el 100% del valor al usuario titular del turno
- Para cualquier otro estado, se seguira segun el estado correspondiente al que se encuentre

## RN-018 Acceso al gimansio o piletas techadas

### Condicion

Al momento del ingreso al gimansio o a una pileta techada, el sistema validara el plan activo del socio

#### Validacion

El sistema controlara el estado del plan vigente del usuario
- Si el mismo es uno distinto al ***GRATIS***, el sistema debera poder permitirle el acceso al mismo, caso contrario, se le debera denegar el acceso a la instalacion

## RN-019 Prestamo de Equipamiento gratuito

### Condicion

Al inicio del turno, se podra solicitar el uso de algun equipamiento prestable si lo deseara el usuario

#### Validacion

Cuando se confirma el prestamo de un equipamiento el sistema debera controlar que el turno este registrado y asignara como responsable del equipamiento al usuario que solicito el prestamo

## RN-020 Devolucion del equipamiento en mal estado

### Condicion

Al finalizar el turno el sistema debe confirmar la devolucion del equipamiento y el estado en que se delvolvio el mismo

#### Validacion

Si presenta daños por culpa de un mal uso del cliente, se debe registrar el equipamiento como ***DAÑADO*** y debera sumarle al turno el costo de reparacion del mismo.

## RN-021 Descuentos por socios activos

### Condicion

Al finalizar el turno, el sistema debera permitir ingresar id de usuarios con plan de pagos y calcular un descuento para el pago de la reserva

#### Validacion

El sistema por cada id de usuario ingresado debera fijarse cual es el plan que posee activo controlando que sea uno de pago y en base a eso debera aplicar el descuento correspondiente al valor del turno
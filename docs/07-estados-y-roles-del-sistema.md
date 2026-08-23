# Estados y Roles del Sistema

Este documento define los estados y roles utilizados por las entidades del sistema y su significado dentro del dominio.


---

## 1. Estados de Usuario

Un usuario puede encontrarse en uno de los siguientes estados:

- HABILITADO
- SUSPENDIDO
- INHABILITADO
- PENDIENTE_VERIFICACION

### HABILITADO

El usuario puede acceder al sistema y hacer uso del complejo según los permisos correspondientes a su rol.

### SUSPENDIDO

El usuario incumplió alguna norma y no puede hacer uso del complejo durante un determinado período de tiempo.

### INHABILITADO

El usuario no puede acceder al complejo.

### PENDIENTE_VERIFICACION

El usuario se registró por su propia cuenta, pero todavía falta confirmar su identidad, por ejemplo mediante la confirmación de su correo electrónico.

---

## 2. Estados de Membresía

Una membresía puede encontrarse en uno de los siguientes estados:

- ACTIVO
- FALTA_DE_PAGO
- CONCLUIDO
- CANCELADO

### ACTIVO

Es el plan vigente que posee un usuario.

### FALTA_DE_PAGO

Es un plan de pago que todavía no ha sido abonado, pero que se encuentra dentro de los días de gracia establecidos según el plan.

### CONCLUIDO

La membresía llegó a su fecha de finalización.

### CANCELADO

La membresía finalizó antes de su fecha de finalización.

Puede producirse porque el usuario dio de baja su plan o porque no realizó el pago dentro del plazo establecido en las reglas de negocio.

En caso de corresponder, el usuario pasará a tener activo el Plan Gratuito.

---

## 3. Estados de Pago

Un pago puede encontrarse en uno de los siguientes estados:

- PENDIENTE
- RECHAZADO
- PAGADO

### PENDIENTE

El pago todavía no se realizó, pero se encuentra dentro de un período válido para efectuarlo.

### RECHAZADO

El pago no se pudo concretar.

### PAGADO

El pago fue realizado y confirmado correctamente.

---

## 4. Estados de Reserva

Una reserva puede encontrarse en uno de los siguientes estados:

- CONFIRMADA
- EN_ESPERA
- EN_CURSO
- COMPLETADA
- SUSPENDIDA
- AUSENCIA
- CANCELADA

### CONFIRMADA

Es el estado inicial de una reserva una vez que esta fue registrada correctamente.

### EN_ESPERA

La reserva llegó a su hora de inicio, pero todavía no se encuentran presentes los integrantes de la misma.

El estado se mantiene durante el período de tolerancia establecido para la espera antes de registrar la ausencia del turno.

### EN_CURSO

La reserva se encuentra actualmente en desarrollo.

### COMPLETADA

La reserva se realizó de forma normal y llegó correctamente a su finalización.

### SUSPENDIDA

La reserva fue suspendida debido a factores externos al cliente, como condiciones climáticas adversas, desperfectos u otros problemas que impidan continuar utilizando la instalación.

### AUSENCIA

La reserva estaba confirmada, pero los integrantes de la misma no se presentaron dentro del período de tolerancia establecido.

### CANCELADA

La reserva fue cancelada antes de haber comenzado el turno.

---

## 5. Estados de Instalación

Una instalación puede encontrarse en uno de los siguientes estados:

- HABILITADA
- INHABILITADA
- EN_MANTENIMIENTO
- FUERA_SERVICIO

### HABILITADA

Estado que permite que una instalación se encuentre disponible para realizar reservas.

### INHABILITADA

Estado en el que una instalación no puede ser utilizada por diversos motivos, como condiciones climáticas u otras circunstancias que impidan temporalmente su utilización.

### EN_MANTENIMIENTO

Estado en el que una instalación se encuentra debido a que requiere algún tipo de mantenimiento o cuidado, quedando temporalmente sin posibilidad de realizar nuevas reservas.

### FUERA_SERVICIO

Estado de una instalación que ha llegado al final de su vida operativa y ya no se encuentra disponible para su utilización.

---

## 6. Estados de Sector

Un sector puede encontrarse en uno de los siguientes estados:

- HABILITADA
- INHABILITADA
- EN_MANTENIMIENTO
- FUERA_SERVICIO

### HABILITADA

Estado que permite que las instalaciones pertenecientes al sector puedan encontrarse disponibles para su utilización.

### INHABILITADA

Estado en el que el sector no puede ser utilizado por diversos motivos.

### EN_MANTENIMIENTO

Estado en el que el sector se encuentra debido a que requiere algún tipo de mantenimiento o reparación.

Por ejemplo, una rotura de una tubería que requiera realizar trabajos en toda la zona puede provocar que el sector completo quede temporalmente inhabilitado, aunque algunas de sus instalaciones no presenten desperfectos directamente.

### FUERA_SERVICIO

Estado en el que el sector ha llegado al final de su vida operativa y ya no se encuentra disponible para su utilización.

---

## 7. Estados de Equipamiento Operativo

Un equipamiento operativo puede encontrarse en uno de los siguientes estados:

- OPERATIVO
- FUERA_SERVICIO

### OPERATIVO

Indica que el modelo de equipamiento puede ser adquirido y utilizado en las instalaciones.

### FUERA_SERVICIO

Indica que el modelo se encuentra obsoleto y ya no se adquieren ni registran nuevos ítems de este tipo.

---

## 8. Estados de Equipamiento Prestable

Un equipamiento prestable puede encontrarse en uno de los siguientes estados:

- OPERATIVO
- FUERA_SERVICIO

### OPERATIVO

Indica que el modelo de equipamiento puede ser adquirido y utilizado como equipamiento prestable.

### FUERA_SERVICIO

Indica que el modelo se encuentra obsoleto y ya no se adquieren ni registran nuevos ítems de este tipo.

---

## 9. Estados de Item de Equipamiento Prestable

Un item de equipamiento prestable puede encontrarse en uno de los siguientes estados:

- DISPONIBLE
- PRESTADO
- EN_MANTENIMIENTO
- INOPERATIVO
- FUERA_SERVICIO

### DISPONIBLE

El item se encuentra disponible para ser prestado a un cliente.

### PRESTADO

El item se encuentra actualmente prestado a un cliente.

### EN_MANTENIMIENTO

El item se encuentra en un proceso de reparación, limpieza u otro tipo de mantenimiento.

### INOPERATIVO

El item presenta algún daño o problema que requiere mantenimiento, pero el proceso de mantenimiento todavía no comenzó.

### FUERA_SERVICIO

El item presenta daños permanentes que provocan que quede fuera de servicio.

---

## 10. Estados de Item de Equipamiento Operativo

Un item de equipamiento operativo puede encontrarse en uno de los siguientes estados:

- OPERATIVO
- EN_USO
- INOPERATIVO
- EN_MANTENIMIENTO
- FUERA_SERVICIO

### OPERATIVO

El item se encuentra disponible para su utilización en alguna instalación perteneciente al sector.

### EN_USO

El item está siendo utilizado actualmente en alguna instalación perteneciente al sector.

### INOPERATIVO

El item presenta algún daño o problema que requiere mantenimiento, pero el proceso de mantenimiento todavía no comenzó.

### EN_MANTENIMIENTO

El item se encuentra en reparación, limpieza u otro tipo de mantenimiento.

### FUERA_SERVICIO

El item presenta daños permanentes que provocan que quede fuera de servicio.

---

## 11. Estados de Detalle de Reserva

Un detalle de reserva puede encontrarse en uno de los siguientes estados:

- PRESTADO
- DEVUELTO
- DEVUELTO_CON_OBSERVACIONES
- NO_DEVUELTO

### PRESTADO

El item fue prestado a un cliente durante su reserva.

### DEVUELTO

El item fue devuelto correctamente por el cliente.

### DEVUELTO_CON_OBSERVACIONES

El item fue devuelto, pero presenta daños, desgaste o faltantes.

Esta situación puede generar un recargo por reparación o reposición de acuerdo con las reglas de negocio.

### NO_DEVUELTO

El item todavía no fue devuelto por el cliente.

---

## 12. Roles del Sistema

El sistema contará con tres roles principales: CLIENTE, OPERADOR y ADMINISTRADOR.

### CLIENTE

Usuario que utiliza el complejo y gestiona sus propias operaciones dentro del sistema.

**Permisos principales:**

- Registrarse.
- Loguearse.
- Controlar y gestionar su perfil.
- Consultar y gestionar su membresía.
- Crear reservas.
- Gestionar sus propias reservas.
- Consultar su historial de reservas.

### OPERADOR

Usuario encargado de realizar las operaciones relacionadas con la atención y gestión diaria del complejo.

**Permisos principales:**

- Realizar el check-in de las reservas.
- Gestionar préstamos de equipamiento.
- Registrar ingresos y egresos del estacionamiento.
- Acceder al calendario de reservas.
- Consultar perfiles de usuarios.

### ADMINISTRADOR

Usuario encargado de la administración general y configuración del sistema.

**Permisos principales:**

- Realizar operaciones CRUD sobre las entidades del sistema.
- Gestionar roles.
- Configurar planes.
- Configurar precios.
- Cambiar los estados de los usuarios.

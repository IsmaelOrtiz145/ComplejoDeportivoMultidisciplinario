CREATE TABLE Planes (
	id_plan SERIAL PRIMARY KEY,
	nombre varchar(50) NOT NULL UNIQUE,
	descripcion TEXT NOT NULL,
	duracion_dias INTEGER NOT NULL DEFAULT 0 CHECK (duracion_dias >= 0),
	costo NUMERIC(12, 2) NOT NULL CHECK (costo >= 0),
	dias_tolerancia_cancelacion INTEGER NOT NULL CHECK (dias_tolerancia_cancelacion >= 0)
);

CREATE TABLE Usuarios (
	id_usuario SERIAL PRIMARY KEY,
	rol TEXT NOT NULL DEFAULT 'CLIENTE' CHECK(rol IN('CLIENTE', 'OPERADOR', 'ADMINISTRADOR')),
	nombre TEXT NOT NULL,
	apellido TEXT NOT NULL,
	dni TEXT NOT NULL UNIQUE,
	telefono TEXT NOT NULL,
	correo TEXT NOT NULL UNIQUE,
	password_hash TEXT NOT NULL,
	fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	fecha_fin_suspension TIMESTAMP,
	motivo_inhabilitacion TEXT,
	fecha_inhabilitacion TIMESTAMP,
	estado TEXT NOT NULL DEFAULT 'HABILITADO' CHECK(estado IN('HABILITADO', 'SUSPENDIDO', 'INHABILITADO', 'PENDIENTE_VERIFICACION'))
);

CREATE TABLE Medios_Pago(
	id_medio_pago SERIAL PRIMARY KEY,
	nombre TEXT NOT NULL UNIQUE,
	descripcion TEXT NOT NULL
);

CREATE TABLE Pagos(
	id_pago SERIAL PRIMARY KEY,
	id_medio_pago INTEGER NOT NULL,
	fecha_pago TIMESTAMP NOT NULL,
	monto NUMERIC(12, 2) NOT NULL CHECK(monto > 0),
	estado TEXT NOT null check(estado IN('PENDIENTE', 'RECHAZADO', 'PAGADO')),
	referencia_transaccion TEXT NOT NULL UNIQUE,
	observaciones TEXT,

	CONSTRAINT fk_pago_medio
		FOREIGN KEY (id_medio_pago) REFERENCES Medios_Pago(id_medio_pago) on delete restrict on update cascade
);

CREATE TABLE Membresias (
	id_membresia SERIAL PRIMARY KEY,
  	id_plan INTEGER NOT NULL,
  	id_usuario INTEGER NOT NULL,
  	id_pago INTEGER,
  	fecha_inicio TIMESTAMP NOT NULL,
  	fecha_fin TIMESTAMP CHECK (fecha_fin IS NULL OR fecha_fin > fecha_inicio),
  	estado TEXT NOT NULL CHECK(estado IN('ACTIVO', 'CONCLUIDO', 'FALTA_DE_PAGO', 'CANCELADO')),
  	fecha_cancelacion TIMESTAMP,

 	CONSTRAINT fk_usuario
    	FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) on delete restrict on update cascade,

  	CONSTRAINT fk_plan
    	FOREIGN KEY (id_plan) REFERENCES Planes(id_plan) on delete restrict on update cascade,

 	CONSTRAINT fk_pago
    	FOREIGN KEY (id_pago) REFERENCES Pagos(id_pago) on delete restrict on update cascade
);

CREATE TABLE Estacionamientos (
	id_estacionamiento SERIAL PRIMARY KEY,
	capacidad_maxima INTEGER NOT NULL DEFAULT 0 CHECK(capacidad_maxima >= 0),
	ubicacion TEXT NOT NULL,
	tolerancia_maxima_minutos INTEGER NOT NULL DEFAULT 0 CHECK(tolerancia_maxima_minutos >= 0)
);

CREATE TABLE Registros_Estacionamiento (
	id_registro_estacionamiento SERIAL PRIMARY KEY,
	id_usuario INTEGER NOT NULL,
	id_estacionamiento INTEGER NOT NULL,
	id_pago INTEGER,
	fecha_ingreso TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	fecha_salida TIMESTAMP,
	tipo_vehiculo TEXT NOT NULL CHECK(tipo_vehiculo IN('AUTOMOVIL', 'MOTO', 'BICICLETA')),
	patente TEXT,

	CONSTRAINT fk_usuario_estacionamiento
		FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) on delete restrict on update cascade,

	CONSTRAINT fk_registro_estacionamiento
		FOREIGN KEY (id_estacionamiento) REFERENCES Estacionamientos(id_estacionamiento) on delete restrict on update cascade,

	CONSTRAINT fk_pago_estacionamiento
		FOREIGN KEY (id_pago) REFERENCES Pagos(id_pago) on delete restrict on update cascade
);

CREATE TABLE Sectores(
	id_sector SERIAL PRIMARY KEY,
	nombre TEXT NOT NULL UNIQUE,
	descripcion TEXT NOT NULL,
	estado TEXT NOT NULL CHECK(estado IN('HABILITADO', 'INHABILITADO', 'EN_MANTENIMIENTO', 'FUERA_SERVICIO'))
);

CREATE TABLE Equipamientos_Operativo(
	id_equipamiento_operativo SERIAL PRIMARY KEY,
	id_sector INTEGER NOT NULL,
	nombre TEXT NOT NULL,
	descripcion TEXT NOT NULL,
	marca TEXT NOT NULL,
	modelo TEXT NOT NULL,
	estado TEXT NOT NULL CHECK(estado  IN('OPERATIVO', 'FUERA_SERVICIO')),
	
	CONSTRAINT uq_equipamiento_operativo_marca_modelo
    	UNIQUE (marca, modelo),

	CONSTRAINT fk_equipamiento_operativo_sector
		FOREIGN KEY (id_sector) REFERENCES Sectores(id_sector) on delete restrict on update cascade
);

CREATE TABLE Equipamientos_Prestable(
	id_equipamiento_prestable SERIAL PRIMARY KEY,
	id_sector INTEGER NOT NULL,
	nombre TEXT NOT NULL,
	descripcion TEXT NOT NULL,
	marca TEXT NOT NULL,
	modelo TEXT NOT NULL,
	estado TEXT NOT NULL CHECK(estado  IN('OPERATIVO', 'FUERA_SERVICIO')),
	
	CONSTRAINT uq_equipamiento_prestable_marca_modelo
    	UNIQUE (marca, modelo),

	CONSTRAINT fk_equipamiento_prestable_sector
		FOREIGN KEY (id_sector) REFERENCES Sectores(id_sector) on delete restrict on update cascade
);

CREATE TABLE Items_Equipamiento_Operativo(
	id_item_operativo SERIAL PRIMARY KEY,
	id_equipamiento_operativo INTEGER NOT NULL,
	estado TEXT NOT null check(estado in('OPERATIVO', 'EN_USO', 'INOPERATIVO', 'EN_MANTENIMIENTO', 'FUERA_SERVICIO')),
	codigo_inventario TEXT NOT NULL UNIQUE,

	CONSTRAINT fk_item_operativo
		FOREIGN KEY (id_equipamiento_operativo) REFERENCES Equipamientos_Operativo(id_equipamiento_operativo) on delete restrict on update cascade
);

CREATE TABLE Items_Equipamiento_Prestable(
	id_item_prestable SERIAL PRIMARY KEY,
	id_equipamiento_prestable INTEGER NOT NULL,
	valor_reposicion NUMERIC(12, 2) NOT NULL CHECK(valor_reposicion >= 0),
	estado TEXT NOT null check (estado in('DISPONIBLE', 'PRESTADO', 'EN_MANTENIMIENTO', 'INOPERATIVO', 'FUERA_SERVICIO')),
	codigo_inventario TEXT NOT NULL UNIQUE,

	CONSTRAINT fk_item_prestable
		FOREIGN KEY (id_equipamiento_prestable) REFERENCES Equipamientos_Prestable(id_equipamiento_prestable) on delete restrict on update cascade
);

CREATE TABLE Instalaciones(
	id_instalacion SERIAL PRIMARY KEY,
	id_sector INTEGER NOT NULL,
	nombre TEXT NOT NULL,
	capacidad_maxima INTEGER NOT NULL CHECK(capacidad_maxima >= 1),
	es_techada BOOLEAN NOT NULL,
	apta_lluvia BOOLEAN NOT NULL,
	estado TEXT NOT NULL CHECK(estado IN('HABILITADA', 'INHABILITADA', 'EN_MANTENIMIENTO', 'FUERA_SERVICIO')),
	precio_hora NUMERIC(12, 2) NOT NULL CHECK(precio_hora >= 0),

	CONSTRAINT fk_instalacion_sector
		FOREIGN KEY (id_sector) REFERENCES Sectores(id_sector) on delete restrict on update cascade
);

CREATE TABLE Reservas(
	id_reserva SERIAL PRIMARY KEY,
	id_instalacion INTEGER NOT NULL,
	id_usuario INTEGER NOT NULL,
	id_pago INTEGER,
	fecha DATE NOT NULL,
	hora_inicio TIME NOT NULL,
	hora_fin TIME NOT NULL CHECK(hora_fin > hora_inicio),
	estado TEXT NOT null CHECK(estado IN('CONFIRMADA', 'EN_ESPERA', 'EN_CURSO', 'COMPLETADA', 'SUSPENDIDA', 'AUSENCIA', 'CANCELADA')),
	precio_final NUMERIC(12, 2) NOT NULL CHECK(precio_final >= 0),
	fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT fk_reserva_instalacion
		FOREIGN KEY (id_instalacion) REFERENCES Instalaciones(id_instalacion) on delete restrict on update cascade,

	CONSTRAINT fk_reserva_usuario
		FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) on delete restrict on update cascade,

	CONSTRAINT fk_reserva_pago
		FOREIGN KEY (id_pago) REFERENCES Pagos(id_pago) on delete restrict on update cascade
);

CREATE TABLE Detalles_Reserva(
	id_detalle_reserva SERIAL PRIMARY KEY,
	id_reserva INTEGER NOT NULL,
	id_item_prestable INTEGER NOT NULL,
	id_pago INTEGER,
	id_usuario INTEGER NOT NULL,
	estado_devolucion TEXT NOT null check(estado_devolucion in('PRESTADO', 'DEVUELTO', 'DEVUELTO_CON_OBSERVACIONES', 'NO_DEVUELTO')),
	fecha_prestamo TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	observaciones TEXT,
	fecha_devolucion TIMESTAMP,

	CONSTRAINT fk_detalle_reserva
		FOREIGN KEY (id_reserva) REFERENCES Reservas(id_reserva) on delete restrict on update cascade,

	CONSTRAINT fk_detalle_item
		FOREIGN KEY (id_item_prestable) REFERENCES Items_Equipamiento_Prestable(id_item_prestable) on delete restrict on update cascade,

	CONSTRAINT fk_detalle_pago
		FOREIGN KEY (id_pago) REFERENCES Pagos(id_pago) on delete restrict on update cascade,

	CONSTRAINT fk_detalle_usuario
		FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) on delete restrict on update cascade
);

CREATE TABLE Beneficios (
	id_beneficio SERIAL PRIMARY KEY,
	nombre TEXT NOT NULL UNIQUE,
	descripcion TEXT NOT NULL
);

CREATE TABLE Beneficios_Plan (
	id_beneficio INTEGER,
	id_plan INTEGER,

	PRIMARY KEY(id_beneficio, id_plan),

	CONSTRAINT fk_beneficio_plan
		FOREIGN KEY (id_beneficio) REFERENCES Beneficios(id_beneficio) on delete restrict on update cascade,

	CONSTRAINT fk_beneficio_ben
		FOREIGN KEY (id_plan) REFERENCES Planes(id_plan) on delete restrict on update cascade
);

CREATE TABLE Medios_Pago_Plan(
	id_plan INTEGER,
	id_medio_pago INTEGER,

	PRIMARY KEY(id_plan, id_medio_pago),

	CONSTRAINT fk_medio_plan
		FOREIGN KEY (id_plan) REFERENCES Planes(id_plan) on delete restrict on update cascade,

	CONSTRAINT fk_medio_pago
		FOREIGN KEY (id_medio_pago) REFERENCES Medios_Pago(id_medio_pago) on delete restrict on update cascade
);
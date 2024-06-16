drop table if exists grupo02.movimientos
drop table if exists grupo02.detalles_importaciones
drop table if exists grupo02.detalles_pedidos
drop table if exists grupo02.operaciones_estados
drop table if exists grupo02.pedidos
drop table if exists grupo02.importaciones
drop table if exists grupo02.productos

drop table if exists grupo02.proveedores
drop table if exists grupo02.clientes
drop table if exists grupo02.categorias
drop table if exists grupo02.tipos_operacion
drop table if exists grupo02.estados
drop table if exists grupo02.trabajadores
drop table if exists grupo02.almacenes



GO

create table grupo02.proveedores
(
	id_proveedor							char(8)	not null,
	nombre									varchar(400),
	direccion								varchar(400),
	telefono								varchar(400),
	correo									varchar(400),
	ruc										varchar(400),
	encargado								varchar(400)
)

create table grupo02.productos
(
	id_producto								char(8)	not null,
	nombre									varchar(400),
	descripción								varchar(400),
	precio									int,
	id_categoria							int
)

create table grupo02.clientes
(
	id_cliente								char(8)	not null,
	nombre									varchar(400),
	direccion								varchar(400),
	telefono								varchar(400),
	correo									varchar(400),
	ruc										varchar(400)
)

create table grupo02.categorias
(
	id_categoria							int	not null,
	descripción								varchar(400)
)

create table grupo02.tipos_operacion
(
	id_tipo_operacion						int	not null,
	descripción								varchar(400)
)

create table grupo02.detalles_pedidos
(
	id_detalle_pedido						int	not nulL IDENTITY(1,1),
	id_pedido								char(8),
	id_producto								char(8),
	cantidad								int,
	precio_unitario							int
)

create table grupo02.pedidos
(
	id_pedido								char(8)	not null,
	fecha_hora								datetime,
	id_cliente								char(8),
	id_estado								int,
	id_trabajador							char(8)
)

create table grupo02.estados
(
	id_estado								int	not null,
	descripción								varchar(400)
)

create table grupo02.operaciones_estados
(
	id_operacion_estado						int	not null,
	id_importacion							char(8),
	id_pedido								char(8),
	id_estado								int,
	fecha_hora								datetime,
	id_trabajador							char(8),
)

create table grupo02.trabajadores
(
	id_trabajador							char(8) not null,
	nombre									varchar(400),
	direccion								varchar(400),
	telefono								varchar(400),
	correo									varchar(400)
)

create table grupo02.movimientos
(
	id_movimiento							char(9)	not null,
	id_detalle_pedido						int,
	id_detalle_importacion					int,
	id_almacen								char(8),
	stock_inicial							int,
	stock_final								int,
	fecha_hora								datetime,
	id_tipo_operacion						int
)

create table grupo02.almacenes
(
	id_almacen								char(8)	not null,
	nombre									varchar(400),
	direccion								varchar(400),
	telefono								varchar(400)
)

create table grupo02.importaciones
(
	id_importacion							char(8)	not null,
	fecha_hora								datetime,
	id_proveedor							char(8),
	id_estado								int,
	id_trabajador							char(8)
)

create table grupo02.detalles_importaciones
(
	id_detalle_importacion					int	not null IDENTITY(1,1),
	id_importacion							char(8),
	id_producto								char(8),
	cantidad								int,
	precio_unitario							int
)

GO

alter table grupo02.proveedores add constraint pk_proveedor primary key (id_proveedor)
alter table grupo02.productos add constraint pk_producto primary key (id_producto)
alter table grupo02.clientes add constraint pk_cliente primary key (id_cliente)
alter table grupo02.categorias add constraint pk_categoria primary key (id_categoria)
alter table grupo02.tipos_operacion add constraint pk_tipo_operacion primary key (id_tipo_operacion)
alter table grupo02.detalles_pedidos add constraint pk_detalle_pedido primary key (id_detalle_pedido)
alter table grupo02.pedidos add constraint pk_pedido primary key (id_pedido)
alter table grupo02.estados add constraint pk_estado primary key (id_estado)
alter table grupo02.operaciones_estados add constraint pk_operacion_estado primary key (id_operacion_estado)
alter table grupo02.trabajadores add constraint pk_trabajador primary key (id_trabajador)
alter table grupo02.movimientos add constraint pk_movimiento primary key (id_movimiento)
alter table grupo02.almacenes add constraint pk_almacen primary key (id_almacen)
alter table grupo02.importaciones add constraint pk_importacion primary key (id_importacion)
alter table grupo02.detalles_importaciones add constraint pk_detalle_importacion primary key (id_detalle_importacion)


alter table grupo02.productos add constraint fk_productos_categoria foreign key (id_categoria) references grupo02.categorias (id_categoria)
alter table grupo02.detalles_pedidos add constraint fk_detalles_pedidos_pedido foreign key (id_pedido) references grupo02.pedidos (id_pedido)
alter table grupo02.detalles_pedidos add constraint fk_detalles_pedidos_producto foreign key (id_producto) references grupo02.productos (id_producto)
alter table grupo02.pedidos add constraint fk_pedidos_cliente foreign key (id_cliente) references grupo02.clientes (id_cliente)
alter table grupo02.pedidos add constraint fk_pedidos_estado foreign key (id_estado) references grupo02.estados (id_estado)
alter table grupo02.pedidos add constraint fk_pedidos_trabajador foreign key (id_trabajador) references grupo02.trabajadores (id_trabajador)
alter table grupo02.operaciones_estados add constraint fk_operaciones_estados_importacion foreign key (id_importacion) references grupo02.importaciones (id_importacion)
alter table grupo02.operaciones_estados add constraint fk_operaciones_estados_pedido foreign key (id_pedido) references grupo02.pedidos (id_pedido)
alter table grupo02.operaciones_estados add constraint fk_operaciones_estados_estado foreign key (id_estado) references grupo02.estados (id_estado)
alter table grupo02.operaciones_estados add constraint fk_operaciones_estados_trabajador foreign key (id_trabajador) references grupo02.trabajadores (id_trabajador)
alter table grupo02.movimientos add constraint fk_movimientos_detalle_pedido foreign key (id_detalle_pedido) references grupo02.detalles_pedidos (id_detalle_pedido)
alter table grupo02.movimientos add constraint fk_movimientos_detalle_importacion foreign key (id_detalle_importacion) references grupo02.detalles_importaciones (id_detalle_importacion)
alter table grupo02.movimientos add constraint fk_movimientos_almacen foreign key (id_almacen) references grupo02.almacenes (id_almacen)
alter table grupo02.movimientos add constraint fk_movimientos_tipo_operacion foreign key (id_tipo_operacion) references grupo02.tipos_operacion (id_tipo_operacion)
alter table grupo02.importaciones add constraint fk_importaciones_proveedor foreign key (id_proveedor) references grupo02.proveedores (id_proveedor)
alter table grupo02.importaciones add constraint fk_importaciones_estado foreign key (id_estado) references grupo02.estados (id_estado)
alter table grupo02.importaciones add constraint fk_importaciones_trabajador foreign key (id_trabajador) references grupo02.trabajadores (id_trabajador)
alter table grupo02.detalles_importaciones add constraint fk_detalles_importaciones_importacion foreign key (id_importacion) references grupo02.importaciones (id_importacion)
alter table grupo02.detalles_importaciones add constraint fk_detalles_importaciones_producto foreign key (id_producto) references grupo02.productos (id_producto)

GO

INSERT INTO grupo02.Proveedores VALUES ('80000001','Tecnologías Avanzadas','Av. La Cultura 654, Cusco','084-593-7499','contacto@norteequipamientos.pe','22260092262','Fernando Díaz')
INSERT INTO grupo02.Proveedores VALUES ('80000002','Equipamientos del Norte','Av. Los Incas 456, Cusco','074-889-3537','info@herramientasmodernas.pe','21034932450','Natalia Campos')
INSERT INTO grupo02.Proveedores VALUES ('80000003','Suministros del Sur','Av. Santa Cruz 321, Arequipa','044-120-1028','info@centroproveedor.com','26657558938','Lucía Romero')
INSERT INTO grupo02.Proveedores VALUES ('80000004','Innovaciones Avanzadas','Jr. Colón 456, Lima','084-272-8458','ventas@equiposcentro.com','25819647850','Natalia Castillo')
INSERT INTO grupo02.Proveedores VALUES ('80000005','Proveedores del Sur','Calle Manco Cápac 123, Lima','074-720-7523','info@tecnomaqsur.com','20817917874','Patricia López')
INSERT INTO grupo02.Proveedores VALUES ('80000006','Industriales del Norte','Av. Los Pinos 789, Arequipa','074-805-9220','info@tecnologiasequipos.com','24695185154','Gabriela Jiménez')
INSERT INTO grupo02.Proveedores VALUES ('80000007','Innovaciones del Norte','Jr. Pizarro 321, Trujillo','044-833-1446','contacto@proveedorasur.com','23411767095','Oscar Gutiérrez')
INSERT INTO grupo02.Proveedores VALUES ('80000008','Suministros Avanzados','Calle San Francisco 123, Chiclayo','084-230-2824','ventas@tecnomaqnorte.com','27447301460','Alejandra Morales')
INSERT INTO grupo02.Proveedores VALUES ('80000009','Tecnologías y Equipos','Jr. Zepita 654, Arequipa','044-773-3811','contacto@herramientassur.com','29450689631','Mario García')
INSERT INTO grupo02.Proveedores VALUES ('80000010','Proveedora Central','Calle Sucre 321, Lima','084-455-2117','info@innovacionesavanzadas.com','28954755386','Ricardo Herrera')
INSERT INTO grupo02.Proveedores VALUES ('80000011','Maquinas del Sur','Av. Industrial 123, Lima','084-198-8407','ventas@equiposavanzados.com','24805792350','Victor Márquez')
INSERT INTO grupo02.Proveedores VALUES ('80000012','Suministros y Servicios','Av. Panamericana 321, Chiclayo','074-756-8453','ventas@equiposyservicios.com','29219219222','Camila Guerrero')
INSERT INTO grupo02.Proveedores VALUES ('80000013','Distribuciones del Centro','Av. Bolognesi 654, Cusco','044-621-6029','ventas@equiposcentro.com','23343027158','Isabel Silva')
INSERT INTO grupo02.Proveedores VALUES ('80000014','Equipos Industriales','Av. Pardo 987, Cusco','054-265-9047','contacto@distribucionesnorte.com','24574434578','Francisco León')
INSERT INTO grupo02.Proveedores VALUES ('80000015','Herramientas Industriales','Jr. Grau 789, Cusco','084-399-5020','info@equiposmodernos.com','28121609401','Lucía Romero')
INSERT INTO grupo02.Proveedores VALUES ('80000016','Equipamientos Industriales','Av. Los Incas 456, Cusco','074-575-6818','contacto@maquinariascentro.com','21044966584','Valeria Medina')
INSERT INTO grupo02.Proveedores VALUES ('80000017','Tecnologías del Sur','Calle Manco Cápac 123, Lima','074-804-3509','ventas@tecnomaqsa.com','28164928616','Andrés Paredes')
INSERT INTO grupo02.Proveedores VALUES ('80000018','Suministros Industriales','Av. Túpac Amaru 654, Trujillo','054-721-6108','ventas@proveedoressur.com','25859940044','Miguel Vega')
INSERT INTO grupo02.Proveedores VALUES ('80000019','Proveedora Sur','Av. República 987, Trujillo','054-385-3112','ventas@equiposymaquinas.com','29395835200','Sebastián Aguilar')
INSERT INTO grupo02.Proveedores VALUES ('80000020','Equipamientos del Norte','Av. La Marina 654, Chiclayo','01-358-4109','contacto@maquinariascentro.com','27431664414','Victor Márquez')

GO

INSERT INTO grupo02.Categorias VALUES (1,'Maquinaria para construcción')
INSERT INTO grupo02.Categorias VALUES (2,'Maquinaria para minería')
INSERT INTO grupo02.Categorias VALUES (3,'Equipos para agricultura')
INSERT INTO grupo02.Categorias VALUES (4,'Equipos para transporte')
INSERT INTO grupo02.Categorias VALUES (5,'Generación de energía')
INSERT INTO grupo02.Categorias VALUES (6,'Equipos para construcción de carreteras')

GO

INSERT INTO grupo02.Productos VALUES ('50000001','Excavadora CAT 320D','Excavadora hidráulica para trabajos de excavación en proyectos de construcción.',200000,1)
INSERT INTO grupo02.Productos VALUES ('50000002','Cargador Frontal CAT 950H','Cargador frontal para la carga de materiales en proyectos de construcción y minería.',180000,1)
INSERT INTO grupo02.Productos VALUES ('50000003','Camión Minero CAT 785D','Camión minero de gran capacidad para transporte de material en operaciones mineras a cielo abierto.',500000,2)
INSERT INTO grupo02.Productos VALUES ('50000004','Pala Hidráulica CAT 374D','Pala hidráulica para carguío de material en operaciones de minería y construcción.',300000,2)
INSERT INTO grupo02.Productos VALUES ('50000005','Tractor Agrícola CAT 725','CAT 725 es un tractor agrícola versátil para labores en el campo.',90000,3)
INSERT INTO grupo02.Productos VALUES ('50000006','Cosechadora CAT 572','Una cosechadora eficiente y confiable para la recolección de cultivos agrícolas.',150000,3)
INSERT INTO grupo02.Productos VALUES ('50000007','Camión Volquete CAT 740B','Camión volquete para transporte de material en proyectos de construcción y minería.',250000,4)
INSERT INTO grupo02.Productos VALUES ('50000008','Grúa CAT 50 Ton','Grúa móvil para levantamiento de carga pesada en obras de construcción y montaje industrial.',400000,4)
INSERT INTO grupo02.Productos VALUES ('50000009','Generador CAT 2000 kVA','Generador de energía de gran capacidad para suministro eléctrico en proyectos industriales.',600000,5)
INSERT INTO grupo02.Productos VALUES ('50000010','Motor Industrial CAT 3406C','Motor diesel industrial de alto rendimiento para maquinaria pesada.',100000,5)
INSERT INTO grupo02.Productos VALUES ('50000011','Pavimentadora CAT AP1000F','Pavimentadora de asfalto para la construcción y mantenimiento de carreteras.',350000,6)
INSERT INTO grupo02.Productos VALUES ('50000012','Fresadora CAT PM620','Fresadora de pavimento para remoción de asfalto en obras viales.',280000,6)
INSERT INTO grupo02.Productos VALUES ('50000013','Excavadora CAT 320D2','Excavadora hidráulica compacta para trabajos en espacios reducidos.',180000,1)
INSERT INTO grupo02.Productos VALUES ('50000014','Camión Minero CAT 777G','Camión minero de mediana capacidad para transporte de material en minería.',400000,2)
INSERT INTO grupo02.Productos VALUES ('50000015','Tractor Agrícola CAT 615C','Tractor agrícola resistente y eficiente para labores en el campo.',100000,3)
INSERT INTO grupo02.Productos VALUES ('50000016','Cosechadora CAT 612B','Cosechadora confiable para la recolección de diferentes tipos de cultivos.',130000,3)
INSERT INTO grupo02.Productos VALUES ('50000017','Camión Volquete CAT 745','Camión volquete articulado para transporte de material en obras civiles y minería.',280000,4)
INSERT INTO grupo02.Productos VALUES ('50000018','Grúa CAT 100 Ton','Grúa móvil de alta capacidad para proyectos de construcción y montaje industrial.',800000,4)
INSERT INTO grupo02.Productos VALUES ('50000019','Generador CAT 1000 kVA','Generador de energía de gran potencia para suministro eléctrico en industrias y eventos.',800000,5)
INSERT INTO grupo02.Productos VALUES ('50000020','Motor Industrial CAT 3516B','Motor diesel industrial de alta potencia y confiabilidad para equipos pesados.',300000,5)

GO


INSERT INTO grupo02.Clientes VALUES ('30000001','Constructora Andina','Av. Primavera 123, Cusco','918001245','constructoraandina@business.com','20351354165')
INSERT INTO grupo02.Clientes VALUES ('30000002','Servicios Mineros S.A.','Calle Los Mineros 456, Arequipa','932062137','serviciosmineross.a.@enterprise.com','20689868862')
INSERT INTO grupo02.Clientes VALUES ('30000003','Transporte y Logística SAC','Av. La Marina 789, Trujillo','923412737','transporteylogísticasac@services.com','20301996742')
INSERT INTO grupo02.Clientes VALUES ('30000004','Hidroeléctrica del Sur','Jr. Los Andes 101, Puno','900395763','hidroeléctricadelsur@enterprise.com','20276283788')
INSERT INTO grupo02.Clientes VALUES ('30000005','Agroindustria del Norte','Av. Panamericana 202, Chiclayo','972076115','agroindustriadelnorte@services.com','20521357595')
INSERT INTO grupo02.Clientes VALUES ('30000006','Comercializadora del Centro','Calle Las Palmeras 303, Huancayo','922830162','comercializadoradelcentro@services.com','20878149671')
INSERT INTO grupo02.Clientes VALUES ('30000007','Minería del Sur','Jr. Las Flores 404, Tacna','926589894','mineríadelsur@business.com','20979861514')
INSERT INTO grupo02.Clientes VALUES ('30000008','Transporte y Carga SAC','Av. Ejército 505, Piura','929375693','transporteycargasac@services.com','20609484913')
INSERT INTO grupo02.Clientes VALUES ('30000009','Construcciones Modernas','Calle Los Incas 606, Iquitos','955530731','construccionesmodernas@services.com','20158440504')
INSERT INTO grupo02.Clientes VALUES ('30000010','Mantenimiento y Reparaciones EIRL','Av. Industrial 707, Cajamarca','925859589','mantenimientoyreparacioneseirl@services.com','20451122668')
INSERT INTO grupo02.Clientes VALUES ('30000011','Servicios Industriales S.A.','Jr. Los Héroes 808, Huánuco','910776300','serviciosindustrialess.a.@business.com','20337782269')
INSERT INTO grupo02.Clientes VALUES ('30000012','Logística Integral SAC','Av. Los Próceres 909, Ica','977275662','logísticaintegralsac@services.com','20747046154')
INSERT INTO grupo02.Clientes VALUES ('30000013','Maquinarias del Norte','Calle Las Magnolias 111, Huaraz','975121759','maquinariasdelnorte@enterprise.com','20450140105')
INSERT INTO grupo02.Clientes VALUES ('30000014','Transportes del Sur','Av. Libertad 212, Tumbes','901014934','transportesdelsur@services.com','20643478040')
INSERT INTO grupo02.Clientes VALUES ('30000015','Ingeniería y Proyectos S.A.','Jr. Los Laureles 313, Moquegua','911800140','ingenieríayproyectoss.a.@enterprise.com','20706978578')
INSERT INTO grupo02.Clientes VALUES ('30000016','Agropecuaria del Este','Av. Grau 414, Tarapoto','921510261','agropecuariadeleste@enterprise.com','20284090603')
INSERT INTO grupo02.Clientes VALUES ('30000017','Comercializadora del Sur','Calle Los Jazmines 515, Pucallpa','965808367','comercializadoradelsur@services.com','20653567653')
INSERT INTO grupo02.Clientes VALUES ('30000018','Construcciones del Norte','Av. Los Pinos 616, Ayacucho','969770887','construccionesdelnorte@company.com','20950809514')
INSERT INTO grupo02.Clientes VALUES ('30000019','Servicios y Proyectos SAC','Jr. Los Olivos 717, Chimbote','915606861','serviciosyproyectossac@services.com','20474538248')
INSERT INTO grupo02.Clientes VALUES ('30000020','Mantenimiento Integral S.A.','Av. El Sol 818, Juliaca','967769047','mantenimientointegrals.a.@services.com','20684370619')
INSERT INTO grupo02.Clientes VALUES ('30000021','Industrias del Sur','Calle Las Acacias 919, Puerto Maldonado','911054265','industriasdelsur@company.com','20175393810')
INSERT INTO grupo02.Clientes VALUES ('30000022','Transportes del Norte','Av. Arequipa 121, Pisco','947817421','transportesdelnorte@company.com','20236342477')
INSERT INTO grupo02.Clientes VALUES ('30000023','Ingeniería y Obras SAC','Calle Los Cedros 222, Huaral','980398227','ingenieríayobrassac@company.com','20826090278')
INSERT INTO grupo02.Clientes VALUES ('30000024','Minería Integral S.A.','Jr. Los Naranjos 323, Sullana','993554400','mineríaintegrals.a.@company.com','20907118916')
INSERT INTO grupo02.Clientes VALUES ('30000025','Agroindustrial del Sur','Av. Angamos 424, Tingo María','923529474','agroindustrialdelsur@services.com','20433301898')
INSERT INTO grupo02.Clientes VALUES ('30000026','Comercializadora del Norte','Calle Los Tulipanes 525, Chachapoyas','947518377','comercializadoradelnorte@business.com','20623324558')
INSERT INTO grupo02.Clientes VALUES ('30000027','Construcciones del Centro','Av. La Cultura 626, Abancay','907070082','construccionesdelcentro@business.com','20683400514')
INSERT INTO grupo02.Clientes VALUES ('30000028','Transporte y Servicios SAC','Jr. Los Robles 727, Jaén','943171695','transporteyserviciossac@enterprise.com','20318724316')
INSERT INTO grupo02.Clientes VALUES ('30000029','Hidroeléctrica del Norte','Av. El Polo 828, Chancay','995770391','hidroeléctricadelnorte@company.com','20914215445')
INSERT INTO grupo02.Clientes VALUES ('30000030','Proyectos y Obras SAC','Calle Los Eucaliptos 929, Cerro de Pasco','999328269','proyectosyobrassac@enterprise.com','20734829270')

GO

INSERT INTO grupo02.tipos_operacion VALUES (1,'Pedido')
INSERT INTO grupo02.tipos_operacion VALUES (2,'Importación')

GO

INSERT INTO grupo02.estados VALUES (1,'Pendiente')
INSERT INTO grupo02.estados VALUES (2,'Confirmado')
INSERT INTO grupo02.estados VALUES (3,'Procesando')
INSERT INTO grupo02.estados VALUES (4,'Listo para envío')
INSERT INTO grupo02.estados VALUES (5,'Enviado')
INSERT INTO grupo02.estados VALUES (6,'En camino')
INSERT INTO grupo02.estados VALUES (7,'Entregado')
INSERT INTO grupo02.estados VALUES (8,'Cancelado')
INSERT INTO grupo02.estados VALUES (9,'Devuelto')
INSERT INTO grupo02.estados VALUES (10,'Reembolsado')
INSERT INTO grupo02.estados VALUES (11,'En espera')
INSERT INTO grupo02.estados VALUES (12,'Fallido')

GO

insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000001','Carlos Gómez','Av. Siempre Viva 123','966632584','carlos.gomez@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000002','María Pérez','Calle Falsa 456','987710282','maria.perez@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000003','José Rodríguez','Jr. Los Olivos 789','921721236','jose.rodriguez@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000004','Ana Fernández','Av. Universitaria 101','980685442','ana.fernandez@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000005','Luis Sánchez','Calle Las Flores 202','982929898','luis.sanchez@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000006','Laura Ramírez','Jr. Las Amapolas 303','936872956','laura.ramirez@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000007','Juan Torres','Av. Arequipa 404','950471213','juan.torres@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000008','Carmen Díaz','Calle Los Pinos 505','984702287','carmen.diaz@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000009','Pedro Castillo','Jr. Las Palmeras 606','976070935','pedro.castillo@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000010','Elena Morales','Av. Javier Prado 707','910962783','elena.morales@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000011','Miguel Herrera','Calle Los Geranios 808','962109820','miguel.herrera@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000012','Patricia Vargas','Jr. Los Jazmines 909','903122556','patricia.vargas@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000013','Ricardo Rojas','Av. Petit Thouars 111','973804620','ricardo.rojas@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000014','Sandra Mendoza','Calle Los Claveles 212','971854849','sandra.mendoza@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000015','Andrés Aguirre','Jr. Los Naranjos 313','925717184','andres.aguirre@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000016','Rosa Guerrero','Av. Brasil 414','994723967','rosa.guerrero@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000017','Jorge Flores','Calle Los Tulipanes 515','932077538','jorge.flores@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000018','Lucía Rivera','Jr. Los Cedros 616','920710311','lucia.rivera@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000019','Roberto Jiménez','Av. La Marina 717','959088373','roberto.jimenez@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000020','Sofía Herrera','Calle Los Lirios 818','959087441','sofia.herrera@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000021','Martín Ruiz','Jr. Los Abetos 919','989078495','martin.ruiz@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000022','Isabel Soto','Av. Angamos 121','996107226','isabel.soto@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000023','Raúl Castro','Calle Los Eucaliptos 222','946294060','raul.castro@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000024','Daniela Silva','Jr. Los Robles 323','910008250','daniela.silva@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000025','Fernando Molina','Av. El Polo 424','975513272','fernando.molina@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000026','Gloria Rivas','Calle Los Laureles 525','903001552','gloria.rivas@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000027','Víctor Espinoza','Jr. Los Nogales 626','994348524','victor.espinoza@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000028','Andrea Valdez','Av. Canadá 727','965677555','andrea.valdez@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000029','Enrique Guzmán','Calle Las Magnolias 828','973805531','enrique.guzman@example.com')
insert into grupo02.trabajadores (id_trabajador, nombre, direccion, telefono, correo) values ('10000030','Natalia Paredes','Jr. Los Sauces 929','930413212','natalia.paredes@example.com')

GO

INSERT INTO grupo02.Pedidos VALUES ('40000001','2024-01-01T06:59:01','30000001',1,'10000001')
INSERT INTO grupo02.Pedidos VALUES ('40000002','2024-01-05T13:26:32','30000002',2,'10000002')
INSERT INTO grupo02.Pedidos VALUES ('40000003','2024-01-10T21:57:05','30000003',3,'10000003')
INSERT INTO grupo02.Pedidos VALUES ('40000004','2024-01-15T06:27:38','30000004',4,'10000004')
INSERT INTO grupo02.Pedidos VALUES ('40000005','2024-01-20T06:32:55','30000005',5,'10000005')
INSERT INTO grupo02.Pedidos VALUES ('40000006','2024-01-25T02:26:20','30000006',2,'10000006')
INSERT INTO grupo02.Pedidos VALUES ('40000007','2024-01-30T04:35:10','30000007',7,'10000007')
INSERT INTO grupo02.Pedidos VALUES ('40000008','2024-02-01T08:52:34','30000008',2,'10000008')
INSERT INTO grupo02.Pedidos VALUES ('40000009','2024-02-05T21:53:16','30000009',7,'10000009')
INSERT INTO grupo02.Pedidos VALUES ('40000010','2024-02-10T02:55:07','30000010',2,'10000010')
INSERT INTO grupo02.Pedidos VALUES ('40000011','2024-02-15T02:05:29','30000011',3,'10000011')
INSERT INTO grupo02.Pedidos VALUES ('40000012','2024-02-20T04:27:37','30000012',7,'10000012')
INSERT INTO grupo02.Pedidos VALUES ('40000013','2024-02-25T04:27:06','30000013',3,'10000013')
INSERT INTO grupo02.Pedidos VALUES ('40000014','2024-03-01T01:35:55','30000014',3,'10000014')
INSERT INTO grupo02.Pedidos VALUES ('40000015','2024-03-05T04:34:39','30000015',2,'10000015')
INSERT INTO grupo02.Pedidos VALUES ('40000016','2024-03-10T04:01:51','30000016',2,'10000016')
INSERT INTO grupo02.Pedidos VALUES ('40000017','2024-03-15T05:04:49','30000017',2,'10000017')
INSERT INTO grupo02.Pedidos VALUES ('40000018','2024-03-20T15:49:35','30000018',2,'10000018')
INSERT INTO grupo02.Pedidos VALUES ('40000019','2024-03-25T14:35:07','30000019',8,'10000019')
INSERT INTO grupo02.Pedidos VALUES ('40000020','2024-04-01T01:41:04','30000020',8,'10000020')


GO

INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000001','50000001',2,200000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000002','50000002',3,180000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000003','50000003',1,500000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000004','50000004',2,300000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000005','50000005',4,90000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000006','50000006',1,150000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000007','50000007',3,250000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000008','50000008',1,400000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000009','50000009',2,600000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000010','50000010',3,100000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000011','50000011',1,350000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000012','50000012',2,280000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000013','50000013',4,180000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000014','50000014',1,400000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000015','50000015',2,100000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000016','50000016',3,130000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000017','50000017',1,280000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000018','50000018',2,800000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000019','50000019',1,800000)
INSERT INTO grupo02.detalles_pedidos (ID_Pedido, ID_Producto, Cantidad, Precio_Unitario) VALUES ('40000020','50000020',3,300000)

GO

INSERT INTO grupo02.almacenes VALUES ('20000001','Almacén Central','Av. El Sol 123, Villa El Salvador','4567890')
INSERT INTO grupo02.almacenes VALUES ('20000002','Depósito Arequipa','Calle Los Mineros 456, Arequipa','6789012')
INSERT INTO grupo02.almacenes VALUES ('20000003','Bodega Trujillo','Av. La Marina 789, Trujillo','5678901')
INSERT INTO grupo02.almacenes VALUES ('20000004','Centro Logístico Puno','Jr. Los Andes 101, Puno','2345678')
INSERT INTO grupo02.almacenes VALUES ('20000005','Almacén Chiclayo','Av. Panamericana 202, Chiclayo','3456789')
INSERT INTO grupo02.almacenes VALUES ('20000006','Depósito Huancayo','Calle Las Palmeras 303, Huancayo','9876543')
INSERT INTO grupo02.almacenes VALUES ('20000007','Bodega Tacna','Jr. Las Flores 404, Tacna','8765432')
INSERT INTO grupo02.almacenes VALUES ('20000008','Centro de Distribución Piura','Av. Ejército 505, Piura','7654321')
INSERT INTO grupo02.almacenes VALUES ('20000009','Almacén Iquitos','Calle Los Incas 606, Iquitos','6543210')
INSERT INTO grupo02.almacenes VALUES ('20000010','Depósito Cajamarca','Av. Industrial 707, Cajamarca','4321098')

GO

INSERT INTO grupo02.importaciones VALUES ('90000001','2024-01-12T13:27:34','80000018',7,'10000014')
INSERT INTO grupo02.importaciones VALUES ('90000002','2024-01-14T13:45:16','80000001',7,'10000015')
INSERT INTO grupo02.importaciones VALUES ('90000003','2024-01-22T19:42:06','80000002',7,'10000015')
INSERT INTO grupo02.importaciones VALUES ('90000004','2024-02-02T13:23:33','80000007',7,'10000015')
INSERT INTO grupo02.importaciones VALUES ('90000005','2024-02-08T17:29:11','80000003',7,'10000015')
INSERT INTO grupo02.importaciones VALUES ('90000006','2024-02-10T09:07:28','80000017',2,'10000015')
INSERT INTO grupo02.importaciones VALUES ('90000007','2024-02-12T20:11:31','80000018',2,'10000015')
INSERT INTO grupo02.importaciones VALUES ('90000008','2024-02-18T19:45:15','80000012',2,'10000015')
INSERT INTO grupo02.importaciones VALUES ('90000009','2024-02-20T02:57:14','80000012',2,'10000014')
INSERT INTO grupo02.importaciones VALUES ('90000010','2024-03-02T19:11:35','80000014',2,'10000014')


GO

INSERT INTO grupo02.Detalles_Importaciones (ID_Importacion, ID_Producto, Cantidad, Precio_Unitario) VALUES ('90000001','50000002',500,27000)
INSERT INTO grupo02.Detalles_Importaciones (ID_Importacion, ID_Producto, Cantidad, Precio_Unitario) VALUES ('90000002','50000007',200,37500)
INSERT INTO grupo02.Detalles_Importaciones (ID_Importacion, ID_Producto, Cantidad, Precio_Unitario) VALUES ('90000003','50000008',300,60000)
INSERT INTO grupo02.Detalles_Importaciones (ID_Importacion, ID_Producto, Cantidad, Precio_Unitario) VALUES ('90000004','50000009',700,90000)
INSERT INTO grupo02.Detalles_Importaciones (ID_Importacion, ID_Producto, Cantidad, Precio_Unitario) VALUES ('90000005','50000010',200,15000)
INSERT INTO grupo02.Detalles_Importaciones (ID_Importacion, ID_Producto, Cantidad, Precio_Unitario) VALUES ('90000006','50000001',400,30000)
INSERT INTO grupo02.Detalles_Importaciones (ID_Importacion, ID_Producto, Cantidad, Precio_Unitario) VALUES ('90000007','50000012',300,42000)
INSERT INTO grupo02.Detalles_Importaciones (ID_Importacion, ID_Producto, Cantidad, Precio_Unitario) VALUES ('90000008','50000009',300,90000)
INSERT INTO grupo02.Detalles_Importaciones (ID_Importacion, ID_Producto, Cantidad, Precio_Unitario) VALUES ('90000009','50000004',500,45000)
INSERT INTO grupo02.Detalles_Importaciones (ID_Importacion, ID_Producto, Cantidad, Precio_Unitario) VALUES ('90000010','50000011',800,52500)

GO

INSERT INTO grupo02.movimientos VALUES ('60000001','1',NULL,'20000004',451,449,'2024-01-01 22:36:08',1)
INSERT INTO grupo02.movimientos VALUES ('60000002','2',NULL,'20000010',223,220,'2024-01-05 02:23:33',1)
INSERT INTO grupo02.movimientos VALUES ('60000003','3',NULL,'20000006',145,144,'2024-01-10 20:25:40',1)
INSERT INTO grupo02.movimientos VALUES ('60000004',NULL,'1','20000010',220,720,'2024-01-12 19:50:03',2)
INSERT INTO grupo02.movimientos VALUES ('60000005',NULL,'2','20000009',115,315,'2024-01-14 01:06:44',2)
INSERT INTO grupo02.movimientos VALUES ('60000006','4',NULL,'20000003',277,275,'2024-01-15 13:05:27',1)
INSERT INTO grupo02.movimientos VALUES ('60000007','5',NULL,'20000005',411,407,'2024-01-20 05:20:03',1)
INSERT INTO grupo02.movimientos VALUES ('60000008',NULL,'3','20000010',45,345,'2024-01-22 22:44:05',2)
INSERT INTO grupo02.movimientos VALUES ('60000009','6',NULL,'20000005',1005,1004,'2024-01-25 00:06:14',1)
INSERT INTO grupo02.movimientos VALUES ('60000010','7',NULL,'20000009',315,312,'2024-01-30 21:19:41',1)
INSERT INTO grupo02.movimientos VALUES ('60000011','8',NULL,'20000010',345,344,'2024-02-01 13:06:09',1)
INSERT INTO grupo02.movimientos VALUES ('60000012',NULL,'4','20000009',17,717,'2024-02-02 18:33:05',2)
INSERT INTO grupo02.movimientos VALUES ('60000013','9',NULL,'20000009',717,715,'2024-02-05 21:20:59',1)
INSERT INTO grupo02.movimientos VALUES ('60000014',NULL,'5','20000005',88,288,'2024-02-08 01:03:17',2)
INSERT INTO grupo02.movimientos VALUES ('60000015',NULL,'6','20000004',449,849,'2024-02-10 11:11:34',2)
INSERT INTO grupo02.movimientos VALUES ('60000016','10',NULL,'20000005',288,285,'2024-02-10 15:31:43',1)
INSERT INTO grupo02.movimientos VALUES ('60000017',NULL,'7','20000008',8,308,'2024-02-12 23:19:39',2)
INSERT INTO grupo02.movimientos VALUES ('60000018',11,NULL,'20000003',41,40,'2024-02-15 08:57:47',1)
INSERT INTO grupo02.movimientos VALUES ('60000019',NULL,'8','20000009',715,1015,'2024-02-18 08:08:14',2)
INSERT INTO grupo02.movimientos VALUES ('60000020',NULL,'9','20000003',275,775,'2024-02-20 22:26:03',2)
INSERT INTO grupo02.movimientos VALUES ('60000021','12',NULL,'20000008',308,306,'2024-02-20 15:16:02',1)
INSERT INTO grupo02.movimientos VALUES ('60000022','13',NULL,'20000005',150,146,'2024-02-25 20:12:41',1)
INSERT INTO grupo02.movimientos VALUES ('60000023','14',NULL,'20000005',55,54,'2024-03-01 08:37:32',1)
INSERT INTO grupo02.movimientos VALUES ('60000024',NULL,'10','20000003',40,840,'2024-03-02 14:58:29',2)
INSERT INTO grupo02.movimientos VALUES ('60000025','15',NULL,'20000010',470,468,'2024-03-05 18:53:44',1)
INSERT INTO grupo02.movimientos VALUES ('60000026','16',NULL,'20000008',123,120,'2024-03-10 07:26:22',1)
INSERT INTO grupo02.movimientos VALUES ('60000027','17',NULL,'20000005',800,799,'2024-03-15 06:27:29',1)
INSERT INTO grupo02.movimientos VALUES ('60000028','18',NULL,'20000008',608,606,'2024-03-20 03:55:30',1)
INSERT INTO grupo02.movimientos VALUES ('60000029','19',NULL,'20000009',40,39,'2024-03-25 14:07:09',1)
INSERT INTO grupo02.movimientos VALUES ('60000030','20',NULL,'20000006',147,144,'2024-04-01 08:02:52',1)

GO

INSERT INTO grupo02.operaciones_estados VALUES ('70000001',null,'40000001','1','2024-01-01T06:59:01','10000027')
INSERT INTO grupo02.operaciones_estados VALUES ('70000002',null,'40000002','1','2024-01-05T13:26:32','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000003',null,'40000002','2','2024-01-05T18:14:32','10000009')
INSERT INTO grupo02.operaciones_estados VALUES ('70000004',null,'40000003','1','2024-01-10T21:57:05','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000005',null,'40000003','2','2024-01-11T02:59:29','10000027')
INSERT INTO grupo02.operaciones_estados VALUES ('70000006',null,'40000003','3','2024-01-11T08:01:53','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000007',null,'40000004','1','2024-01-15T06:27:38','10000009')
INSERT INTO grupo02.operaciones_estados VALUES ('70000008',null,'40000004','2','2024-01-15T07:39:38','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000009',null,'40000004','3','2024-01-15T08:51:38','10000027')
INSERT INTO grupo02.operaciones_estados VALUES ('70000010',null,'40000004','4','2024-01-15T10:03:38','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000011',null,'40000005','1','2024-01-20T06:32:55','10000009')
INSERT INTO grupo02.operaciones_estados VALUES ('70000012',null,'40000005','2','2024-01-20T13:44:55','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000013',null,'40000005','3','2024-01-20T20:56:55','10000027')
INSERT INTO grupo02.operaciones_estados VALUES ('70000014',null,'40000005','4','2024-01-21T04:08:55','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000015',null,'40000005','5','2024-01-21T11:20:55','10000009')
INSERT INTO grupo02.operaciones_estados VALUES ('70000016',null,'40000006','1','2024-01-25T02:26:20','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000017',null,'40000006','2','2024-01-25T11:04:44','10000027')
INSERT INTO grupo02.operaciones_estados VALUES ('70000018',null,'40000007','1','2024-01-30T04:35:10','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000019',null,'40000007','2','2024-01-30T13:13:34','10000009')
INSERT INTO grupo02.operaciones_estados VALUES ('70000020',null,'40000007','3','2024-01-31T06:01:34','10000027')
INSERT INTO grupo02.operaciones_estados VALUES ('70000021',null,'40000007','4','2024-01-31T22:49:34','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000022',null,'40000007','5','2024-02-01T15:37:34','10000009')
INSERT INTO grupo02.operaciones_estados VALUES ('70000023',null,'40000007','6','2024-02-02T08:25:34','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000024',null,'40000007','7','2024-02-03T01:13:34','10000009')
INSERT INTO grupo02.operaciones_estados VALUES ('70000025',null,'40000008','1','2024-02-01T08:52:34','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000026',null,'40000008','2','2024-02-01T17:30:58','10000027')
INSERT INTO grupo02.operaciones_estados VALUES ('70000027',null,'40000009','1','2024-02-05T21:53:16','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000028',null,'40000009','2','2024-02-06T06:31:40','10000027')
INSERT INTO grupo02.operaciones_estados VALUES ('70000029',null,'40000009','3','2024-02-06T22:29:16','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000030',null,'40000009','4','2024-02-07T14:26:52','10000009')
INSERT INTO grupo02.operaciones_estados VALUES ('70000031',null,'40000009','5','2024-02-08T06:24:28','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000032',null,'40000009','6','2024-02-08T22:22:04','10000009')
INSERT INTO grupo02.operaciones_estados VALUES ('70000033',null,'40000009','7','2024-02-09T14:19:40','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000034',null,'40000010','1','2024-02-10T02:55:07','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000035',null,'40000010','2','2024-02-10T11:33:31','10000027')
INSERT INTO grupo02.operaciones_estados VALUES ('70000036',null,'40000011','1','2024-02-15T02:05:29','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000037',null,'40000011','2','2024-02-15T08:05:29','10000009')
INSERT INTO grupo02.operaciones_estados VALUES ('70000038',null,'40000011','3','2024-02-15T14:48:41','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000039',null,'40000012','1','2024-02-20T04:27:37','10000027')
INSERT INTO grupo02.operaciones_estados VALUES ('70000040',null,'40000012','2','2024-02-20T10:27:37','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000041',null,'40000012','3','2024-02-20T17:10:49','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000042',null,'40000012','4','2024-02-22T02:03:37','10000009')
INSERT INTO grupo02.operaciones_estados VALUES ('70000043',null,'40000012','5','2024-02-23T10:56:25','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000044',null,'40000012','6','2024-02-24T19:49:13','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000045',null,'40000012','7','2024-02-26T04:42:01','10000027')
INSERT INTO grupo02.operaciones_estados VALUES ('70000046',null,'40000013','1','2024-02-25T04:27:06','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000047',null,'40000013','2','2024-02-25T10:27:06','10000009')
INSERT INTO grupo02.operaciones_estados VALUES ('70000048',null,'40000013','3','2024-02-25T17:10:18','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000049',null,'40000014','1','2024-03-01T01:35:55','10000027')
INSERT INTO grupo02.operaciones_estados VALUES ('70000050',null,'40000014','2','2024-03-01T07:35:55','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000051',null,'40000014','3','2024-03-01T14:19:07','10000009')
INSERT INTO grupo02.operaciones_estados VALUES ('70000052',null,'40000015','1','2024-03-05T04:34:39','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000053',null,'40000015','2','2024-03-05T11:03:27','10000009')
INSERT INTO grupo02.operaciones_estados VALUES ('70000054',null,'40000016','1','2024-03-10T04:01:51','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000055',null,'40000016','2','2024-03-10T10:30:39','10000027')
INSERT INTO grupo02.operaciones_estados VALUES ('70000056',null,'40000017','1','2024-03-15T05:04:49','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000057',null,'40000017','2','2024-03-15T11:33:37','10000009')
INSERT INTO grupo02.operaciones_estados VALUES ('70000058',null,'40000018','1','2024-03-20T15:49:35','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000059',null,'40000018','2','2024-03-20T22:18:23','10000027')
INSERT INTO grupo02.operaciones_estados VALUES ('70000060',null,'40000019','1','2024-03-25T14:35:07','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000061',null,'40000019','8','2024-03-25T17:56:43','10000009')
INSERT INTO grupo02.operaciones_estados VALUES ('70000062',null,'40000020','1','2024-04-01T01:41:04','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000063',null,'40000020','8','2024-04-01T05:02:40','10000021')
INSERT INTO grupo02.operaciones_estados VALUES ('70000064','90000001',null,'1','2024-01-12T13:27:34','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000065','90000001',null,'2','2024-01-12T16:20:22','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000066','90000001',null,'3','2024-01-12T19:13:10','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000067','90000001',null,'4','2024-01-12T22:05:58','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000068','90000001',null,'5','2024-01-14T10:05:58','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000069','90000001',null,'6','2024-01-21T10:05:58','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000070','90000001',null,'7','2024-03-01T10:05:58','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000071','90000002',null,'1','2024-01-14T13:45:16','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000072','90000002',null,'2','2024-01-14T16:38:04','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000073','90000002',null,'3','2024-01-14T19:30:52','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000074','90000002',null,'4','2024-01-14T22:23:40','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000075','90000002',null,'5','2024-01-16T10:23:40','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000076','90000002',null,'6','2024-01-23T10:23:40','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000077','90000002',null,'7','2024-03-03T10:23:40','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000078','90000003',null,'1','2024-01-22T19:42:06','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000079','90000003',null,'2','2024-01-22T22:34:54','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000080','90000003',null,'3','2024-01-23T01:27:42','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000081','90000003',null,'4','2024-01-23T04:20:30','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000082','90000003',null,'5','2024-01-24T16:20:30','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000083','90000003',null,'6','2024-01-31T16:20:30','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000084','90000003',null,'7','2024-03-11T16:20:30','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000085','90000004',null,'1','2024-02-02T13:23:33','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000086','90000004',null,'2','2024-02-02T16:16:21','10000005')
INSERT INTO grupo02.operaciones_estados VALUES ('70000087','90000004',null,'3','2024-02-02T19:09:09','10000006')
INSERT INTO grupo02.operaciones_estados VALUES ('70000088','90000004',null,'4','2024-02-02T22:01:57','10000005')
INSERT INTO grupo02.operaciones_estados VALUES ('70000089','90000004',null,'5','2024-02-04T10:01:57','10000006')
INSERT INTO grupo02.operaciones_estados VALUES ('70000090','90000004',null,'6','2024-02-11T10:01:57','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000091','90000004',null,'7','2024-03-22T10:01:57','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000092','90000005',null,'1','2024-02-08T17:29:11','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000093','90000005',null,'2','2024-02-08T20:21:59','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000094','90000005',null,'3','2024-02-08T23:14:47','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000095','90000005',null,'4','2024-02-09T02:07:35','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000096','90000005',null,'5','2024-02-10T14:07:35','10000005')
INSERT INTO grupo02.operaciones_estados VALUES ('70000097','90000005',null,'6','2024-02-17T14:07:35','10000006')
INSERT INTO grupo02.operaciones_estados VALUES ('70000098','90000005',null,'7','2024-03-28T14:07:35','10000005')
INSERT INTO grupo02.operaciones_estados VALUES ('70000099','90000006',null,'1','2024-02-10T09:07:28','10000006')
INSERT INTO grupo02.operaciones_estados VALUES ('70000100','90000006',null,'2','2024-02-10T12:00:16','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000101','90000007',null,'1','2024-02-12T20:11:31','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000102','90000007',null,'2','2024-02-12T23:04:19','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000103','90000008',null,'1','2024-02-18T19:45:15','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000104','90000008',null,'2','2024-02-18T22:38:03','10000013')
INSERT INTO grupo02.operaciones_estados VALUES ('70000105','90000009',null,'1','2024-02-20T02:57:14','10000017')
INSERT INTO grupo02.operaciones_estados VALUES ('70000106','90000009',null,'2','2024-02-20T05:50:02','10000005')
INSERT INTO grupo02.operaciones_estados VALUES ('70000107','90000010',null,'1','2024-03-02T19:11:35','10000006')
INSERT INTO grupo02.operaciones_estados VALUES ('70000108','90000010',null,'2','2024-03-02T22:04:23','10000005')


GO
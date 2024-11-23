
go
use DBVENTAS_WEB
go
--REGISTROS EN TABLA ROL
INSERT INTO ROL(Descripcion) VALUES ('ADMINISTRADOR'),('EMPLEADO')

GO
--REGISTROS EN TABLA MENU
INSERT INTO MENU(Nombre,Icono) VALUES
('Mantenedor','fas fa-tools'),
('Clientes','fas fa-user-friends'),
('Compras','fas fa-cart-arrow-down'),
('Ventas','fas fa-cash-register'),
('Reportes','far fa-clipboard')

GO
--REGISTROS EN TABLA SUBMENU
INSERT INTO SUBMENU(IdMenu,Nombre,Controlador,Vista,Icono) VALUES
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Mantenedor'),'Rol','Rol','Crear','fas fa-user-tag'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Mantenedor'),'Asignar Permisos','Permisos','Crear','fas fa-user-lock'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Mantenedor'),'Usuarios','Usuario','Crear','fas fa-users-cog'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Mantenedor'),'Categorias','Categoria','Crear','fab fa-wpforms'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Mantenedor'),'Productos','Producto','Crear','fas fa-box-open'),

((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Clientes'),'Clientes','Cliente','Crear','fas fa-user-shield'),

((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Compras'),'Proveedores','Proveedor','Crear','fas fa-shipping-fast'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Compras'),'Asignar producto a Tienda','Producto','Asignar','fas fa-dolly'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Compras'),'Registrar Compra','Compra','Crear','fas fa-cart-arrow-down'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Compras'),'Consultar Compra','Compra','Consultar','far fa-list-alt'),

((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Ventas'),'Tiendas','Tienda','Crear','fas fa-store-alt'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Ventas'),'Registrar Venta','Venta','Crear','fas fa-cash-register'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Ventas'),'Consultar Venta','Venta','Consultar','far fa-clipboard'),

((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Reportes'),'Productos por tienda','Reporte','Producto','fas fa-boxes'),
((SELECT TOP 1 IdMenu FROM MENU WHERE Nombre = 'Reportes'),'Ventas','Reporte','Ventas','fas fa-shopping-basket')


GO
--REGISTROS EN TABLA TIENDA
INSERT INTO TIENDA(Nombre,RUC,Direccion,Telefono) VALUES ('Tienda 001','25689789654','AV.GRANDE 123','963852896')

GO
--REGISTROS USUARIO
insert into usuario(Nombres,Apellidos,Correo,Clave,IdTienda,IdRol)
values('Administrador','Thopsom','admin@gmail.com','7932b2e116b076a54f452848eaabd5857f61bd957fe8a218faf216f24c9885bb',(select TOP 1 IdTienda from TIENDA where Nombre = 'Tienda 001'),(select TOP 1 IdRol from ROL where Descripcion = 'ADMINISTRADOR'))
go
insert into usuario(Nombres,Apellidos,Correo,Clave,IdTienda,IdRol)
values('Tienda','azgun','tienda@gmail.com','29cfa0f8e37e40a1a7a723aa88eca2cc050f270417969bfbe753f6bc0919aefe',(select TOP 1 IdTienda from TIENDA where Nombre = 'Tienda 001'),(select TOP 1 IdRol from ROL where Descripcion = 'EMPLEADO'))


GO
--REGISTROS EN TABLA PERMISOS
INSERT INTO PERMISOS(IdRol,IdSubMenu)
SELECT (select TOP 1 IdRol from ROL where Descripcion = 'ADMINISTRADOR'), IdSubMenu FROM SUBMENU
go
INSERT INTO PERMISOS(IdRol,IdSubMenu,Activo)
SELECT (select TOP 1 IdRol from ROL where Descripcion = 'EMPLEADO'), IdSubMenu, 0 FROM SUBMENU 

go

update p set p.Activo = 1 from PERMISOS p
inner join SUBMENU sm on sm.IdSubMenu = p.IdSubMenu
where sm.Controlador in ('Venta') and p.IdRol = (select TOP 1 IdRol from ROL where Descripcion = 'EMPLEADO')


GO
--REGISTRO EN TABLA CATEGORIA
INSERT INTO CATEGORIA(Descripcion) VALUES
('Medicamentos'),
('Cuidado Personal'),
('Vitaminas y Suplementos'),
('Equipos Médicos'),
('Higiene Personal'),
('Productos Naturales'),
('Cuidado Infantil'),
('Dermocosmética'),
('Salud Sexual'),
('Ortopedia')
GO

--REGISTRO EN TABLA PRODUCTO
INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Paracetamol 500mg',
    'Caja de 20 tabletas',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Medicamentos')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Vitamina C 1000mg',
    'Frasco con 100 tabletas',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Vitaminas y Suplementos')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Alcohol en gel 70%',
    'Botella de 500ml',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Higiene Personal')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Pañales para adultos',
    'Paquete de 10 unidades, talla M',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Cuidado Infantil')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Glucómetro digital',
    'Incluye 10 tiras de prueba',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Equipos Médicos')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Crema hidratante facial',
    'Tubo de 200ml',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Dermocosmética')
);
GO

-- Más productos para la tabla PRODUCTO
INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Ibuprofeno 200mg',
    'Caja de 30 tabletas',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Medicamentos')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Multivitamínico Centrum',
    'Frasco con 60 tabletas',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Vitaminas y Suplementos')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Jabón Antibacterial',
    'Barra de 100g',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Higiene Personal')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Termómetro digital',
    'Pantalla LCD, lectura en 10 segundos',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Equipos Médicos')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Protector solar SPF 50',
    'Frasco de 120ml',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Dermocosmética')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Toallas húmedas',
    'Paquete de 50 unidades',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Cuidado Personal')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Leche en polvo Pediasure',
    'Lata de 850g',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Cuidado Infantil')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Preservativos Trojan',
    'Caja de 12 unidades',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Salud Sexual')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Faja lumbar ortopédica',
    'Talla ajustable',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Ortopedia')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Té de manzanilla natural',
    'Caja con 20 sobres',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Productos Naturales')
);
GO

--================================================================================
-- Más registros para la tabla PRODUCTO
INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Amoxicilina 500mg',
    'Caja de 10 cápsulas',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Medicamentos')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Ácido Fólico 5mg',
    'Caja de 30 tabletas',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Vitaminas y Suplementos')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Enjuague Bucal Listerine',
    'Botella de 250ml',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Higiene Personal')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Tensiómetro digital',
    'Incluye estuche protector',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Equipos Médicos')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Crema antiarrugas',
    'Frasco de 50ml',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Dermocosmética')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Crema corporal hidratante',
    'Tubo de 400ml',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Cuidado Personal')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Biberón con válvula anticólico',
    '250ml, BPA Free',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Cuidado Infantil')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Lubricante íntimo Durex',
    'Botella de 50ml',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Salud Sexual')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Plantillas ortopédicas',
    'Talla ajustable',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Ortopedia')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Infusión de valeriana',
    'Caja con 25 sobres',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Productos Naturales')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Spray nasal salino',
    'Botella de 30ml',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Medicamentos')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Calcio + Vitamina D',
    'Frasco de 60 tabletas',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Vitaminas y Suplementos')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Toalla higiénica Always',
    'Paquete de 8 unidades',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Cuidado Personal')
);
GO

INSERT INTO PRODUCTO(Codigo,ValorCodigo,Nombre,Descripcion,IdCategoria)
VALUES
(
    RIGHT('000000' + CONVERT(varchar(max), (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO)), 6),
    (SELECT ISNULL(MAX(ValorCodigo), 0) + 1 FROM PRODUCTO),
    'Crema antiestrías Mustela',
    'Tubo de 150ml',
    (SELECT TOP 1 IdCategoria FROM CATEGORIA WHERE Descripcion = 'Dermocosmética')
);
GO





Insert into cliente(tipodocumento,numerodocumento,nombre,direccion,telefono) values 
('DNI','34231223','Jose Perez','av. Test 123','12345342'),
('DNI','56567878','Maria Paz','av. Test 124','12345343'),
('DNI','78907878','Thalia Quiñon','av. Test 125','12345344'),
('DNI','56346767','Belem Madara','av. Test 126','12345345'),
('DNI','34234234','Teresa espinoza','av. Test 127','12345346'),
('DNI','67788978','Arturo Sanchez','av. Test 128','12345347'),
('DNI','34311232','Pere Calvo','av. Test 129','12345348'),
('DNI','23234545','Naima Prat','av. Test 130','12345349'),
('DNI','45234545','Nicole Barreiro','av. Test 131','12345350'),
('DNI','23231212','Iratxe Ahmed','av. Test 132','12345351'),
('DNI','67678990','Monserrat Ballester','av. Test 133','12345352'),
('DNI','45455666','Alfonsa Mendoza','av. Test 135','12345354'),
('DNI','65765888','Alex Ramon','av. Test 136','12345355'),
('DNI','89768677','Pablo Rosell','av. Test 137','12345356'),
('DNI','67676789','Sebastian Palomino','av. Test 138','12345357'),
('DNI','76867878','Hamza Grau','av. Test 139','12345358'),
('DNI','89934233','Faustino Romo','av. Test 140','12345359')

go

insert into PROVEEDOR(ruc,RazonSocial,Telefono,Correo,Direccion) values
('25689789654','PROVEEDOR MANZANA 001','345234234','manzana@ma.com','av . las manzanas'),
('45623412312','PROVEEDOR PERA 001','123123456','pera@pe.co','av. las peras')


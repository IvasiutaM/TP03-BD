-- Tabla PROVINCIAS
CREATE TABLE PROVINCIAS (
 CodProv INT PRIMARY KEY,
 Provincia CHAR(50) NOT NULL
);

-- Tabla CIUDADES
CREATE TABLE CIUDADES (
 CodCiud INT PRIMARY KEY,
 Ciudad CHAR(50) NOT NULL,
 CodProv INT NOT NULL,
 CONSTRAINT fk_ciudad_prov FOREIGN KEY (CodProv) REFERENCES PROVINCIAS(CodProv)
);

-- Tabla CATEGORIAS
CREATE TABLE CATEGORIAS (
 CodCateg INT PRIMARY KEY,
 Categ CHAR(50) NOT NULL,
 Sueldo MONEY NOT NULL
);

-- Tabla SUCURSALES
CREATE TABLE SUCURSALES (
 NrSuc INT PRIMARY KEY,
 Ciudad CHAR(50) NOT NULL,
 CodCiud INT NOT NULL,
 CONSTRAINT fk_suc_ciudad FOREIGN KEY (CodCiud) REFERENCES CIUDADES(CodCiud)
);

-- Tabla CLIENTES
CREATE TABLE CLIENTES (
 DNI INT PRIMARY KEY,
 Apellido CHAR(50) NOT NULL,
 Ciudad CHAR(50) NOT NULL,
 CodCiud INT NOT NULL,
 CONSTRAINT fk_cli_ciudad FOREIGN KEY (CodCiud) REFERENCES CIUDADES(CodCiud)
);

-- Tabla EMPLEADOS
CREATE TABLE EMPLEADOS (
 LegEmp INT PRIMARY KEY,
 Apellido CHAR(50) NOT NULL,
 Nombre CHAR(50) NOT NULL,
 FechaIngreso DATE NOT NULL,
 NrSuc INT NOT NULL,
 CodCateg INT NOT NULL,
 CodCiud INT NOT NULL,
 CONSTRAINT fk_emp_suc FOREIGN KEY (NrSuc) REFERENCES SUCURSALES(NrSuc),
 CONSTRAINT fk_emp_categ FOREIGN KEY (CodCateg) REFERENCES CATEGORIAS(CodCateg),
 CONSTRAINT fk_emp_ciudad FOREIGN KEY (CodCiud) REFERENCES CIUDADES(CodCiud)
);

-- Tabla TIPOSCUENTAS
CREATE TABLE TIPOSCUENTAS (
 TipoCuenta INT PRIMARY KEY,
 Descripcion CHAR(50) NOT NULL,
 Tasa DECIMAL(5,2) NOT NULL
);

-- Tabla CUENTAS
CREATE TABLE CUENTAS (
 NrCuenta INT PRIMARY KEY,
 TipoCuenta INT NOT NULL,
 Saldo MONEY NOT NULL DEFAULT 0,
 DNI INT NOT NULL,
 NrSuc INT NOT NULL,
 CONSTRAINT fk_cta_tipo FOREIGN KEY (TipoCuenta) REFERENCES TIPOSCUENTAS(TipoCuenta),
 CONSTRAINT fk_cta_cli FOREIGN KEY (DNI) REFERENCES CLIENTES(DNI),
 CONSTRAINT fk_cta_suc FOREIGN KEY (NrSuc) REFERENCES SUCURSALES(NrSuc)
);

-- Tabla TIPOSOPERACIONES (Debe/Haber)
CREATE TABLE TIPOSOPERACIONES (
 CodTipoOp INT PRIMARY KEY,
 TipoOperacion CHAR(50) NOT NULL
);

-- Tabla OPERACIONES (Operaciones específicas)
CREATE TABLE OPERACIONES (
 CodOp INT PRIMARY KEY,
 Operacion CHAR(50) NOT NULL,
 CodTipoOp INT NOT NULL,
 CONSTRAINT fk_op_tipo FOREIGN KEY (CodTipoOp) REFERENCES TIPOSOPERACIONES(CodTipoOp)
);

-- Tabla MOVIMIENTOS
CREATE TABLE MOVIMIENTOS (
 NrMov INT PRIMARY KEY,
 Monto MONEY NOT NULL,
 Fecha DATE NOT NULL,
 NrCuenta INT NOT NULL,
 CodOp INT NOT NULL,
 TipoCuenta INT NOT NULL,
 CONSTRAINT fk_mov_cuenta FOREIGN KEY (NrCuenta) REFERENCES CUENTAS(NrCuenta),
 CONSTRAINT fk_mov_op FOREIGN KEY (CodOp) REFERENCES OPERACIONES(CodOp),
 CONSTRAINT fk_mov_tipocta FOREIGN KEY (TipoCuenta) REFERENCES TIPOSCUENTAS(TipoCuenta)
);

-- =============================================
-- DATOS DE EJEMPLO
-- =============================================
INSERT INTO PROVINCIAS VALUES (1, 'Misiones'), (2, 'Corrientes'), (3, 'Buenos Aires');

INSERT INTO CIUDADES VALUES
 (1, 'Posadas', 1),
 (2, 'Oberá', 1),
 (3, 'Corrientes', 2),
 (4, 'Buenos Aires', 3);

INSERT INTO CATEGORIAS VALUES
 (1, 'Administrativo', 500000),
 (2, 'Gerente', 1500000),
 (3, 'Seguridad', 400000),
 (4, 'Cajero', 450000);

INSERT INTO SUCURSALES VALUES
 (1, 'Posadas', 1),
 (2, 'Oberá', 2),
 (3, 'Corrientes', 3);

INSERT INTO CLIENTES VALUES
 (12345678, 'García', 'Posadas', 1),
 (23456789, 'López', 'Oberá', 2),
 (34567890, 'Martínez', 'Corrientes', 3),
 (45678901, 'Rodríguez', 'Posadas', 1);

INSERT INTO EMPLEADOS VALUES
 (1, 'Pérez', 'Juan', '2020-01-15', 1, 1, 1),
 (2, 'Gómez', 'María', '2019-03-20', 1, 2, 1),
 (3, 'Álvarez', 'Carlos', '2021-07-10', 2, 3, 2),
 (4, 'Torres', 'Ana', '2022-11-05', 3, 4, 3);

INSERT INTO TIPOSCUENTAS VALUES
 (1, 'Caja de Ahorro', 0.50),
 (2, 'Cuenta Corriente', 0.00),
 (3, 'Cuenta en Dólares', 1.00),
 (4, 'Plazo Fijo', 5.00);

INSERT INTO CUENTAS VALUES
 (1001, 1, 150000, 12345678, 1),
 (1002, 2, 300000, 23456789, 1),
 (1003, 1, 50000, 34567890, 2),
 (1004, 3, 200000, 45678901, 3);

INSERT INTO TIPOSOPERACIONES VALUES
 (1, 'Debe'),
 (2, 'Haber');

INSERT INTO OPERACIONES VALUES
 (1, 'Acreditación de sueldo', 2),
 (2, 'Pago de depósito', 1),
 (3, 'Extracción de Efectivo', 1),
 (4, 'Acreditación de valores', 2),
 (5, 'Débito transferencia', 1),
 (6, 'Crédito transferencia', 2);

INSERT INTO MOVIMIENTOS VALUES
 (1, 50000, '2026-01-10', 1001, 6, 1),
 (2, 20000, '2026-01-15', 1001, 3, 1),
 (3, 100000, '2026-02-01', 1002, 1, 2),
 (4, 30000, '2026-02-10', 1002, 2, 2),
 (5, 10000, '2026-03-05', 1003, 6, 1),
 (6, 200000, '2026-03-15', 1004, 4, 3);

-- =======================================
-- 				VISTAS
-- =======================================

-- Parte B 2.a - 4 vistas para consultar datos

-- Vista 1: Cuentas con datos del cliente y sucursal
CREATE OR REPLACE VIEW v_cuentas_detalle AS
SELECT
 c.NrCuenta,
 cl.Apellido AS Cliente,
 tc.Descripcion AS TipoCuenta,
 c.Saldo,
 s.Ciudad AS Sucursal
FROM CUENTAS c
JOIN CLIENTES cl ON c.DNI = cl.DNI
JOIN TIPOSCUENTAS tc ON c.TipoCuenta = tc.TipoCuenta
JOIN SUCURSALES s ON c.NrSuc = s.NrSuc;

-- Vista 2: Empleados con su categoría y sucursal
CREATE OR REPLACE VIEW v_empleados_detalle AS
SELECT
 e.LegEmp,
 e.Apellido,
 e.Nombre,
 e.FechaIngreso,
 cat.Categ AS Categoria,
 cat.Sueldo,
 s.Ciudad AS Sucursal
FROM EMPLEADOS e
JOIN CATEGORIAS cat ON e.CodCateg = cat.CodCateg
JOIN SUCURSALES s ON e.NrSuc = s.NrSuc
ORDER BY e.Apellido;

-- Vista 3: Clientes de una ciudad específica
CREATE OR REPLACE VIEW v_clientes_posadas AS
SELECT
 cl.DNI,
 cl.Apellido,
 ci.Ciudad,
 p.Provincia
FROM CLIENTES cl
JOIN CIUDADES ci ON cl.CodCiud = ci.CodCiud
JOIN PROVINCIAS p ON ci.CodProv = p.CodProv
WHERE ci.Ciudad = 'Posadas';

-- Vista 4: Movimientos con detalle de cuenta y tipo de operación
CREATE OR REPLACE VIEW v_movimientos_detalle AS
SELECT
 m.NrMov,
 m.Fecha,
 c.NrCuenta,
 cl.Apellido AS Cliente,
 o.Operacion AS TipoOperacion,
 t.TipoOperacion AS DebeHaber,
 m.Monto
FROM MOVIMIENTOS m
JOIN CUENTAS c ON m.NrCuenta = c.NrCuenta
JOIN CLIENTES cl ON c.DNI = cl.DNI
JOIN OPERACIONES o ON m.CodOp = o.CodOp
JOIN TIPOSOPERACIONES t ON o.CodTipoOp = t.CodTipoOp
ORDER BY m.Fecha DESC;
----------------------------------------------------------------------------------
-- Parte B 2.b - 3 vistas para obtener resultados sumarizados o totalizados

-- Vista 5: Saldo total por tipo de cuenta
CREATE OR REPLACE VIEW v_saldo_por_tipo AS
SELECT
 tc.Descripcion AS TipoCuenta,
 COUNT(c.NrCuenta) AS CantidadCuentas,
 SUM(c.Saldo) AS SaldoTotal,
 AVG(c.Saldo::NUMERIC) AS SaldoPromedio
FROM CUENTAS c
JOIN TIPOSCUENTAS tc ON c.TipoCuenta = tc.TipoCuenta
GROUP BY tc.Descripcion;

-- Vista 6: Total de movimientos por cuenta
CREATE OR REPLACE VIEW v_movimientos_por_cuenta AS
SELECT
 c.NrCuenta,
 cl.Apellido AS Cliente,
 COUNT(m.NrMov) AS CantMovimientos,
 SUM(CASE WHEN t.CodTipoOp = 2 THEN m.Monto ELSE 0::MONEY END) AS TotalHaber,
 SUM(CASE WHEN t.CodTipoOp = 1 THEN m.Monto ELSE 0::MONEY END) AS TotalDebe
FROM CUENTAS c
JOIN CLIENTES cl ON c.DNI = cl.DNI
LEFT JOIN MOVIMIENTOS m ON c.NrCuenta = m.NrCuenta
LEFT JOIN OPERACIONES o ON m.CodOp = o.CodOp
LEFT JOIN TIPOSOPERACIONES t ON o.CodTipoOp = t.CodTipoOp
GROUP BY c.NrCuenta, cl.Apellido;

-- Vista 7: Cantidad de empleados y sueldo promedio por sucursal
CREATE OR REPLACE VIEW v_empleados_por_sucursal AS
SELECT
 s.Ciudad AS Sucursal,
 COUNT(e.LegEmp) AS CantEmpleados,
 AVG(cat.Sueldo::NUMERIC) AS SueldoPromedio,
 MAX(cat.Sueldo) AS SueldoMaximo,
 MIN(cat.Sueldo) AS SueldoMinimo
FROM SUCURSALES s
LEFT JOIN EMPLEADOS e ON s.NrSuc = e.NrSuc
JOIN CATEGORIAS cat ON e.CodCateg = cat.CodCateg
GROUP BY s.Ciudad;

-- Parte B 2.c - 3 vistas con subconsultas o consultas anidadas

-- Vista 8: Sucursales con más de 1 empleado (HAVING)
CREATE OR REPLACE VIEW v_sucursales_con_empleados AS
SELECT
 s.Ciudad AS Sucursal,
 COUNT(e.LegEmp) AS CantEmpleados
FROM SUCURSALES s
JOIN EMPLEADOS e ON s.NrSuc = e.NrSuc
GROUP BY s.Ciudad
HAVING COUNT(e.LegEmp) > 1;

-- Vista 9: Cuentas con saldo mayor al promedio (Subconsulta)
CREATE OR REPLACE VIEW v_cuentas_sobre_promedio AS
SELECT
 c.NrCuenta,
 cl.Apellido AS Cliente,
 c.Saldo,
 tc.Descripcion AS TipoCuenta
FROM CUENTAS c
JOIN CLIENTES cl ON c.DNI = cl.DNI
JOIN TIPOSCUENTAS tc ON c.TipoCuenta = tc.TipoCuenta
WHERE c.Saldo::NUMERIC > (SELECT AVG(Saldo::NUMERIC) FROM CUENTAS);

-- Vista 10: Clientes que tienen más de una cuenta
CREATE OR REPLACE VIEW v_clientes_multiples_cuentas AS
SELECT
 cl.DNI,
 cl.Apellido,
 cl.Ciudad,
 COUNT(c.NrCuenta) AS CantCuentas
FROM CLIENTES cl
JOIN CUENTAS c ON cl.DNI = c.DNI
GROUP BY cl.DNI, cl.Apellido, cl.Ciudad
HAVING COUNT(c.NrCuenta) > 1;

-- ============================================================
-- C.1 - SP para Insertar, Modificar y Eliminar registros
-- ============================================================
-- SP para insertar un cliente
CREATE OR REPLACE PROCEDURE sp_insertar_cliente(
 p_dni INT,
 p_apellido CHAR(30),
 p_ciudad CHAR(30),
 p_codciud INT
)
LANGUAGE plpgsql AS $$
BEGIN
 INSERT INTO CLIENTES (DNI, Apellido, Ciudad, CodCiud)
 VALUES (p_dni, p_apellido, p_ciudad, p_codciud);
END; $$;

-- SP para modificar un cliente
CREATE OR REPLACE PROCEDURE sp_modificar_cliente(
 p_dni INT,
 p_apellido CHAR(30),
 p_ciudad CHAR(30),
 p_codciud INT
)
LANGUAGE plpgsql AS $$
BEGIN
 UPDATE CLIENTES
 SET Apellido = p_apellido,
 Ciudad = p_ciudad,
 CodCiud = p_codciud
 WHERE DNI = p_dni;
END; $$;

-- SP para eliminar un cliente
CREATE OR REPLACE PROCEDURE sp_eliminar_cliente(p_dni INT)
LANGUAGE plpgsql AS $$
BEGIN
 DELETE FROM CLIENTES WHERE DNI = p_dni;
END; $$;

-- SP para insertar una cuenta
CREATE OR REPLACE PROCEDURE sp_insertar_cuenta(
 p_nrcuenta INT,
 p_tipocuenta INT,
 p_saldo MONEY,
 p_dni INT,
 p_nrsuc INT
)
LANGUAGE plpgsql AS $$
BEGIN
 INSERT INTO CUENTAS (NrCuenta, TipoCuenta, Saldo, DNI, NrSuc)
 VALUES (p_nrcuenta, p_tipocuenta, p_saldo, p_dni, p_nrsuc);
END; $$;

-- SP para modificar una cuenta
CREATE OR REPLACE PROCEDURE sp_modificar_cuenta(
 p_nrcuenta INT,
 p_tipocuenta INT,
 p_saldo MONEY,
 p_dni INT,
 p_nrsuc INT
)
LANGUAGE plpgsql AS $$
BEGIN
 UPDATE CUENTAS
 SET TipoCuenta = p_tipocuenta,
 Saldo = p_saldo,
 DNI = p_dni,
 NrSuc = p_nrsuc
 WHERE NrCuenta = p_nrcuenta;
END; $$;

-- SP para eliminar una cuenta
CREATE OR REPLACE PROCEDURE sp_eliminar_cuenta(p_nrcuenta INT)
LANGUAGE plpgsql AS $$
BEGIN
 DELETE FROM CUENTAS WHERE NrCuenta = p_nrcuenta;
END; $$;

-- SP para insertar una sucursal
CREATE OR REPLACE PROCEDURE sp_insertar_sucursal(
 p_nrsuc INT,
 p_ciudad CHAR(30),
 p_codciud INT
)
LANGUAGE plpgsql AS $$
BEGIN
 INSERT INTO SUCURSALES (NrSuc, Ciudad, CodCiud)
 VALUES (p_nrsuc, p_ciudad, p_codciud);
END; $$;

-- SP para modificar una sucursal
CREATE OR REPLACE PROCEDURE sp_modificar_sucursal(
 p_nrsuc INT,
 p_ciudad CHAR(30),
 p_codciud INT
)
LANGUAGE plpgsql AS $$
BEGIN
 UPDATE SUCURSALES
 SET Ciudad = p_ciudad,
 CodCiud = p_codciud
 WHERE NrSuc = p_nrsuc;
END; $$;

-- SP para eliminar una sucursal
CREATE OR REPLACE PROCEDURE sp_eliminar_sucursal(p_nrsuc INT)
LANGUAGE plpgsql AS $$
BEGIN
 DELETE FROM SUCURSALES WHERE NrSuc = p_nrsuc;
END; $$;

-- SP para insertar un empleado
CREATE OR REPLACE PROCEDURE sp_insertar_empleado(
 p_legemp INT,
 p_apellido CHAR(30),
 p_nombre CHAR(30),
 p_fechaingreso DATE,
 p_nrsuc INT,
 p_codcateg INT,
 p_codciud INT
)
LANGUAGE plpgsql AS $$
BEGIN
 INSERT INTO EMPLEADOS (LegEmp, Apellido, Nombre, FechaIngreso, NrSuc, CodCateg, CodCiud)
 VALUES (p_legemp, p_apellido, p_nombre, p_fechaingreso, p_nrsuc, p_codcateg, p_codciud);
END; $$;

-- SP para modificar un empleado
CREATE OR REPLACE PROCEDURE sp_modificar_empleado(
 p_legemp INT,
 p_apellido CHAR(30),
 p_nombre CHAR(30),
 p_fechaingreso DATE,
 p_nrsuc INT,
 p_codcateg INT,
 p_codciud INT
)
LANGUAGE plpgsql AS $$
BEGIN
 UPDATE EMPLEADOS
 SET Apellido = p_apellido,
 Nombre = p_nombre,
 FechaIngreso = p_fechaingreso,
 NrSuc = p_nrsuc,
 CodCateg = p_codcateg,
 CodCiud = p_codciud
 WHERE LegEmp = p_legemp;
END; $$;

-- SP para eliminar un empleado
CREATE OR REPLACE PROCEDURE sp_eliminar_empleado(p_legemp INT)
LANGUAGE plpgsql AS $$
BEGIN
 DELETE FROM EMPLEADOS WHERE LegEmp = p_legemp;
END; $$;

-- SP para insertar una ciudad
CREATE OR REPLACE PROCEDURE sp_insertar_ciudad(
 p_codciud INT,
 p_ciudad CHAR(30),
 p_codprov INT
)
LANGUAGE plpgsql AS $$
BEGIN
 INSERT INTO CIUDADES (CodCiud, Ciudad, CodProv)
 VALUES (p_codciud, p_ciudad, p_codprov);
END; $$;

-- SP para modificar una ciudad
CREATE OR REPLACE PROCEDURE sp_modificar_ciudad(
 p_codciud INT,
 p_ciudad CHAR(30),
 p_codprov INT
)
LANGUAGE plpgsql AS $$
BEGIN
 UPDATE CIUDADES
 SET Ciudad = p_ciudad,
 CodProv = p_codprov
 WHERE CodCiud = p_codciud;
END; $$;

-- SP para eliminar una ciudad
CREATE OR REPLACE PROCEDURE sp_eliminar_ciudad(p_codciud INT)
LANGUAGE plpgsql AS $$
BEGIN
 DELETE FROM CIUDADES WHERE CodCiud = p_codciud;
END; $$;

-- SP para insertar una provincia
CREATE OR REPLACE PROCEDURE sp_insertar_provincia(
 p_codprov INT,
 p_provincia CHAR(30)
)
LANGUAGE plpgsql AS $$
BEGIN
 INSERT INTO PROVINCIAS (CodProv, Provincia)
 VALUES (p_codprov, p_provincia);
END; $$;

-- SP para modificar una provincia
CREATE OR REPLACE PROCEDURE sp_modificar_provincia(
 p_codprov INT,
 p_provincia CHAR(30)
)
LANGUAGE plpgsql AS $$
BEGIN
 UPDATE PROVINCIAS
 SET Provincia = p_provincia
 WHERE CodProv = p_codprov;
END; $$;

-- SP para eliminar una provincia
CREATE OR REPLACE PROCEDURE sp_eliminar_provincia(p_codprov INT)
LANGUAGE plpgsql AS $$
BEGIN
 DELETE FROM PROVINCIAS WHERE CodProv = p_codprov;
END; $$;

-- ============================================================
-- C.2 - Funciones de consulta por tabla
-- ============================================================

-- CLIENTES
CREATE OR REPLACE FUNCTION fn_consultar_cliente_dni(p_dni INT)
RETURNS TABLE (DNI INT, Apellido CHAR(30), Ciudad CHAR(30), CodCiud INT)
LANGUAGE plpgsql AS $$
BEGIN
 RETURN QUERY
 SELECT cl.DNI, cl.Apellido, cl.Ciudad, cl.CodCiud
 FROM CLIENTES cl WHERE cl.DNI = p_dni;
END; $$;

CREATE OR REPLACE FUNCTION fn_consultar_cliente_ciudad(p_ciudad CHAR(30))
RETURNS TABLE (DNI INT, Apellido CHAR(30), Ciudad CHAR(30), CodCiud INT)
LANGUAGE plpgsql AS $$
BEGIN
 RETURN QUERY
 SELECT cl.DNI, cl.Apellido, cl.Ciudad, cl.CodCiud
 FROM CLIENTES cl WHERE cl.Ciudad = p_ciudad;
END; $$;

-- CUENTAS
CREATE OR REPLACE FUNCTION fn_consultar_cuenta_nro(p_nrcuenta INT)
RETURNS TABLE (NrCuenta INT, TipoCuenta INT, Saldo MONEY, DNI INT, NrSuc INT)
LANGUAGE plpgsql AS $$
BEGIN
 RETURN QUERY
 SELECT c.NrCuenta, c.TipoCuenta, c.Saldo, c.DNI, c.NrSuc
 FROM CUENTAS c WHERE c.NrCuenta = p_nrcuenta;
END; $$;

CREATE OR REPLACE FUNCTION fn_consultar_cuenta_cliente(p_dni INT)
RETURNS TABLE (NrCuenta INT, TipoCuenta INT, Saldo MONEY, DNI INT, NrSuc INT)
LANGUAGE plpgsql AS $$
BEGIN
 RETURN QUERY
 SELECT c.NrCuenta, c.TipoCuenta, c.Saldo, c.DNI, c.NrSuc
 FROM CUENTAS c WHERE c.DNI = p_dni;
END; $$;

-- SUCURSALES
CREATE OR REPLACE FUNCTION fn_consultar_sucursal_nro(p_nrsuc INT)
RETURNS TABLE (NrSuc INT, Ciudad CHAR(30), CodCiud INT)
LANGUAGE plpgsql AS $$
BEGIN
 RETURN QUERY
 SELECT s.NrSuc, s.Ciudad, s.CodCiud
 FROM SUCURSALES s WHERE s.NrSuc = p_nrsuc;
END; $$;

CREATE OR REPLACE FUNCTION fn_consultar_sucursal_ciudad(p_ciudad CHAR(30))
RETURNS TABLE (NrSuc INT, Ciudad CHAR(30), CodCiud INT)
LANGUAGE plpgsql AS $$
BEGIN
 RETURN QUERY
 SELECT s.NrSuc, s.Ciudad, s.CodCiud
 FROM SUCURSALES s WHERE s.Ciudad = p_ciudad;
END; $$;

-- EMPLEADOS
CREATE OR REPLACE FUNCTION fn_consultar_empleado_leg(p_legemp INT)
RETURNS TABLE (LegEmp INT, Apellido CHAR(30), Nombre CHAR(30),
 FechaIngreso DATE, NrSuc INT, CodCateg INT, CodCiud INT)
LANGUAGE plpgsql AS $$
BEGIN
 RETURN QUERY
 SELECT e.LegEmp, e.Apellido, e.Nombre, e.FechaIngreso,
 e.NrSuc, e.CodCateg, e.CodCiud
 FROM EMPLEADOS e WHERE e.LegEmp = p_legemp;
END; $$;

CREATE OR REPLACE FUNCTION fn_consultar_empleado_sucursal(p_nrsuc INT)
RETURNS TABLE (LegEmp INT, Apellido CHAR(30), Nombre CHAR(30),
 FechaIngreso DATE, NrSuc INT, CodCateg INT, CodCiud INT)
LANGUAGE plpgsql AS $$
BEGIN
 RETURN QUERY
 SELECT e.LegEmp, e.Apellido, e.Nombre, e.FechaIngreso,
 e.NrSuc, e.CodCateg, e.CodCiud
 FROM EMPLEADOS e WHERE e.NrSuc = p_nrsuc;
END; $$;

-- CIUDADES
CREATE OR REPLACE FUNCTION fn_consultar_ciudad_cod(p_codciud INT)
RETURNS TABLE (CodCiud INT, Ciudad CHAR(30), CodProv INT)
LANGUAGE plpgsql AS $$
BEGIN
 RETURN QUERY
 SELECT c.CodCiud, c.Ciudad, c.CodProv
 FROM CIUDADES c WHERE c.CodCiud = p_codciud;
END; $$;

CREATE OR REPLACE FUNCTION fn_consultar_ciudad_nombre(p_ciudad CHAR(30))
RETURNS TABLE (CodCiud INT, Ciudad CHAR(30), CodProv INT)
LANGUAGE plpgsql AS $$
BEGIN
 RETURN QUERY
 SELECT c.CodCiud, c.Ciudad, c.CodProv
 FROM CIUDADES c WHERE c.Ciudad = p_ciudad;
END; $$;

-- PROVINCIAS
CREATE OR REPLACE FUNCTION fn_consultar_provincia_cod(p_codprov INT)
RETURNS TABLE (CodProv INT, Provincia CHAR(30))
LANGUAGE plpgsql AS $$
BEGIN
 RETURN QUERY
 SELECT p.CodProv, p.Provincia
 FROM PROVINCIAS p WHERE p.CodProv = p_codprov;
END; $$;

CREATE OR REPLACE FUNCTION fn_consultar_provincia_nombre(p_provincia CHAR(30))
RETURNS TABLE (CodProv INT, Provincia CHAR(30))
LANGUAGE plpgsql AS $$
BEGIN
 RETURN QUERY
 SELECT p.CodProv, p.Provincia
 FROM PROVINCIAS p WHERE p.Provincia = p_provincia;
END; $$;

-- ============================================================
-- C.3 y C.4 - INSERT con control de errores
-- ============================================================

-- CLIENTES con control de errores
CREATE OR REPLACE PROCEDURE sp_insertar_cliente_v2(
 p_dni INT,
 p_apellido CHAR(30),
 p_ciudad CHAR(30),
 p_codciud INT
)
LANGUAGE plpgsql AS $$
BEGIN
 IF EXISTS (SELECT 1 FROM CLIENTES WHERE DNI = p_dni) THEN
 RAISE EXCEPTION 'Ya existe un cliente con DNI %', p_dni;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM CIUDADES WHERE CodCiud = p_codciud) THEN
 RAISE EXCEPTION 'No existe la ciudad con código %', p_codciud;
 END IF;
 INSERT INTO CLIENTES (DNI, Apellido, Ciudad, CodCiud)
 VALUES (p_dni, p_apellido, p_ciudad, p_codciud);
 RAISE NOTICE 'Cliente % insertado correctamente', p_dni;
END; $$;

-- CUENTAS con control de errores
CREATE OR REPLACE PROCEDURE sp_insertar_cuenta_v2(
 p_nrcuenta INT,
 p_tipocuenta INT,
 p_saldo MONEY,
 p_dni INT,
 p_nrsuc INT
)
LANGUAGE plpgsql AS $$
BEGIN
 IF EXISTS (SELECT 1 FROM CUENTAS WHERE NrCuenta = p_nrcuenta) THEN
 RAISE EXCEPTION 'Ya existe una cuenta con número %', p_nrcuenta;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM CLIENTES WHERE DNI = p_dni) THEN
 RAISE EXCEPTION 'No existe el cliente con DNI %', p_dni;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM SUCURSALES WHERE NrSuc = p_nrsuc) THEN
 RAISE EXCEPTION 'No existe la sucursal con número %', p_nrsuc;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM TIPOSCUENTAS WHERE TipoCuenta = p_tipocuenta) THEN
 RAISE EXCEPTION 'No existe el tipo de cuenta %', p_tipocuenta;
 END IF;
 INSERT INTO CUENTAS (NrCuenta, TipoCuenta, Saldo, DNI, NrSuc)
 VALUES (p_nrcuenta, p_tipocuenta, p_saldo, p_dni, p_nrsuc);
 RAISE NOTICE 'Cuenta % insertada correctamente', p_nrcuenta;
END; $$;

-- SUCURSALES con control de errores
CREATE OR REPLACE PROCEDURE sp_insertar_sucursal_v2(
 p_nrsuc INT,
 p_ciudad CHAR(30),
 p_codciud INT
)
LANGUAGE plpgsql AS $$
BEGIN
 IF EXISTS (SELECT 1 FROM SUCURSALES WHERE NrSuc = p_nrsuc) THEN
 RAISE EXCEPTION 'Ya existe una sucursal con número %', p_nrsuc;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM CIUDADES WHERE CodCiud = p_codciud) THEN
 RAISE EXCEPTION 'No existe la ciudad con código %', p_codciud;
 END IF;
 INSERT INTO SUCURSALES (NrSuc, Ciudad, CodCiud)
 VALUES (p_nrsuc, p_ciudad, p_codciud);
 RAISE NOTICE 'Sucursal % insertada correctamente', p_nrsuc;
END; $$;

-- EMPLEADOS con control de errores
CREATE OR REPLACE PROCEDURE sp_insertar_empleado_v2(
 p_legemp INT,
 p_apellido CHAR(30),
 p_nombre CHAR(30),
 p_fechaingreso DATE,
 p_nrsuc INT,
 p_codcateg INT,
 p_codciud INT
)
LANGUAGE plpgsql AS $$
BEGIN
 IF EXISTS (SELECT 1 FROM EMPLEADOS WHERE LegEmp = p_legemp) THEN
 RAISE EXCEPTION 'Ya existe un empleado con legajo %', p_legemp;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM SUCURSALES WHERE NrSuc = p_nrsuc) THEN
 RAISE EXCEPTION 'No existe la sucursal con número %', p_nrsuc;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM CATEGORIAS WHERE CodCateg = p_codcateg) THEN
 RAISE EXCEPTION 'No existe la categoría con código %', p_codcateg;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM CIUDADES WHERE CodCiud = p_codciud) THEN
 RAISE EXCEPTION 'No existe la ciudad con código %', p_codciud;
 END IF;
 INSERT INTO EMPLEADOS (LegEmp, Apellido, Nombre, FechaIngreso, NrSuc, CodCateg, CodCiud)
 VALUES (p_legemp, p_apellido, p_nombre, p_fechaingreso, p_nrsuc, p_codcateg, p_codciud);
 RAISE NOTICE 'Empleado % insertado correctamente', p_legemp;
END; $$;

-- CIUDADES con control de errores
CREATE OR REPLACE PROCEDURE sp_insertar_ciudad_v2(
 p_codciud INT,
 p_ciudad CHAR(30),
 p_codprov INT
)
LANGUAGE plpgsql AS $$
BEGIN
 IF EXISTS (SELECT 1 FROM CIUDADES WHERE CodCiud = p_codciud) THEN
 RAISE EXCEPTION 'Ya existe una ciudad con código %', p_codciud;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM PROVINCIAS WHERE CodProv = p_codprov) THEN
 RAISE EXCEPTION 'No existe la provincia con código %', p_codprov;
 END IF;
 INSERT INTO CIUDADES (CodCiud, Ciudad, CodProv)
 VALUES (p_codciud, p_ciudad, p_codprov);
 RAISE NOTICE 'Ciudad % insertada correctamente', p_codciud;
END; $$;

-- PROVINCIAS con control de errores
CREATE OR REPLACE PROCEDURE sp_insertar_provincia_v2(
 p_codprov INT,
 p_provincia CHAR(30)
)
LANGUAGE plpgsql AS $$
BEGIN
 IF EXISTS (SELECT 1 FROM PROVINCIAS WHERE CodProv = p_codprov) THEN
 RAISE EXCEPTION 'Ya existe una provincia con código %', p_codprov;
 END IF;
 INSERT INTO PROVINCIAS (CodProv, Provincia)
 VALUES (p_codprov, p_provincia);
 RAISE NOTICE 'Provincia % insertada correctamente', p_codprov;
END; $$;

-- ============================================================
-- C.5 - UPDATE con control de errores
-- ============================================================

-- CLIENTES con control de errores
CREATE OR REPLACE PROCEDURE sp_actualizar_cliente_v2(
 p_dni INT,
 p_apellido CHAR(30),
 p_ciudad CHAR(30),
 p_codciud INT
)
LANGUAGE plpgsql AS $$
BEGIN
 IF NOT EXISTS (SELECT 1 FROM CLIENTES WHERE DNI = p_dni) THEN
 RAISE EXCEPTION 'No existe el cliente con DNI %', p_dni;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM CIUDADES WHERE CodCiud = p_codciud) THEN
 RAISE EXCEPTION 'No existe la ciudad con código %', p_codciud;
 END IF;
 UPDATE CLIENTES
 SET Apellido = p_apellido,
 Ciudad = p_ciudad,
 CodCiud = p_codciud
 WHERE DNI = p_dni;
 RAISE NOTICE 'Cliente % actualizado correctamente', p_dni;
END; $$;

-- CUENTAS con control de errores
CREATE OR REPLACE PROCEDURE sp_actualizar_cuenta_v2(
 p_nrcuenta INT,
 p_tipocuenta INT,
 p_saldo MONEY,
 p_nrsuc INT
)
LANGUAGE plpgsql AS $$
BEGIN
 IF NOT EXISTS (SELECT 1 FROM CUENTAS WHERE NrCuenta = p_nrcuenta) THEN
 RAISE EXCEPTION 'No existe la cuenta con número %', p_nrcuenta;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM TIPOSCUENTAS WHERE TipoCuenta = p_tipocuenta) THEN
 RAISE EXCEPTION 'No existe el tipo de cuenta %', p_tipocuenta;
 END IF;
 IF p_saldo < '0'::MONEY THEN
 RAISE EXCEPTION 'El saldo no puede ser negativo';
 END IF;
 UPDATE CUENTAS
 SET TipoCuenta = p_tipocuenta,
 Saldo = p_saldo,
 NrSuc = p_nrsuc
 WHERE NrCuenta = p_nrcuenta;
 RAISE NOTICE 'Cuenta % actualizada correctamente', p_nrcuenta;
END; $$;

-- SUCURSALES con control de errores
CREATE OR REPLACE PROCEDURE sp_actualizar_sucursal_v2(
 p_nrsuc INT,
 p_ciudad CHAR(30),
 p_codciud INT
)
LANGUAGE plpgsql AS $$
BEGIN
 IF NOT EXISTS (SELECT 1 FROM SUCURSALES WHERE NrSuc = p_nrsuc) THEN
 RAISE EXCEPTION 'No existe la sucursal con número %', p_nrsuc;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM CIUDADES WHERE CodCiud = p_codciud) THEN
 RAISE EXCEPTION 'No existe la ciudad con código %', p_codciud;
 END IF;
 UPDATE SUCURSALES
 SET Ciudad = p_ciudad,
 CodCiud = p_codciud
 WHERE NrSuc = p_nrsuc;
 RAISE NOTICE 'Sucursal % actualizada correctamente', p_nrsuc;
END; $$;

-- EMPLEADOS con control de errores
CREATE OR REPLACE PROCEDURE sp_actualizar_empleado_v2(
 p_legemp INT,
 p_apellido CHAR(30),
 p_nombre CHAR(30),
 p_fechaingreso DATE,
 p_nrsuc INT,
 p_codcateg INT,
 p_codciud INT
)
LANGUAGE plpgsql AS $$
BEGIN
 IF NOT EXISTS (SELECT 1 FROM EMPLEADOS WHERE LegEmp = p_legemp) THEN
 RAISE EXCEPTION 'No existe el empleado con legajo %', p_legemp;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM SUCURSALES WHERE NrSuc = p_nrsuc) THEN
 RAISE EXCEPTION 'No existe la sucursal con número %', p_nrsuc;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM CATEGORIAS WHERE CodCateg = p_codcateg) THEN
 RAISE EXCEPTION 'No existe la categoría con código %', p_codcateg;
 END IF;
 UPDATE EMPLEADOS
 SET Apellido = p_apellido,
 Nombre = p_nombre,
 FechaIngreso = p_fechaingreso,
 NrSuc = p_nrsuc,
 CodCateg = p_codcateg,
 CodCiud = p_codciud
 WHERE LegEmp = p_legemp;
 RAISE NOTICE 'Empleado % actualizado correctamente', p_legemp;
END; $$;

-- CIUDADES con control de errores
CREATE OR REPLACE PROCEDURE sp_actualizar_ciudad_v2(
 p_codciud INT,
 p_ciudad CHAR(30),
 p_codprov INT
)
LANGUAGE plpgsql AS $$
BEGIN
 IF NOT EXISTS (SELECT 1 FROM CIUDADES WHERE CodCiud = p_codciud) THEN
 RAISE EXCEPTION 'No existe la ciudad con código %', p_codciud;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM PROVINCIAS WHERE CodProv = p_codprov) THEN
 RAISE EXCEPTION 'No existe la provincia con código %', p_codprov;
 END IF;
 UPDATE CIUDADES
 SET Ciudad = p_ciudad,
 CodProv = p_codprov
 WHERE CodCiud = p_codciud;
 RAISE NOTICE 'Ciudad % actualizada correctamente', p_codciud;
END; $$;

-- PROVINCIAS con control de errores
CREATE OR REPLACE PROCEDURE sp_actualizar_provincia_v2(
 p_codprov INT,
 p_provincia CHAR(30)
)
LANGUAGE plpgsql AS $$
BEGIN
 IF NOT EXISTS (SELECT 1 FROM PROVINCIAS WHERE CodProv = p_codprov) THEN
 RAISE EXCEPTION 'No existe la provincia con código %', p_codprov;
 END IF;
 UPDATE PROVINCIAS
 SET Provincia = p_provincia
 WHERE CodProv = p_codprov;
 RAISE NOTICE 'Provincia % actualizada correctamente', p_codprov;
END; $$;

-- ============================================================
-- C.6 - SP combinados vinculando 2 o 3 tablas
-- ============================================================

-- SP 1: Registrar un movimiento y actualizar el saldo de la cuenta
CREATE OR REPLACE PROCEDURE sp_registrar_movimiento(
 p_nrmov INT,
 p_nrcuenta INT,
 p_codop INT,
 p_monto MONEY,
 p_fecha DATE
)
LANGUAGE plpgsql AS $$
DECLARE
 v_tipooperacion CHAR(50);
 v_tipocuenta INT;
BEGIN
 IF NOT EXISTS (SELECT 1 FROM CUENTAS WHERE NrCuenta = p_nrcuenta) THEN
 RAISE EXCEPTION 'No existe la cuenta con número %', p_nrcuenta;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM OPERACIONES WHERE CodOp = p_codop) THEN
 RAISE EXCEPTION 'No existe la operación con código %', p_codop;
 END IF;
 IF p_monto <= '0'::MONEY THEN
 RAISE EXCEPTION 'El monto debe ser mayor a cero';
 END IF;
 SELECT t.TipoOperacion INTO v_tipooperacion FROM OPERACIONES o
 JOIN TIPOSOPERACIONES t ON o.CodTipoOp = t.CodTipoOp
 WHERE o.CodOp = p_codop;
 SELECT TipoCuenta INTO v_tipocuenta FROM CUENTAS WHERE NrCuenta = p_nrcuenta;
 INSERT INTO MOVIMIENTOS (NrMov, Monto, Fecha, NrCuenta, CodOp, TipoCuenta)
 VALUES (p_nrmov, p_monto, p_fecha, p_nrcuenta, p_codop, v_tipocuenta);
 IF v_tipooperacion = 'Haber' THEN
 UPDATE CUENTAS SET Saldo = Saldo + p_monto WHERE NrCuenta = p_nrcuenta;
 ELSE
 UPDATE CUENTAS SET Saldo = Saldo - p_monto WHERE NrCuenta = p_nrcuenta;
 END IF;
 RAISE NOTICE 'Movimiento % registrado y saldo actualizado', p_nrmov;
END; $$;

-- SP 2: Transferencia entre cuentas
CREATE OR REPLACE PROCEDURE sp_transferencia(
 p_nrmov_sal INT,
 p_nrmov_ent INT,
 p_cuenta_origen INT,
 p_cuenta_destino INT,
 p_monto MONEY,
 p_fecha DATE
)
LANGUAGE plpgsql AS $$
DECLARE
 v_saldo_origen MONEY;
 v_tipocuenta_origen INT;
 v_tipocuenta_destino INT;
BEGIN
 IF NOT EXISTS (SELECT 1 FROM CUENTAS WHERE NrCuenta = p_cuenta_origen) THEN
 RAISE EXCEPTION 'No existe la cuenta origen %', p_cuenta_origen;
 END IF;
 IF NOT EXISTS (SELECT 1 FROM CUENTAS WHERE NrCuenta = p_cuenta_destino) THEN
 RAISE EXCEPTION 'No existe la cuenta destino %', p_cuenta_destino;
 END IF;
 SELECT Saldo INTO v_saldo_origen FROM CUENTAS WHERE NrCuenta = p_cuenta_origen;
 IF v_saldo_origen < p_monto THEN
 RAISE EXCEPTION 'Saldo insuficiente en cuenta %', p_cuenta_origen;
 END IF;
 SELECT TipoCuenta INTO v_tipocuenta_origen FROM CUENTAS WHERE NrCuenta = p_cuenta_origen;
 SELECT TipoCuenta INTO v_tipocuenta_destino FROM CUENTAS WHERE NrCuenta = p_cuenta_destino;
 INSERT INTO MOVIMIENTOS (NrMov, Monto, Fecha, NrCuenta, CodOp, TipoCuenta)
 VALUES (p_nrmov_sal, p_monto, p_fecha, p_cuenta_origen, 5, v_tipocuenta_origen);
 INSERT INTO MOVIMIENTOS (NrMov, Monto, Fecha, NrCuenta, CodOp, TipoCuenta)
 VALUES (p_nrmov_ent, p_monto, p_fecha, p_cuenta_destino, 6, v_tipocuenta_destino);
 UPDATE CUENTAS SET Saldo = Saldo - p_monto WHERE NrCuenta = p_cuenta_origen;
 UPDATE CUENTAS SET Saldo = Saldo + p_monto WHERE NrCuenta = p_cuenta_destino;
 RAISE NOTICE 'Transferencia de % realizada correctamente', p_monto;
END; $$;

-- SP 3: Crear cliente y cuenta en una sola operación
CREATE OR REPLACE PROCEDURE sp_alta_cliente_cuenta(
 p_dni INT,
 p_apellido CHAR(30),
 p_ciudad CHAR(30),
 p_codciud INT,
 p_nrcuenta INT,
 p_tipocuenta INT,
 p_saldo_inicial MONEY,
 p_nrsuc INT
)
LANGUAGE plpgsql AS $$
BEGIN
 IF EXISTS (SELECT 1 FROM CLIENTES WHERE DNI = p_dni) THEN
 RAISE EXCEPTION 'Ya existe un cliente con DNI %', p_dni;
 END IF;
 IF EXISTS (SELECT 1 FROM CUENTAS WHERE NrCuenta = p_nrcuenta) THEN
 RAISE EXCEPTION 'Ya existe una cuenta con número %', p_nrcuenta;
 END IF;
 INSERT INTO CLIENTES (DNI, Apellido, Ciudad, CodCiud)
 VALUES (p_dni, p_apellido, p_ciudad, p_codciud);
 INSERT INTO CUENTAS (NrCuenta, TipoCuenta, Saldo, DNI, NrSuc)
 VALUES (p_nrcuenta, p_tipocuenta, p_saldo_inicial, p_dni, p_nrsuc);
 RAISE NOTICE 'Cliente % y cuenta % creados correctamente', p_dni, p_nrcuenta;
END; $$;

-- SP 4: Consultar resumen de cliente con sus cuentas y saldos
CREATE OR REPLACE FUNCTION fn_resumen_cliente(p_dni INT)
RETURNS TABLE (
 DNI INT,
 Apellido CHAR(30),
 NrCuenta INT,
 TipoCuenta CHAR(30),
 Saldo MONEY,
 Sucursal CHAR(30)
 )
LANGUAGE plpgsql AS $$
BEGIN
 IF NOT EXISTS (SELECT 1 FROM CLIENTES WHERE CLIENTES.DNI = p_dni) THEN
 RAISE EXCEPTION 'No existe el cliente con DNI %', p_dni;
 END IF;
 RETURN QUERY
 SELECT cl.DNI, cl.Apellido, c.NrCuenta, tc.Descripcion, c.Saldo, s.Ciudad
 FROM CLIENTES cl
 JOIN CUENTAS c ON cl.DNI = c.DNI
 JOIN TIPOSCUENTAS tc ON c.TipoCuenta = tc.TipoCuenta
 JOIN SUCURSALES s ON c.NrSuc = s.NrSuc
 WHERE cl.DNI = p_dni;
END; $$;

-- SP 5: Consultar movimientos de una cuenta con detalle
CREATE OR REPLACE FUNCTION fn_movimientos_cuenta(p_nrcuenta INT)
RETURNS TABLE (
 NrMov INT,
 Fecha DATE,
 Operacion CHAR(50),
 DebeHaber CHAR(50),
 Monto MONEY,
 SaldoActual MONEY
)
LANGUAGE plpgsql AS $$
BEGIN
 IF NOT EXISTS (SELECT 1 FROM CUENTAS WHERE NrCuenta = p_nrcuenta) THEN
 RAISE EXCEPTION 'No existe la cuenta con número %', p_nrcuenta;
 END IF;
 RETURN QUERY
 SELECT o.Operacion, t.TipoOperacion, m.NrMov, m.Fecha, m.Monto, c.Saldo
 FROM MOVIMIENTOS m
 JOIN OPERACIONES o ON m.CodOp = o.CodOp
 JOIN TIPOSOPERACIONES t ON o.CodTipoOp = t.CodTipoOp
 JOIN CUENTAS c ON m.NrCuenta = c.NrCuenta
 WHERE m.NrCuenta = p_nrcuenta
 ORDER BY m.Fecha DESC;
END; $$;

-- ============================================================
-- D.1 - Triggers de Auditoría
-- ============================================================

-- Tabla de auditoría para CUENTAS
CREATE TABLE IF NOT EXISTS registros_cuentas (
 id_registro SERIAL PRIMARY KEY,
 fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 operacion CHAR(10),
 nrcuenta INT,
 tipocuenta_ant INT,
 tipocuenta_new INT,
 saldo_ant MONEY,
 saldo_new MONEY,
 dni_ant INT,
 dni_new INT,
 nrsuc_ant INT,
 nrsuc_new INT
);

-- Función del trigger de auditoría para CUENTAS
CREATE OR REPLACE FUNCTION fn_auditoria_cuentas()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
 IF TG_OP = 'INSERT' THEN
 INSERT INTO registros_cuentas
 (operacion, nrcuenta, tipocuenta_new, saldo_new, dni_new, nrsuc_new)
 VALUES
 ('INSERT', NEW.NrCuenta, NEW.TipoCuenta, NEW.Saldo, NEW.DNI, NEW.NrSuc);
 ELSIF TG_OP = 'UPDATE' THEN
 INSERT INTO registros_cuentas
 (operacion, nrcuenta, tipocuenta_ant, tipocuenta_new,
 saldo_ant, saldo_new, dni_ant, dni_new, nrsuc_ant, nrsuc_new)
 VALUES
 ('UPDATE', NEW.NrCuenta, OLD.TipoCuenta, NEW.TipoCuenta,
 OLD.Saldo, NEW.Saldo, OLD.DNI, NEW.DNI, OLD.NrSuc, NEW.NrSuc);
 END IF;
 RETURN NEW;
END; $$;

-- Trigger sobre CUENTAS
CREATE TRIGGER trg_auditoria_cuentas
AFTER INSERT OR UPDATE ON CUENTAS
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_cuentas();

-- Tabla de auditoría para MOVIMIENTOS
CREATE TABLE IF NOT EXISTS registros_movimientos (
 id_registro SERIAL PRIMARY KEY,
 fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 operacion CHAR(10),
 nrmov INT,
 nrcuenta_ant INT,
 nrcuenta_new INT,
 codop_ant INT,
 codop_new INT,
 monto_ant MONEY,
 monto_new MONEY,
 fecha_ant DATE,
 fecha_new DATE
);

-- Función del trigger de auditoría para MOVIMIENTOS
CREATE OR REPLACE FUNCTION fn_auditoria_movimientos()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
 IF TG_OP = 'INSERT' THEN
 INSERT INTO registros_movimientos
 (operacion, nrmov, nrcuenta_new, codop_new, monto_new, fecha_new)
 VALUES
 ('INSERT', NEW.NrMov, NEW.NrCuenta, NEW.CodOp, NEW.Monto, NEW.Fecha);
 ELSIF TG_OP = 'UPDATE' THEN
 INSERT INTO registros_movimientos
 (operacion, nrmov, nrcuenta_ant, nrcuenta_new,
 codop_ant, codop_new, monto_ant, monto_new, fecha_ant, fecha_new)
 VALUES
 ('UPDATE', NEW.NrMov, OLD.NrCuenta, NEW.NrCuenta,
 OLD.CodOp, NEW.CodOp, OLD.Monto, NEW.Monto, OLD.Fecha, NEW.Fecha);
 END IF;
 RETURN NEW;
END; $$;

-- Trigger sobre MOVIMIENTOS
CREATE TRIGGER trg_auditoria_movimientos
AFTER INSERT OR UPDATE ON MOVIMIENTOS
FOR EACH ROW EXECUTE FUNCTION fn_auditoria_movimientos();

-- ===============================================================
-- D.2 - Trigger que actualiza el saldo al registrar un movimiento
-- ===============================================================

-- Función del trigger de actualización de saldo
CREATE OR REPLACE FUNCTION fn_actualizar_saldo()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
DECLARE
 v_tipooperacion CHAR(50);
BEGIN
 SELECT t.TipoOperacion INTO v_tipooperacion FROM OPERACIONES o
 JOIN TIPOSOPERACIONES t ON o.CodTipoOp = t.CodTipoOp
 WHERE o.CodOp = NEW.CodOp;
 IF v_tipooperacion = 'Haber' THEN
 UPDATE CUENTAS SET Saldo = Saldo + NEW.Monto WHERE NrCuenta = NEW.NrCuenta;
 ELSE
 UPDATE CUENTAS SET Saldo = Saldo - NEW.Monto WHERE NrCuenta = NEW.NrCuenta;
 END IF;
 RETURN NEW;
END; $$;

-- Trigger sobre MOVIMIENTOS
CREATE TRIGGER trg_actualizar_saldo
AFTER INSERT ON MOVIMIENTOS
FOR EACH ROW EXECUTE FUNCTION fn_actualizar_saldo();

-- ===============================================================
--              DESARROLLO TRABAJO PRÁCTICO 3
-- ===============================================================
-- ===============================================================
-- G - Implementar las soluciones a los siguientes casos
-- ===============================================================

-- ===============================================================
-- G.1 - Actualizar el saldo de una cuenta en cierto %
-- ===============================================================

--SP para actualizar el saldo de una cuenta incrementándolo o disminuyéndolo según un porcentaje indicado.

CREATE OR REPLACE PROCEDURE sp_actualizar_saldo_porcentaje(
    p_nrcuenta INT,
    p_porcentaje NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_saldo MONEY;
BEGIN
    SELECT saldo
    INTO v_saldo
    FROM cuentas
    WHERE nrcuenta = p_nrcuenta;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'La cuenta % no existe', p_nrcuenta;
    END IF;

    UPDATE cuentas
    SET saldo = saldo + (saldo * p_porcentaje / 100)
    WHERE nrcuenta = p_nrcuenta;

    RAISE NOTICE 'Saldo actualizado correctamente';
END;
$$;

-- ===============================================================
-- G.2 - Modificar el domicilio de un cliente X
-- ===============================================================

--SP para modificar la ciudad y el código de ciudad asociados a un cliente determinado.

CREATE OR REPLACE PROCEDURE sp_modificar_domicilio_cliente(
    p_dni INT,
    p_ciudad CHAR(30),
    p_codciud INT
)
LANGUAGE plpgsql
AS $$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM clientes
        WHERE dni = p_dni
    ) THEN
        RAISE EXCEPTION 'Cliente inexistente';
    END IF;

    UPDATE clientes
    SET ciudad = p_ciudad,
        codciud = p_codciud
    WHERE dni = p_dni;

    RAISE NOTICE 'Domicilio actualizado';
END;
$$;

-- ===============================================================
-- G.3 - Obtener todas las cuentas pertenecientes a un cliente X
-- ===============================================================

--FN para obtener el listado completo de cuentas pertenecientes a un cliente identificado por su DNI.

CREATE OR REPLACE FUNCTION fn_cuentas_cliente(
    p_dni INT
)
RETURNS TABLE(
    nro_cuenta INT,
    tipo_cuenta INT,
    saldo MONEY,
    sucursal INT
)
LANGUAGE plpgsql
AS $$
BEGIN

    RETURN QUERY
    SELECT
        c.nrcuenta,
        c.tipocuenta,
        c.saldo,
        c.nrsuc
    FROM cuentas c
    WHERE c.dni = p_dni;

END;
$$;

-- ===============================================================
-- G.4 - Obtener la suma de los saldos de todas las cuentas de un cliente X
-- ===============================================================

--FN para calcular y devolver la suma total de los saldos de todas las cuentas de un cliente.

CREATE OR REPLACE FUNCTION fn_total_saldos_cliente(
    p_dni INT
)
RETURNS MONEY
LANGUAGE plpgsql
AS $$
DECLARE
    v_total MONEY;
BEGIN

    SELECT COALESCE(SUM(saldo),'0')
    INTO v_total
    FROM cuentas
    WHERE dni = p_dni;

    RETURN v_total;

END;
$$;

-- ===============================================================
-- G.5 - Obtener ciudad y provincia donde se encuentra la sucursal de la cuenta X
-- ===============================================================

--FN para obtener la ciudad y la provincia donde se encuentra la sucursal asociada a una cuenta específica.

CREATE OR REPLACE FUNCTION fn_ubicacion_sucursal_cuenta(
    p_nrcuenta INT
)
RETURNS TABLE(
    ciudad VARCHAR(30),
    provincia VARCHAR(30)
)
LANGUAGE plpgsql
AS $$
BEGIN

    RETURN QUERY
    SELECT
        ci.ciudad::VARCHAR(30),
        pr.provincia::VARCHAR(30)
    FROM cuentas c
         JOIN sucursales s ON c.nrsuc = s.nrsuc
         JOIN ciudades ci ON s.codciud = ci.codciud
         JOIN provincias pr ON ci.codprov = pr.codprov
    WHERE c.nrcuenta = p_nrcuenta;

END;
$$;

-- ===============================================================
-- G.6 - Calcular monto total de extracciones de una cuenta X durante los últimos N días
-- ===============================================================

--FN para calcular el monto total extraído de una cuenta durante una cantidad determinada de días.

CREATE OR REPLACE FUNCTION fn_total_extracciones(
    p_nrcuenta INT,
    p_dias INT
)
RETURNS MONEY
LANGUAGE plpgsql
AS $$
DECLARE
    v_total MONEY;
BEGIN

    SELECT COALESCE(SUM(m.monto),'0')
    INTO v_total
    FROM movimientos m
         JOIN tiposoperaciones t
              ON m.codop = t.codop
    WHERE m.nrcuenta = p_nrcuenta
      AND t.tipooperacion = 'Extracción'
      AND m.fecha >= CURRENT_DATE - p_dias;

    RETURN v_total;

END;
$$;

-- ===============================================================
-- G.7 - Obtener los últimos N movimientos sobre la cuenta X agrupados por tipo de operación
-- ===============================================================

--FN para recuperar los últimos movimientos de una cuenta y los agrupa según el tipo de operación realizada.

CREATE OR REPLACE FUNCTION fn_ultimos_movimientos(
    p_nrcuenta INT,
    p_cantidad INT
)
RETURNS TABLE(
    tipo_operacion CHAR(30),
    cantidad BIGINT,
    monto_total MONEY
)
LANGUAGE plpgsql
AS $$
BEGIN

    RETURN QUERY

    SELECT
        t.tipooperacion,
        COUNT(*),
        SUM(m.monto)
    FROM (
            SELECT *
            FROM movimientos
            WHERE nrcuenta = p_nrcuenta
            ORDER BY fecha DESC
            LIMIT p_cantidad
         ) m
         JOIN tiposoperaciones t
              ON m.codop = t.codop
    GROUP BY t.tipooperacion;

END;
$$;

-- ===============================================================
-- G.8 - Incrementar en un valor X% el sueldo de los empleados según categoría
-- ===============================================================

--SP para incrementar el sueldo base de una categoría de empleados aplicando un porcentaje especificado.

CREATE OR REPLACE PROCEDURE sp_incrementar_sueldo_categoria(
    p_codcateg INT,
    p_porcentaje NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_sueldo MONEY;
BEGIN

    SELECT sueldo
    INTO v_sueldo
    FROM categorias
    WHERE codcateg = p_codcateg;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Categoría inexistente';
    END IF;

    UPDATE categorias
    SET sueldo = sueldo + (sueldo * p_porcentaje / 100)
    WHERE codcateg = p_codcateg;

    RAISE NOTICE 'Sueldo actualizado correctamente';
END;
$$;

-- ===================================================================================
-- F:  Instrucciones con Estructuras de Control Transact-SQL (IF, ELSE,…DECLARE, SET,)
-- ===================================================================================
DROP PROCEDURE IF EXISTS sp_registrar_movimiento(INT, MONEY, DATE, INT);
DROP PROCEDURE IF EXISTS sp_alta_cliente_cuenta(INT, CHAR, CHAR, INT, INT, INT, MONEY, INT);
DROP PROCEDURE IF EXISTS sp_transferencia(INT, INT, MONEY, DATE);

-- ===================================================================================
-- F.1 - modificación de los SP
-- ===================================================================================

CREATE OR REPLACE PROCEDURE sp_registrar_movimiento(
    p_nrcuenta INT,
    p_monto MONEY,
    p_fecha DATE,
    p_codop INT,
    OUT p_codigo_error INT,
    OUT p_mensaje VARCHAR(255)
)
LANGUAGE plpgsql AS $$
DECLARE
    v_nrmov INT;
    v_tipocuenta INT;
    v_tipooperacion CHAR(50);
    v_saldo_actual MONEY;
BEGIN
    -- Inicializar salidas
    p_codigo_error := 0;
    p_mensaje := '';
    
    IF p_monto <= 0 THEN -- monto debe ser > 0
        p_codigo_error := 1;
        p_mensaje := 'Error: Monto debe ser mayor a 0';
        RETURN;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM CUENTAS WHERE NrCuenta = p_nrcuenta) THEN -- cuenta debe existir
        p_codigo_error := 2;
        p_mensaje := 'Error: Cuenta ' || p_nrcuenta || ' no existe';
        RETURN;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM OPERACIONES WHERE CodOp = p_codop) THEN     -- operación debe existir
        p_codigo_error := 3;
        p_mensaje := 'Error: Operación ' || p_codop || ' no existe';
        RETURN;
    END IF;
    
    SELECT t.TipoOperacion INTO v_tipooperacion 
    FROM OPERACIONES o
    JOIN TIPOSOPERACIONES t ON o.CodTipoOp = t.CodTipoOp
    WHERE o.CodOp = p_codop;
    
    SELECT Saldo INTO v_saldo_actual FROM CUENTAS 
    WHERE NrCuenta = p_nrcuenta;
    
    IF v_tipooperacion = 'Debe' AND v_saldo_actual < p_monto THEN -- si es Debe, debe haber saldo suficiente
        p_codigo_error := 4;
        p_mensaje := 'Error: Saldo insuficiente. Disponible: ' || v_saldo_actual;
        RETURN;
    END IF;
    
    SELECT COALESCE(MAX(NrMov), 0) + 1 INTO v_nrmov FROM MOVIMIENTOS; -- Generar siguiente NrMov
    
    SELECT TipoCuenta INTO v_tipocuenta FROM CUENTAS 
    WHERE NrCuenta = p_nrcuenta;
    
    INSERT INTO MOVIMIENTOS (NrMov, Monto, Fecha, NrCuenta, CodOp, TipoCuenta)
    VALUES (v_nrmov, p_monto, p_fecha, p_nrcuenta, p_codop, v_tipocuenta);
    
    p_codigo_error := 0;
    p_mensaje := 'Movimiento ' || v_nrmov || ' registrado correctamente';
    
EXCEPTION WHEN OTHERS THEN
    p_codigo_error := 99;
    p_mensaje := 'Error: ' || SQLERRM;
END; $$;

CREATE OR REPLACE PROCEDURE sp_alta_cliente_cuenta(
    p_dni INT,
    p_apellido CHAR(30),
    p_ciudad CHAR(30),
    p_codciud INT,
    p_nrcuenta INT,
    p_tipocuenta INT,
    p_saldo_inicial MONEY,
    p_nrsuc INT,
    OUT p_codigo_error INT,
    OUT p_mensaje VARCHAR(255)
)
LANGUAGE plpgsql AS $$
BEGIN
    p_codigo_error := 0;
    p_mensaje := '';
    
    IF EXISTS (SELECT 1 FROM CLIENTES WHERE DNI = p_dni) THEN -- Valido queDNI no debe existir
        p_codigo_error := 1;
        p_mensaje := 'Error: Cliente con DNI ' || p_dni || ' ya existe';
        RETURN;
    END IF;
    
    IF EXISTS (SELECT 1 FROM CUENTAS WHERE NrCuenta = p_nrcuenta) THEN -- Validoque NrCuenta no debe existir
        p_codigo_error := 2;
        p_mensaje := 'Error: Cuenta ' || p_nrcuenta || ' ya existe';
        RETURN;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM CIUDADES WHERE CodCiud = p_codciud) THEN -- Valido que ciudad existe
        p_codigo_error := 3;
        p_mensaje := 'Error: Ciudad ' || p_codciud || ' no existe';
        RETURN;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM SUCURSALES WHERE NrSuc = p_nrsuc) THEN -- Valido que sucursal existe
        p_codigo_error := 4;
        p_mensaje := 'Error: Sucursal ' || p_nrsuc || ' no existe';
        RETURN;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM TIPOSCUENTAS WHERE TipoCuenta = p_tipocuenta) THEN -- Valido que el tipo de cuenta existe
        p_codigo_error := 5;
        p_mensaje := 'Error: Tipo de cuenta ' || p_tipocuenta || ' no existe';
        RETURN;
    END IF;
    
    IF p_saldo_inicial < 0 THEN -- Valido que el saldo inicial >= 0
        p_codigo_error := 6;
        p_mensaje := 'Error: Saldo inicial no puede ser negativo';
        RETURN;
    END IF;
    
    INSERT INTO CLIENTES (DNI, Apellido, Ciudad, CodCiud)
    VALUES (p_dni, p_apellido, p_ciudad, p_codciud);
    
    INSERT INTO CUENTAS (NrCuenta, TipoCuenta, Saldo, DNI, NrSuc)
    VALUES (p_nrcuenta, p_tipocuenta, p_saldo_inicial, p_dni, p_nrsuc);
    
    p_codigo_error := 0;
    p_mensaje := 'Cliente ' || p_dni || ' y cuenta ' || p_nrcuenta || ' creados';
    
EXCEPTION WHEN OTHERS THEN
    p_codigo_error := 99;
    p_mensaje := 'Error: ' || SQLERRM;
END; $$;

CREATE OR REPLACE PROCEDURE sp_transferencia(
    p_nrcuenta_origen INT,
    p_nrcuenta_destino INT,
    p_monto MONEY,
    p_fecha DATE,
    OUT p_codigo_error INT,
    OUT p_mensaje VARCHAR(255)
)
LANGUAGE plpgsql AS $$
DECLARE
    v_saldo_origen MONEY;
    v_tipocuenta_origen INT;
    v_tipocuenta_destino INT;
    v_nrmov_sal INT;
    v_nrmov_ent INT;
BEGIN
    p_codigo_error := 0;
    p_mensaje := '';
    
    IF p_monto <= 0 THEN -- Valido que monto > 0
        p_codigo_error := 1;
        p_mensaje := 'Error: Monto debe ser mayor a 0';
        RETURN;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM CUENTAS WHERE NrCuenta = p_nrcuenta_origen) THEN -- Valido si ambas cuentas existen
        p_codigo_error := 2;
        p_mensaje := 'Error: Cuenta origen ' || p_nrcuenta_origen || ' no existe';
        RETURN;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM CUENTAS WHERE NrCuenta = p_nrcuenta_destino) THEN
        p_codigo_error := 3;
        p_mensaje := 'Error: Cuenta destino ' || p_nrcuenta_destino || ' no existe';
        RETURN;
    END IF;
    
    IF p_nrcuenta_origen = p_nrcuenta_destino THEN 
        p_codigo_error := 4;
        p_mensaje := 'Error: Las cuentas deben ser diferentes';
        RETURN;
    END IF;
    
    SELECT Saldo INTO v_saldo_origen FROM CUENTAS -- Valido si el saldo suficiente
    WHERE NrCuenta = p_nrcuenta_origen;
    
    IF v_saldo_origen < p_monto THEN
        p_codigo_error := 5;
        p_mensaje := 'Error: Saldo insuficiente. Disponible: ' || v_saldo_origen;
        RETURN;
    END IF;
    
    SELECT COALESCE(MAX(NrMov), 0) + 1 INTO v_nrmov_sal FROM MOVIMIENTOS; -- Generar números de movimiento
    v_nrmov_ent := v_nrmov_sal + 1;
    
    SELECT TipoCuenta INTO v_tipocuenta_origen FROM CUENTAS 
    WHERE NrCuenta = p_nrcuenta_origen;
    
    SELECT TipoCuenta INTO v_tipocuenta_destino FROM CUENTAS 
    WHERE NrCuenta = p_nrcuenta_destino;
    
    INSERT INTO MOVIMIENTOS (NrMov, Monto, Fecha, NrCuenta, CodOp, TipoCuenta)
    VALUES (v_nrmov_sal, p_monto, p_fecha, p_nrcuenta_origen, 5, v_tipocuenta_origen);
    
    INSERT INTO MOVIMIENTOS (NrMov, Monto, Fecha, NrCuenta, CodOp, TipoCuenta)
    VALUES (v_nrmov_ent, p_monto, p_fecha, p_nrcuenta_destino, 6, v_tipocuenta_destino);
    
    p_codigo_error := 0;
    p_mensaje := 'Transferencia de ' || p_monto || ' completada. Movimientos: ' || v_nrmov_sal || ', ' || v_nrmov_ent;
    
EXCEPTION WHEN OTHERS THEN
    p_codigo_error := 99;
    p_mensaje := 'Error: ' || SQLERRM;
END; $$;

-- ===================================================================================
-- F.2 - nuevos SP
-- ===================================================================================
-- SP debido
CREATE OR REPLACE PROCEDURE sp_debito(
    p_nrcuenta INT,
    p_monto MONEY,
    p_fecha DATE,
    OUT p_codigo_error INT,
    OUT p_mensaje VARCHAR(255)
)
LANGUAGE plpgsql AS $$
DECLARE
    v_saldo MONEY;
    v_tipocuenta INT;
    v_nrmov INT;
BEGIN
    p_codigo_error := 0;
    p_mensaje := '';
    
    IF NOT EXISTS (SELECT 1 FROM CUENTAS WHERE NrCuenta = p_nrcuenta) THEN -- Valido cuenta existe
        p_codigo_error := 1;
        p_mensaje := 'Error: Cuenta no existe';
        RETURN;
    END IF;
    
    SELECT Saldo INTO v_saldo FROM CUENTAS WHERE NrCuenta = p_nrcuenta; -- Valido saldo suficiente
    IF v_saldo < p_monto THEN
        p_codigo_error := 2;
        p_mensaje := 'Error: Saldo insuficiente';
        RETURN;
    END IF;
    
    SELECT COALESCE(MAX(NrMov), 0) + 1 INTO v_nrmov FROM MOVIMIENTOS;
    SELECT TipoCuenta INTO v_tipocuenta FROM CUENTAS WHERE NrCuenta = p_nrcuenta;
    
    INSERT INTO MOVIMIENTOS (NrMov, Monto, Fecha, NrCuenta, CodOp, TipoCuenta)
    VALUES (v_nrmov, p_monto, p_fecha, p_nrcuenta, 5, v_tipocuenta);
    
    p_codigo_error := 0;
    p_mensaje := 'Débito registrado';
    
EXCEPTION WHEN OTHERS THEN
    p_codigo_error := 99;
    p_mensaje := 'Error en débito: ' || SQLERRM;
END; $$;

-- SP credito
CREATE OR REPLACE PROCEDURE sp_credito(
    p_nrcuenta INT,
    p_monto MONEY,
    p_fecha DATE,
    OUT p_codigo_error INT,
    OUT p_mensaje VARCHAR(255)
)
LANGUAGE plpgsql AS $$
DECLARE
    v_tipocuenta INT;
    v_nrmov INT;
BEGIN
    p_codigo_error := 0;
    p_mensaje := '';
    
    IF NOT EXISTS (SELECT 1 FROM CUENTAS WHERE NrCuenta = p_nrcuenta) THEN -- Valido  cuenta existe
        p_codigo_error := 1;
        p_mensaje := 'Error: Cuenta no existe';
        RETURN;
    END IF;
    
    SELECT COALESCE(MAX(NrMov), 0) + 1 INTO v_nrmov FROM MOVIMIENTOS;
    SELECT TipoCuenta INTO v_tipocuenta FROM CUENTAS WHERE NrCuenta = p_nrcuenta;
    
    INSERT INTO MOVIMIENTOS (NrMov, Monto, Fecha, NrCuenta, CodOp, TipoCuenta)
    VALUES (v_nrmov, p_monto, p_fecha, p_nrcuenta, 6, v_tipocuenta);
    
    p_codigo_error := 0;
    p_mensaje := 'Crédito registrado';
    
EXCEPTION WHEN OTHERS THEN
    p_codigo_error := 99;
    p_mensaje := 'Error en crédito: ' || SQLERRM;
END; $$;

-- SP transferenciaTransaccional
CREATE OR REPLACE PROCEDURE sp_transferencia_transaccional(
    p_nrcuenta_origen INT,
    p_nrcuenta_destino INT,
    p_monto MONEY,
    p_fecha DATE,
    OUT p_codigo_error INT,
    OUT p_mensaje VARCHAR(255)
)
LANGUAGE plpgsql AS $$
DECLARE
    v_error_deb INT;
    v_msg_deb VARCHAR(255);
    v_error_cred INT;
    v_msg_cred VARCHAR(255);
    v_saldo MONEY;
BEGIN
    p_codigo_error := 0;
    p_mensaje := '';
    
    IF p_monto <= 0 THEN -- Valido si monto > 0
        p_codigo_error := 1;
        p_mensaje := 'Error: Monto debe ser mayor a 0';
        RETURN;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM CUENTAS WHERE NrCuenta = p_nrcuenta_origen) THEN -- valido cuentas existen
        p_codigo_error := 2;
        p_mensaje := 'Error: Cuenta origen no existe';
        RETURN;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM CUENTAS WHERE NrCuenta = p_nrcuenta_destino) THEN
        p_codigo_error := 3;
        p_mensaje := 'Error: Cuenta destino no existe';
        RETURN;
    END IF;
    
    IF p_nrcuenta_origen = p_nrcuenta_destino THEN -- Valido cuentas diferentes
        p_codigo_error := 4;
        p_mensaje := 'Error: Las cuentas deben ser diferentes';
        RETURN;
    END IF;
    
    SELECT Saldo INTO v_saldo FROM CUENTAS WHERE NrCuenta = p_nrcuenta_origen; -- Valido si saldo suficiente
    IF v_saldo < p_monto THEN
        p_codigo_error := 5;
        p_mensaje := 'Error: Saldo insuficiente';
        RETURN;
    END IF;
    
    BEGIN
        CALL sp_debito(p_nrcuenta_origen, p_monto, p_fecha, v_error_deb, v_msg_deb);
        IF v_error_deb != 0 THEN
            RAISE EXCEPTION 'Error en débito: %', v_msg_deb;
        END IF;
        
        CALL sp_credito(p_nrcuenta_destino, p_monto, p_fecha, v_error_cred, v_msg_cred);
        IF v_error_cred != 0 THEN
            RAISE EXCEPTION 'Error en crédito: %', v_msg_cred;
        END IF;
        
        p_codigo_error := 0;
        p_mensaje := 'Transferencia completada: ' || p_monto;
        
    EXCEPTION WHEN OTHERS THEN
        p_codigo_error := 99;
        p_mensaje := 'Error en transferencia: ' || SQLERRM;
    END;
    
END; $$;

-- ===================================================================================
-- F.3 - CASE, WHEN
-- ===================================================================================
-- ===================================================================================
-- F.3.a -- función para obtener tipo de cuenta
-- ===================================================================================
CREATE OR REPLACE FUNCTION fn_obtener_tipo_cuenta(p_nrcuenta INT)
RETURNS VARCHAR(50)
LANGUAGE plpgsql AS $$
DECLARE
    v_tipo INT;
    v_resultado VARCHAR(50);
BEGIN
    SELECT TipoCuenta INTO v_tipo FROM CUENTAS WHERE NrCuenta = p_nrcuenta;
    
    SELECT CASE v_tipo
        WHEN 1 THEN 'Caja de Ahorro'
        WHEN 2 THEN 'Cuenta Corriente'
        WHEN 3 THEN 'Cuenta en Dólares'
        WHEN 4 THEN 'Plazo Fijo'
        ELSE 'Tipo desconocido'
    END INTO v_resultado;
    
    RETURN v_resultado;
END; $$;

-- ===================================================================================
-- F.3.b -- función para clasificar cuentas por saldo
-- ===================================================================================
CREATE OR REPLACE FUNCTION fn_clasificar_cuentas_por_saldo(p_nrcuenta INT)
RETURNS VARCHAR(50)
LANGUAGE plpgsql AS $$
DECLARE
    v_saldo MONEY;
    v_clasificacion VARCHAR(50);
BEGIN
    SELECT Saldo INTO v_saldo FROM CUENTAS WHERE NrCuenta = p_nrcuenta;
    
    SELECT CASE
        WHEN v_saldo < 10000 THEN 'Saldo bajo'
        WHEN v_saldo BETWEEN 10000 AND 50000 THEN 'Saldo medio'
        WHEN v_saldo > 50000 THEN 'Saldo alto'
        ELSE 'No clasificado'
    END INTO v_clasificacion;
    
    RETURN v_clasificacion;
END; $$;

-- ===============================================================
-- H - Transacciones
-- ===============================================================

-- ===============================================================
-- H.1 - SP_Debito (Modelo transaccional)
-- ===============================================================

-- SP para realizar un débito en una cuenta, registrando el movimiento y actualizando el saldo de la cuenta.
CREATE OR REPLACE PROCEDURE sp_debito(
    p_nrmov INT,
    p_nrcuenta INT,
    p_codop INT,
    p_monto MONEY,
    p_fecha DATE DEFAULT CURRENT_DATE
)
LANGUAGE plpgsql AS $$
DECLARE
    v_saldo_actual MONEY;
    v_tipocuenta INT;
    v_codtipoop INT;
BEGIN
    IF p_monto <= '0'::MONEY THEN
        ROLLBACK;
        RAISE EXCEPTION 'Error: El monto a debitar debe ser mayor a cero.';
    END IF;

    -- FOR UPDATE bloquea la fila de la cuenta temporalmente para evitar 
    -- que otra transacción modifique el saldo mientras hacemos esta validación.
    SELECT Saldo, TipoCuenta INTO v_saldo_actual, v_tipocuenta
    FROM CUENTAS WHERE NrCuenta = p_nrcuenta FOR UPDATE;

    IF NOT FOUND THEN
        ROLLBACK;
        RAISE EXCEPTION 'Error: No existe la cuenta con número %.', p_nrcuenta;
    END IF;

    SELECT CodTipoOp INTO v_codtipoop
    FROM OPERACIONES WHERE CodOp = p_codop;

    IF NOT FOUND THEN
        ROLLBACK;
        RAISE EXCEPTION 'Error: No existe la operación con código %.', p_codop;
    END IF;

    IF v_codtipoop != 1 THEN -- 1 = Debe
        ROLLBACK;
        RAISE EXCEPTION 'Error: La operación % no es válida. Debe ser de tipo Débito (Debe).', p_codop;
    END IF;

    IF v_saldo_actual < p_monto THEN
        ROLLBACK;
        RAISE EXCEPTION 'Error: Saldo insuficiente. Saldo actual: %.', v_saldo_actual;
    END IF;

    INSERT INTO MOVIMIENTOS (NrMov, Monto, Fecha, NrCuenta, CodOp, TipoCuenta)
    VALUES (p_nrmov, p_monto, p_fecha, p_nrcuenta, p_codop, v_tipocuenta);

    UPDATE CUENTAS 
    SET Saldo = Saldo - p_monto 
    WHERE NrCuenta = p_nrcuenta;

    COMMIT;
    RAISE NOTICE 'Transacción Exitosa: Débito % registrado en la cuenta %.', p_nrmov, p_nrcuenta;

END; $$;

-- ===============================================================
-- H.1 - SP_Credito (Modelo transaccional)
-- ===============================================================

-- SP para realizar un crédito en una cuenta, registrando el movimiento y actualizando el saldo de la cuenta.

CREATE OR REPLACE PROCEDURE sp_credito(
    p_nrmov INT,
    p_nrcuenta INT,
    p_codop INT,
    p_monto MONEY,
    p_fecha DATE DEFAULT CURRENT_DATE
)
LANGUAGE plpgsql AS $$
DECLARE
    v_saldo_actual MONEY;
    v_tipocuenta INT;
    v_codtipoop INT;
BEGIN
    IF p_monto <= '0'::MONEY THEN
        ROLLBACK;
        RAISE EXCEPTION 'Error: El monto a acreditar debe ser mayor a cero.';
    END IF;

    -- Bloqueo preventivo de la fila
    SELECT Saldo, TipoCuenta INTO v_saldo_actual, v_tipocuenta
    FROM CUENTAS WHERE NrCuenta = p_nrcuenta FOR UPDATE;

    IF NOT FOUND THEN
        ROLLBACK;
        RAISE EXCEPTION 'Error: No existe la cuenta con número %.', p_nrcuenta;
    END IF;

    SELECT CodTipoOp INTO v_codtipoop
    FROM OPERACIONES WHERE CodOp = p_codop;

    IF NOT FOUND THEN
        ROLLBACK;
        RAISE EXCEPTION 'Error: No existe la operación con código %.', p_codop;
    END IF;

    IF v_codtipoop != 2 THEN -- 2 = Haber
        ROLLBACK;
        RAISE EXCEPTION 'Error: La operación % no es válida. Debe ser de tipo Crédito (Haber).', p_codop;
    END IF;

    INSERT INTO MOVIMIENTOS (NrMov, Monto, Fecha, NrCuenta, CodOp, TipoCuenta)
    VALUES (p_nrmov, p_monto, p_fecha, p_nrcuenta, p_codop, v_tipocuenta);

    UPDATE CUENTAS 
    SET Saldo = Saldo + p_monto 
    WHERE NrCuenta = p_nrcuenta;

    COMMIT;
    RAISE NOTICE 'Transacción Exitosa: Crédito % registrado en la cuenta %.', p_nrmov, p_nrcuenta;

END; $$;

-- ===============================================================
-- H.2 - SP_Transferencia (Modelo transaccional)
-- ===============================================================

-- SP para realizar una transferencia entre dos cuentas, registrando el débito en la cuenta de origen y el crédito en la cuenta de destino.

CREATE OR REPLACE PROCEDURE sp_transferencia(
    p_nrmov_sal INT,          -- ID movimiento para el débito (origen)
    p_nrmov_ent INT,          -- ID movimiento para el crédito (destino)
    p_cuenta_origen INT,
    p_cuenta_destino INT,
    p_monto MONEY,
    p_codop_deb INT,
    p_codop_cre INT,          
    p_fecha DATE DEFAULT CURRENT_DATE
)
LANGUAGE plpgsql AS $$
BEGIN
    IF p_cuenta_origen = p_cuenta_destino THEN
        ROLLBACK; 
        RAISE EXCEPTION 'Error Transaccional: La cuenta de origen y destino no pueden ser la misma.';
    END IF;

    IF p_monto <= '0'::MONEY THEN
        ROLLBACK;
        RAISE EXCEPTION 'Error Transaccional: El monto de la transferencia debe ser mayor a cero.';
    END IF;

    RAISE NOTICE 'Iniciando Paso A: Registrando débito en cuenta origen %...', p_cuenta_origen;
    CALL sp_debito(p_nrmov_sal, p_cuenta_origen, p_codop_deb, p_monto, p_fecha);

    RAISE NOTICE 'Iniciando Paso B: Registrando crédito en cuenta destino %...', p_cuenta_destino;
    CALL sp_credito(p_nrmov_ent, p_cuenta_destino, p_codop_cre, p_monto, p_fecha);

    COMMIT;
    RAISE NOTICE 'Transacción Consolidada: Transferencia exitosa de % desde cuenta % a cuenta %.', 
                 p_monto, p_cuenta_origen, p_cuenta_destino;

END; $$;

-- ===============================================================
-- I - Cursores
-- ===============================================================

-- ===============================================================
-- I.1 - Procedimiento transaccional de actualización
-- ===============================================================

-- SP para actualizar los sueldos de empleados por categoría, con control de errores y transaccionalidad.
CREATE OR REPLACE PROCEDURE sp_actualizar_sueldos_por_categoria(
    p_categ_1 VARCHAR, p_porc_1 NUMERIC,   
    p_categ_2 VARCHAR, p_porc_2 NUMERIC,   
    p_categ_3 VARCHAR, p_porc_3 NUMERIC    
)
LANGUAGE plpgsql AS $$
DECLARE
    v_existe_1 INT;
    v_existe_2 INT;
    v_existe_3 INT;
BEGIN
    IF p_porc_1 < -100 OR p_porc_2 < -100 OR p_porc_3 < -100 THEN
        ROLLBACK;
        RAISE EXCEPTION 'Error Transaccional: Los porcentajes de ajuste no pueden determinar una quita mayor al -100%%.';
    END IF;

    SELECT COUNT(*) INTO v_existe_1 FROM CATEGORIAS WHERE Categ ILIKE '%' || TRIM(p_categ_1) || '%';
    IF v_existe_1 = 0 THEN
        ROLLBACK;
        RAISE EXCEPTION 'Error Transaccional: No se encontró ninguna categoría que coincida con "%".', p_categ_1;
    END IF;

    SELECT COUNT(*) INTO v_existe_2 FROM CATEGORIAS WHERE Categ ILIKE '%' || TRIM(p_categ_2) || '%';
    IF v_existe_2 = 0 THEN
        ROLLBACK;
        RAISE EXCEPTION 'Error Transaccional: No se encontró ninguna categoría que coincida con "%".', p_categ_2;
    END IF;

    SELECT COUNT(*) INTO v_existe_3 FROM CATEGORIAS WHERE Categ ILIKE '%' || TRIM(p_categ_3) || '%';
    IF v_existe_3 = 0 THEN
        ROLLBACK;
        RAISE EXCEPTION 'Error Transaccional: No se encontró ninguna categoría que coincida con "%".', p_categ_3;
    END IF;

    UPDATE CATEGORIAS 
    SET Sueldo = Sueldo * (1 + (p_porc_1 / 100.0))
    WHERE Categ ILIKE '%' || TRIM(p_categ_1) || '%';

    UPDATE CATEGORIAS 
    SET Sueldo = Sueldo * (1 + (p_porc_2 / 100.0))
    WHERE Categ ILIKE '%' || TRIM(p_categ_2) || '%';

    UPDATE CATEGORIAS 
    SET Sueldo = Sueldo * (1 + (p_porc_3 / 100.0))
    WHERE Categ ILIKE '%' || TRIM(p_categ_3) || '%';

    COMMIT;
    RAISE NOTICE 'Transacción Exitosa: Los sueldos de las categorías han sido actualizados de forma masiva.';

END; $$;

-- ===============================================================
-- I.2 - Procedimiento transaccional de premiación
-- ===============================================================

-- SP para otorgar un premio de interés a todas las cuentas de Plazo Fijo con saldo mayor a un mínimo especificado, con control de errores y transaccionalidad.
CREATE OR REPLACE PROCEDURE sp_otorgar_premio_plazo_fijo(
    p_porcentaje NUMERIC DEFAULT 5.0,                  
    p_tipo_busqueda VARCHAR DEFAULT 'Plazo Fijo',      
    p_saldo_minimo MONEY DEFAULT '50000.00'::MONEY    
)
LANGUAGE plpgsql AS $$
DECLARE
    v_id_tipo_cuenta INT;
    v_cuentas_afectadas INT;
BEGIN
    IF p_porcentaje <= 0 THEN
        ROLLBACK;
        RAISE EXCEPTION 'Error Transaccional: El porcentaje de interés invertido debe ser mayor a cero.';
    END IF;

    SELECT TipoCuenta INTO v_id_tipo_cuenta 
    FROM TIPOSCUENTAS 
    WHERE Descripcion ILIKE '%' || TRIM(p_tipo_busqueda) || '%' 
       OR Descripcion ILIKE '%PF%';

    IF NOT FOUND THEN
        ROLLBACK;
        RAISE EXCEPTION 'Error Transaccional: No se encontró el tipo de cuenta "%" en el sistema.', p_tipo_busqueda;
    END IF;

    SELECT COUNT(*) INTO v_cuentas_afectadas 
    FROM CUENTAS 
    WHERE TipoCuenta = v_id_tipo_cuenta AND Saldo > p_saldo_minimo;

    IF v_cuentas_afectadas = 0 THEN
        ROLLBACK;
        RAISE EXCEPTION 'Error Transaccional: No se encontraron cuentas de tipo "%" con un saldo mayor a % a la fecha de hoy.', 
                        p_tipo_busqueda, p_saldo_minimo;
    END IF;

    UPDATE CUENTAS
    SET Saldo = Saldo * (1 + (p_porcentaje / 100.0))
    WHERE TipoCuenta = v_id_tipo_cuenta AND Saldo > p_saldo_minimo;

    COMMIT;
    RAISE NOTICE 'Transacción Exitosa: Se otorgó el premio del %%% de interés a % cuentas de Plazo Fijo.', 
                 p_porcentaje, v_cuentas_afectadas;

END; $$;

\c unidad2


-- El cliente usuario01 -> id 1 ha realizado la siguiente compra:
-- ●producto: producto9. -> id 9
-- ●cantidad: 5.
-- ●fecha: fecha del sistema.

SELECT * FROM producto WHERE id = 9;

BEGIN TRANSACTION;
    
    INSERT INTO compra(id,cliente_id,fecha) VALUES (34,(SELECT id FROM cliente WHERE nombre='usuario01'),Current_timestamp);
    INSERT INTO detalle_compra(id,producto_id,compra_id,cantidad) VALUES (44,9,34,5);
    UPDATE producto SET stock = stock - 5 WHERE id = 9;

COMMIT;

SELECT * FROM producto WHERE id = 9;

--El cliente usuario02 ha realizado la siguiente compra:
-- producto: producto1, producto 2, producto 8.
-- cantidad: 3 de cada producto.
-- fecha: fecha del sistema.
\echo "Respuesta 3"

BEGIN TRANSACTION;
    
    INSERT INTO compra(id,cliente_id,fecha) VALUES (35,(SELECT id FROM cliente WHERE nombre='usuario02'),Current_timestamp);
    INSERT INTO detalle_compra(id,producto_id,compra_id,cantidad) VALUES (45,1,35,3);
    UPDATE producto SET stock = stock - 3 WHERE id = 1;
COMMIT;
BEGIN TRANSACTION;
    INSERT INTO compra(id,cliente_id,fecha) VALUES (36,(SELECT id FROM cliente WHERE nombre='usuario02'),Current_timestamp);
    INSERT INTO detalle_compra(id,producto_id,compra_id,cantidad) VALUES (46,2,36,3);
    UPDATE producto SET stock = stock - 3 WHERE id = 2;
COMMIT;
BEGIN TRANSACTION;
    INSERT INTO compra(id,cliente_id,fecha) VALUES (37,(SELECT id FROM cliente WHERE nombre='usuario02'),Current_timestamp);
    INSERT INTO detalle_compra(id,producto_id,compra_id,cantidad) VALUES (47,8,37,3);
    UPDATE producto SET stock = stock - 3 WHERE id = 8;
COMMIT;
   SAVEPOINT TO nueva_compra;
   ROLLBACK TO nueva_compra;
SELECT * FROM producto WHERE descripcion = 'producto1' OR descripcion = 'producto2' OR descripcion = 'producto8';

--a. Deshabilitar el AUTOCOMMIT .
\set AUTOCOMMIT off
--b. Insertar un nuevo cliente.
BEGIN TRANSACTION;
INSERT INTO cliente(id,nombre,email) VALUES (11,'usuario11','usuario11@hotamil.com');
--c. Confirmar que fue agregado en la tabla cliente. (acá se aprecia que está)
SELECT * FROM cliente;
--d. Realizar un ROLLBACK (al hacer ROLLBACK vuelve al estado original).
ROLLBACK;
--e. Confirmar que se restauró la información, sin considerar la inserción del punto b.
--Acá ya no se visualiza el ingreso del punto b
SELECT * FROM cliente;
--f. Habilitar de nuevo el AUTOCOMMIT.
\echo :AUTOCOMMIT
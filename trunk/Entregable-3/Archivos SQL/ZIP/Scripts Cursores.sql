--Cursor productos por precio Mayor a Menor

DECLARE
        CURSOR cur_productos IS
        SELECT nombre, precio, tipoproducto, disponibilidad FROM productos
        ORDER BY precio DESC;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Productos ordenados por precio.');
            FOR fila IN cur_productos LOOP
                DBMS_OUTPUT.PUT_LINE(fila.nombre|| ' ' ||fila.precio|| '€ ' ||fila.tipoproducto|| ' ' ||fila.disponibilidad);
            END LOOP;
        END;
		
--Cursor productos por precio Menor a Mayor


DECLARE
        CURSOR cur_productos IS
        SELECT nombre, precio, tipoproducto, disponibilidad FROM productos
        ORDER BY precio ASC;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Productos ordenados por precio.');
            FOR fila IN cur_productos LOOP
                DBMS_OUTPUT.PUT_LINE(fila.nombre|| ' ' ||fila.precio|| '€ ' ||fila.tipoproducto|| ' ' ||fila.disponibilidad);
            END LOOP;
        END;
		
--Cursor productos por tipo producto

DECLARE
        CURSOR cur_productos IS
        SELECT nombre, precio, tipoproducto, disponibilidad FROM productos
        ORDER BY precio ASC;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Productos ordenados por tipo de producto.');
            FOR fila IN cur_productos LOOP
                DBMS_OUTPUT.PUT_LINE(fila.nombre|| ' ' ||fila.precio|| '€ ' ||fila.tipoproducto|| ' ' ||fila.disponibilidad);
            END LOOP;
        END;
		
		
--Cursor productos por disponibilidad

DECLARE
        CURSOR cur_productos IS
        SELECT nombre, precio, tipoproducto, disponibilidad FROM productos
        ORDER BY disponibilidad;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Productos ordenados por disponibilidad.');
            FOR fila IN cur_productos LOOP
                DBMS_OUTPUT.PUT_LINE(fila.nombre|| ' ' ||fila.precio|| '€ ' ||fila.tipoproducto|| ' ' ||fila.disponibilidad);
            END LOOP;
        END;
		
--Cursor Albaranes por id pedido

DECLARE
        CURSOR cur_albaran IS
        SELECT idalbaran, idpedido2, idfactura1 FROM albaranes
        ORDER BY idpedido2;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Albaranes ordenados por id pedido.');
            FOR fila IN cur_albaran LOOP
                DBMS_OUTPUT.PUT_LINE(fila.idalbaran|| ' ' ||fila.idpedido2|| ' ' ||fila.idfactura1);
            END LOOP;
        END;
		
--Cursor Albaranes por id factura

DECLARE
        CURSOR cur_albaran IS
        SELECT idalbaran, idpedido2, idfactura1 FROM albaranes
        ORDER BY idfactura1;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Albaranes ordenados por id factura.');
            FOR fila IN cur_albaran LOOP
                DBMS_OUTPUT.PUT_LINE(fila.idalbaran|| ' ' ||fila.idpedido2|| ' ' ||fila.idfactura1);
            END LOOP;
        END;
		
--Cursor Almacenes por nombre

DECLARE
        CURSOR cur_almacen IS
        SELECT idalmacen, nombre, ID_DIRECCION3 FROM almacenes
        ORDER BY nombre;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Almacenes ordenados por nombre.');
            FOR fila IN cur_almacen LOOP
                DBMS_OUTPUT.PUT_LINE(fila.idalmacen|| ' ' ||fila.nombre|| ' ' ||fila.ID_DIRECCION3);
            END LOOP;
        END;
		
--Cursor Clientes por DNI

DECLARE
        CURSOR cur_cliente IS
        SELECT idcliente, nombre_cli, dni FROM clientes
        ORDER BY dni;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Clientes ordenados por dni.');
            FOR fila IN cur_cliente LOOP
                DBMS_OUTPUT.PUT_LINE(fila.idcliente|| ' ' ||fila.nombre_cli|| ' ' ||fila.dni);
            END LOOP;
        END;
		
--Cursor Clientes por Nombre

DECLARE
        CURSOR cur_cliente IS
        SELECT idcliente, nombre_cli, dni FROM clientes
        ORDER BY nombre_cli;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Clientes ordenados por nombre.');
            FOR fila IN cur_cliente LOOP
                DBMS_OUTPUT.PUT_LINE(fila.idcliente|| ' ' ||fila.nombre_cli|| ' ' ||fila.dni);
            END LOOP;
        END;
		
--Cursor Direcciones por Ciudad

DECLARE
        CURSOR cur_direccion IS
        SELECT id_direccion, ciudad, calle FROM direcciones
        ORDER BY ciudad;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Direcciones ordenados por ciudad.');
            FOR fila IN cur_direccion LOOP
                DBMS_OUTPUT.PUT_LINE(fila.id_direccion|| ' ' ||fila.ciudad|| ' ' ||fila.calle);
            END LOOP;
        END;
		
--Cursor Pedidos por fecha DESC
DECLARE
        CURSOR cur_pedido IS
        SELECT idpedido, fecha, idcliente1, preciototal FROM pedidos
        ORDER BY fecha DESC;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Pedidos ordenados por fecha.');
            FOR fila IN cur_pedido LOOP
                DBMS_OUTPUT.PUT_LINE(fila.idpedido|| ' ' ||fila.fecha|| ' ' ||fila.preciototal|| '€ ' ||fila.idcliente1);
            END LOOP;
        END;
--Cursor Pedidos por fecha ASC
DECLARE
        CURSOR cur_pedido IS
        SELECT idpedido, fecha, idcliente1, preciototal FROM pedidos
        ORDER BY fecha ASC;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Pedidos ordenados por fecha.');
            FOR fila IN cur_pedido LOOP
                DBMS_OUTPUT.PUT_LINE(fila.idpedido|| ' ' ||fila.fecha|| ' ' ||fila.preciototal|| '€ ' ||fila.idcliente1);
            END LOOP;
        END;
--Cursor Pedidos por id_Cliente
DECLARE
        CURSOR cur_pedido IS
        SELECT idpedido, fecha, idcliente1, preciototal FROM pedidos
        ORDER BY idcliente1;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Pedidos ordenados por fecha.');
            FOR fila IN cur_pedido LOOP
                DBMS_OUTPUT.PUT_LINE(fila.idpedido|| ' ' ||fila.fecha|| ' ' ||fila.preciototal|| '€ ' ||fila.idcliente1);
            END LOOP;
        END;
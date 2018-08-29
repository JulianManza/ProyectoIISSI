--------------------------------------------------------
-- Procedimientos de eliminacion o borrado 
--------------------------------------------------------

--------------------------------------------------------
--  DDL for Procedure BORRAR_ALBARAN
--------------------------------------------------------

create or replace PROCEDURE BORRAR_ALBARAN (
    idborrar IN ALBARANES.IDALBARAN%TYPE
    )
IS idalbaran ALBARANES.IDALBARAN%TYPE;

BEGIN
    DELETE FROM albaranes WHERE IDALBARAN = idborrar;
END BORRAR_ALBARAN;
/
--------------------------------------------------------
--  DDL for Procedure BORRAR_ALMACEN
--------------------------------------------------------

create or replace PROCEDURE BORRAR_ALMACEN (
    id_almacendel IN ALMACENES.IDALMACEN%TYPE
    )
IS idalmacen ALMACENES.IDALMACEN%TYPE;

BEGIN
    DELETE FROM almacenes WHERE IDALMACEN = id_almacendel;
END BORRAR_ALMACEN;
/
--------------------------------------------------------
--  DDL for Procedure BORRAR_FACTURA
--------------------------------------------------------
create or replace PROCEDURE BORRAR_FACTURA (
    idborrar IN FACTURAS.IDFACTURA%TYPE
    )
IS factura FACTURAS.IDFACTURA%TYPE;

BEGIN
    DELETE FROM FACTURAS WHERE IDFACTURA = idborrar;
END BORRAR_FACTURA;
/
--------------------------------------------------------
--  DDL for Procedure BORRAR_ESTADOPEDIDO
--------------------------------------------------------
create or replace PROCEDURE BORRAR_ESTADOPEDIDO (
    idborrar IN ESTADOPEDIDOS.IDPEDIDO1%TYPE
    )
IS 
BEGIN
    DELETE FROM ESTADOPEDIDOS WHERE IDPEDIDO1 = idborrar;
END BORRAR_ESTADOPEDIDO;
/
--------------------------------------------------------
--  DDL for Procedure ELIMINA_DIRECCION
--------------------------------------------------------
create or replace PROCEDURE ELIMINA_DIRECCION(
        id_direccionborrar IN DIRECCIONES.ID_DIRECCION%TYPE
)
IS id_direccion direcciones.ID_DIRECCION%TYPE;

BEGIN
    DELETE FROM direcciones WHERE id_direccion = id_direccionborrar;
END ELIMINA_DIRECCION;
/
--------------------------------------------------------
--  DDL for Procedure ELIMINA_PRODUCTO
--------------------------------------------------------
create or replace PROCEDURE ELIMINA_PRODUCTO (
    codigoborrar IN productos.CODIGO%TYPE
)
IS codigo productos.CODIGO%TYPE;

BEGIN
    DELETE FROM productos WHERE codigo = codigoborrar;
END ELIMINA_PRODUCTO;
/
--------------------------------------------------------
--  DDL for Procedure ELIMINAR_PEDIDO
--------------------------------------------------------
create or replace PROCEDURE ELIMINA_PEDIDO (
    codigoborrar IN PEDIDOS.IDPEDIDO%TYPE
)
IS codigo PEDIDOS.IDPEDIDO%TYPE;

BEGIN
    DELETE FROM PEDIDOS WHERE IDPEDIDO = codigoborrar;
    BORRAR_ESTADOPEDIDO(codigoborrar);
    DELETE FROM LINEAPEDIDOS WHERE IDPEDIDO3 = codigoborrar;
END ELIMINA_PEDIDO;
/
--------------------------------------------------------
--  DDL for Procedure ELIMINAR_LINEAPEDIDO
--------------------------------------------------------
create or replace PROCEDURE ELIMINA_LINEAPEDIDO (
        num IN LINEAPEDIDOS.NUMLINE%TYPE
    )
IS NUMLINE LINEAPEDIDOS.NUMLINE%TYPE;
    BEGIN
    DELETE FROM LINEAPEDIDOS WHERE NUMLINE = num;
END ELIMINA_LINEAPEDIDO;
/
--------------------------------------------------------
--  DDL for Procedure ELIMINAR_OFERTA
--------------------------------------------------------
create or replace PROCEDURE ELIMINA_OFERTA (
        id_ofertaborrar IN OFERTAS.CODIGO%TYPE
)
IS id_oferta direcciones.ID_DIRECCION%TYPE;
    restaurarprecio PRODUCTOS.PRECIO%TYPE;
    idproducto OFERTAS.CODIGO_PROD2%TYPE;
BEGIN
    SELECT OFERTAS.PRECIOANTES INTO restaurarprecio FROM OFERTAS 
    WHERE CODIGO = id_ofertaborrar;
    SELECT OFERTAS.CODIGO_PROD2 INTO idproducto FROM OFERTAS
    WHERE CODIGO = id_ofertaborrar;
    UPDATE PRODUCTOS
    SET PRECIO = restaurarprecio
    WHERE PRODUCTOS.CODIGO = idproducto;
    DELETE FROM OFERTAS WHERE id_oferta = id_ofertaborrar;
END ELIMINA_OFERTA;
/
--------------------------------------------------------
--  DDL for Procedure ELIMINAR_CLIENTE
--------------------------------------------------------
create or replace PROCEDURE ELIMINAR_CLIENTE (
    id_clienteDEL IN CLIENTES.IDCLIENTE%TYPE
    )
IS id_cliente CLIENTES.IDCLIENTE%TYPE;

BEGIN
        DELETE FROM clientes WHERE IDCLIENTE = id_clienteDEL;
END ELIMINAR_CLIENTE;
/
--------------------------------------------------------

--------------------------------------------------------
-- Procedimientos de Creacion 
--------------------------------------------------------

--------------------------------------------------------
--  DDL for Procedure CREAR_ESTADOPEDIDO
--------------------------------------------------------
create or replace PROCEDURE CREAR_ESTADOPEDIDO (
        estado IN ESTADOPEDIDOS.ESTADOPEDIDO%TYPE,
        pedido IN ESTADOPEDIDOS.IDPEDIDO1%TYPE
    )
IS codigo ESTADOPEDIDOS.ESTADOPEDIDO%TYPE;
   BEGIN
        INSERT INTO ESTADOPEDIDOS (ESTADOPEDIDO, IDPEDIDO1) 
        VALUES(estado, pedido);
END CREAR_ESTADOPEDIDO;
/
--------------------------------------------------------
--  DDL for Procedure CREAR_ALBARAN
--------------------------------------------------------
create or replace PROCEDURE CREAR_ALBARAN (
        id_pedido IN ALBARANES.IDPEDIDO2%TYPE
    )
IS id_albaran ALBARANES.IDALBARAN%TYPE;
    BEGIN
        SELECT sec_albaran.NEXTVAL INTO id_albaran FROM dual;
        INSERT INTO albaranes (IDALBARAN, IDPEDIDO2) 
        VALUES(id_albaran, id_pedido);
END CREAR_ALBARAN;
/
--------------------------------------------------------
--  DDL for Procedure CREAR_ALMACEN
--------------------------------------------------------
create or replace PROCEDURE CREAR_ALMACEN (
    nombreal IN ALMACENES.NOMBRE%TYPE,
    id_direccional IN ALMACENES.ID_DIRECCION3%TYPE
    )
IS idalmacen ALMACENES.IDALMACEN%TYPE;

BEGIN
        SELECT sec_almacen.NEXTVAL INTO idalmacen FROM dual;
        INSERT INTO almacenes (IDALMACEN, NOMBRE, ID_DIRECCION3) 
        VALUES(idalmacen, nombreal, id_direccional);
END CREAR_ALMACEN;
/
--------------------------------------------------------
--  DDL for Procedure CREAR_FACTURA
--------------------------------------------------------
create or replace PROCEDURE CREAR_FACTURA (
        albaran IN FACTURAS.IDALBARAN1%TYPE,
        pago IN FACTURAS.TIPOFORMAPAGO%TYPE
    )
IS factura FACTURAS.IDFACTURA%TYPE;
    precio PEDIDOS.PRECIOTOTAL%TYPE;
    BEGIN
        SELECT SEC_FACTURA.NEXTVAL INTO factura FROM dual;
        SELECT PEDIDOS.PRECIOTOTAL INTO precio FROM ALBARANES,PEDIDOS where ALBARANES.IDPEDIDO2 = PEDIDOS.IDPEDIDO;
        INSERT INTO FACTURAS (IDFACTURA, TIPOFORMAPAGO,PRECIOTOTAL,IDALBARAN1) 
        VALUES(factura, pago, precio,albaran);
END CREAR_FACTURA;
/

--------------------------------------------------------
--  DDL for Procedure CREAR_CLIENTE
--------------------------------------------------------
create or replace PROCEDURE CREAR_CLIENTE (
    nombreCLI IN CLIENTES.NOMBRE_CLI%TYPE,
    app_cli IN CLIENTES.APP_CLI%TYPE,
    apm_cli IN CLIENTES.APM_CLI%TYPE,
    email_cli IN CLIENTES.EMAIL%TYPE,
    dni_cli IN CLIENTES.DNI%TYPE,
    tel_cli IN CLIENTES.TELEFONO%TYPE,
    id_direccion_CLI IN CLIENTES.ID_DIRECCION2%TYPE
    )
IS id_cliente CLIENTES.IDCLIENTE%TYPE;

BEGIN
        SELECT sec_cliente.NEXTVAL INTO id_cliente FROM dual;
        INSERT INTO clientes (IDCLIENTE, NOMBRE_CLI, APP_CLI, APM_CLI, EMAIL, DNI, TELEFONO, ID_DIRECCION2) 
        VALUES(id_cliente, nombreCLI, app_cli, apm_cli, email_cli, dni_cli, tel_cli, id_direccion_CLI);
END CREAR_CLIENTE;
/
--------------------------------------------------------
--  DDL for Procedure CREAR_OFERTA
--------------------------------------------------------
create or replace PROCEDURE CREAR_OFERTA (
        fechaini IN OFERTAS.FECHA_INICIO%TYPE,
        fechafin IN OFERTAS.FECHA_FIN%TYPE,
        precioDes IN OFERTAS.PRECIOOFERTADO%TYPE,
        codigoPro IN OFERTAS.CODIGO%TYPE
    )
IS idOferta OFERTAS.CODIGO%TYPE;
    precioanterior PRODUCTOS.PRECIO%TYPE;
    BEGIN
        SELECT SEC_OFERTA.NEXTVAL INTO idOferta FROM dual;
        SELECT PRODUCTOS.PRECIO INTO precioanterior FROM PRODUCTOS 
        WHERE PRODUCTOS.CODIGO = codigoPro; 
        INSERT INTO OFERTAS (CODIGO, FECHA_INICIO,FECHA_FIN,PRECIOOFERTADO,CODIGO_PROD2,PRECIOANTES)
        VALUES(idOferta, fechaini,fechafin,precioDes,codigoPro,precioanterior);
END CREAR_OFERTA;
/
--------------------------------------------------------
--  DDL for Procedure CREAR_PEDIDO
--------------------------------------------------------
create or replace PROCEDURE CREAR_PEDIDO (
        subtotal IN PEDIDOS.PRECIOTOTAL%TYPE,
        cliente IN PEDIDOS.IDCLIENTE1%TYPE,
        direccion IN PEDIDOS.ID_DIRECCION1%TYPE
    )
AS codigo PEDIDOS.IDPEDIDO%TYPE;
    fecha PEDIDOS.FECHA%TYPE;
    BEGIN
        SELECT SEC_PEDIDO.NEXTVAL INTO codigo FROM dual;
        SELECT TO_CHAR(SysDate,'DD/MM/YYYY HH24:MI:SS') todays_date INTO fecha FROM dual;
        INSERT INTO PEDIDOS (IDPEDIDO, FECHA, PRECIOTOTAL, IDCLIENTE1, ID_DIRECCION1) 
        VALUES(codigo, fecha, subtotal, cliente, direccion);
        CREAR_ESTADOPEDIDO('En proceso', codigo);
END CREAR_PEDIDO;
/
--------------------------------------------------------
--  DDL for Procedure CREAR_LINEAPEDIDO
--------------------------------------------------------
create or replace PROCEDURE CREAR_LINEAPEDIDO (
        cant IN LINEAPEDIDOS.CANTIDADPEDIDO%TYPE,
        precio IN LINEAPEDIDOS.PRECIO%TYPE,
        producto IN LINEAPEDIDOS.CODIGO_PROD1%TYPE,
        pedido IN LINEAPEDIDOS.IDPEDIDO3%TYPE
    )
IS codigo LINEAPEDIDOS.NUMLINE%TYPE;
   BEGIN
        SELECT SEC_LINEAPEDIDOS.NEXTVAL INTO codigo FROM dual;
        INSERT INTO LINEAPEDIDOS (NUMLINE, CANTIDADPEDIDO, PRECIO, CODIGO_PROD1, IDPEDIDO3) 
        VALUES(codigo, cant, precio, producto, pedido);
END CREAR_LINEAPEDIDO;
/
--------------------------------------------------------
--  DDL for Procedure CREAR_PRODUCTO
--------------------------------------------------------
create or replace PROCEDURE CREAR_PRODUCTO (
        nombre IN productos.NOMBRE%TYPE,
        descripcion IN productos.DESCRIPCION%TYPE,
        tipoproducto IN productos.TIPOPRODUCTO%TYPE,
        disponibilidad IN productos.DISPONIBILIDAD%TYPE,
        precio IN productos.PRECIO%TYPE,
        urldocu IN productos.URLDOCU%TYPE,
        urlimg IN productos.URLIMG%TYPE,
        stock IN productos.STOCK%TYPE,
        partnumber IN productos.PARTNUMBER%TYPE,
        modelo IN productos.MODELO%TYPE
    )
IS codigo productos.CODIGO%TYPE;
    BEGIN
        SELECT sec_producto.NEXTVAL INTO codigo FROM dual;
        INSERT INTO productos (CODIGO, NOMBRE, DESCRIPCION, TIPOPRODUCTO, DISPONIBILIDAD, PRECIO, URLDOCU, URLIMG, STOCK, PARTNUMBER, MODELO) 
        VALUES(codigo, nombre, descripcion, tipoproducto, disponibilidad, precio, urldocu, urlimg, stock, partnumber, modelo);
END CREAR_PRODUCTO;
/
--------------------------------------------------------
--  DDL for Procedure NUEVA_DIRECCION
--------------------------------------------------------
create or replace PROCEDURE NUEVA_DIRECCION
( ciudad IN direcciones.CIUDAD%TYPE, numero IN direcciones.NUMERO%TYPE, cp IN direcciones.CP%TYPE, calle IN direcciones.CALLE%TYPE)
AS id_direccion direcciones.ID_DIRECCION%TYPE;

BEGIN
        SELECT sec_direccion.NEXTVAL INTO id_direccion FROM dual;
        INSERT INTO direcciones (ID_DIRECCION, CIUDAD, CP, CALLE, NUMERO) 
        VALUES(id_direccion, ciudad, cp, calle, numero);
END NUEVA_DIRECCION;
/
--------------------------------------------------------
-- Procedimientos de Actualizacion/modificacion
--------------------------------------------------------

--------------------------------------------------------
--  DDL for Procedure UPDATE_ALBARAN
--------------------------------------------------------
create or replace PROCEDURE UPDATE_ALBARAN (
        id_albaranup IN ALBARANES.IDALBARAN%TYPE,
        id_pedidoup IN ALBARANES.IDPEDIDO2%TYPE
    )
IS 
BEGIN
    UPDATE albaranes
    SET IDPEDIDO2 = id_pedidoup
    WHERE IDALBARAN = id_albaranup;
END UPDATE_ALBARAN;
/
--------------------------------------------------------
--  DDL for Procedure UPDATE_ALMACEN
--------------------------------------------------------
create or replace PROCEDURE UPDATE_ALMACEN (
    id_almacenup IN ALMACENES.IDALMACEN%TYPE,
    nombreup IN ALMACENES.NOMBRE%TYPE,
    id_direccionup IN ALMACENES.ID_DIRECCION3%TYPE
    )
IS 
BEGIN
	UPDATE almacenes
	SET NOMBRE = nombreup,
	    ID_DIRECCION3 = id_direccionup
	WHERE IDALMACEN = id_almacenup;
END UPDATE_ALMACEN;
/
--------------------------------------------------------
--  DDL for Procedure UPDATE_CLIENTE
--------------------------------------------------------
create or replace PROCEDURE UPDATE_CLIENTE (
    id_clienteUP IN CLIENTES.IDCLIENTE%TYPE,
    nombreUP IN CLIENTES.NOMBRE_CLI%TYPE,
    appUP IN CLIENTES.APP_CLI%TYPE,
    apmUP IN CLIENTES.APM_CLI%TYPE,
    emaUP IN CLIENTES.EMAIL%TYPE,
    dniUP IN CLIENTES.DNI%TYPE,
    telUP IN CLIENTES.TELEFONO%TYPE,
    id_direccion_CLIUP IN CLIENTES.ID_DIRECCION2%TYPE
    )
IS
BEGIN
	UPDATE clientes
	SET NOMBRE_CLI = nombreUP,
	APP_CLI = appUP,
	APM_CLI = apmUP,
	EMAIL = emaUP,
	DNI = dniUP,
	TELEFONO = telUP,
	ID_DIRECCION2 = id_direccion_CLIUP
	WHERE IDCLIENTE = id_clienteUP;
END UPDATE_CLIENTE;
/
--------------------------------------------------------
--  DDL for Procedure UPDATE_OFERTA
--------------------------------------------------------
create or replace PROCEDURE UPDATE_OFERTA
(       id_oferta IN OFERTAS.CODIGO%TYPE,
        fechaini IN OFERTAS.FECHA_INICIO%TYPE,
        fechafin IN OFERTAS.FECHA_FIN%TYPE,
        precioferta IN OFERTAS.PRECIOOFERTADO%TYPE,
        codigopro IN OFERTAS.CODIGO_PROD2 %TYPE,
        precioanterior IN OFERTAS.PRECIOANTES%TYPE)
IS 
BEGIN
    UPDATE OFERTAS
    SET FECHA_INICIO = fechaini,
    FECHA_FIN = fechafin,
    PRECIOOFERTADO = precioferta,
    CODIGO_PROD2 = codigopro,
    PRECIOANTES = precioanterior
    WHERE CODIGO = id_oferta;
END UPDATE_OFERTA;
/
--------------------------------------------------------
--  DDL for Procedure UPDATE_DIRECCION
--------------------------------------------------------
create or replace PROCEDURE UPDATE_DIRECCION
(       id_direccionup IN DIRECCIONES.ID_DIRECCION%TYPE,
        ciudadup IN direcciones.CIUDAD%TYPE,
        cpup IN direcciones.CP%TYPE,
        calleup IN direcciones.CALLE%TYPE,
        numeroup IN direcciones.NUMERO%TYPE)
IS 
BEGIN
	UPDATE direcciones
	SET ciudad = ciudadup,
	cp = cpup,
	calle = calleup,
	numero = numeroup
	WHERE ID_DIRECCION = id_direccionup;
END UPDATE_DIRECCION;
/
--------------------------------------------------------
--  DDL for Procedure UPDATE_ESTADOPEDIDO
--------------------------------------------------------
create or replace PROCEDURE UPDATE_ESTADOPEDIDO (
        pedido IN ESTADOPEDIDOS.IDPEDIDO1%TYPE,
       estado IN ESTADOPEDIDOS.ESTADOPEDIDO%TYPE
    )
IS 
BEGIN
    UPDATE ESTADOPEDIDOS
    SET ESTADOPEDIDO = estado
    WHERE IDPEDIDO1 = pedido;
END UPDATE_ESTADOPEDIDO;
/
--------------------------------------------------------
--  DDL for Procedure UPDATE_FACTURA
--------------------------------------------------------
create or replace PROCEDURE UPDATE_FACTURA (
        id_factura IN FACTURAS.IDFACTURA%TYPE,
       precio IN FACTURAS.PRECIOTOTAL%TYPE,
       pago IN FACTURAS.TIPOFORMAPAGO%TYPE
        
    )
IS
BEGIN
    UPDATE FACTURAS
    SET PRECIOTOTAL = precio,
        TIPOFORMAPAGO = pago
    WHERE IDFACTURA = id_factura;
END UPDATE_FACTURA;
/
--------------------------------------------------------
--  DDL for Procedure UPDATE_LINEAPEDIDO
--------------------------------------------------------
create or replace PROCEDURE UPDATE_LINEAPEDIDO (
        num IN LINEAPEDIDOS.NUMLINE%TYPE,
        cant IN LINEAPEDIDOS.CANTIDADPEDIDO%TYPE,
        precio IN LINEAPEDIDOS.PRECIO%TYPE,
        idProduc IN LINEAPEDIDOS.CODIGO_PROD1%TYPE
    )
IS 
    BEGIN
    UPDATE LINEAPEDIDOS
    SET CANTIDADPEDIDO = cant,
    PRECIO = precio
    WHERE NUMLINE = num;
END UPDATE_LINEAPEDIDO;
/
--------------------------------------------------------
--  DDL for Procedure UPDATE_PEDIDO
--------------------------------------------------------
create or replace PROCEDURE UPDATE_PEDIDO (
        codigopedido IN PEDIDOS.IDPEDIDO%TYPE,
        fech IN PEDIDOS.FECHA%TYPE,
        subtotal IN PEDIDOS.PRECIOTOTAL%TYPE,
        cliente IN PEDIDOS.IDCLIENTE1%TYPE,
        direccion IN PEDIDOS.ID_DIRECCION1%TYPE
    )
IS 
    BEGIN
    UPDATE PEDIDOS
    SET PRECIOTOTAL = subtotal,
    ID_DIRECCION1 = direccion
    WHERE IDPEDIDO = codigopedido;
END UPDATE_PEDIDO;
/
--------------------------------------------------------
--  DDL for Procedure UPDATE_PRODUCTO
--------------------------------------------------------
create or replace PROCEDURE UPDATE_PRODUCTO (
		codigoup IN productos.CODIGO%TYPE,
        nombreup IN productos.NOMBRE%TYPE,
        descripcionup IN productos.DESCRIPCION%TYPE,
        tipoproductoup IN productos.TIPOPRODUCTO%TYPE,
        disponibilidadup IN productos.DISPONIBILIDAD%TYPE,
        precioup IN productos.PRECIO%TYPE,
        urldocuup IN productos.URLDOCU%TYPE,
        urlimgup IN productos.URLIMG%TYPE,
        stockup IN productos.STOCK%TYPE,
        partnumberup IN productos.PARTNUMBER%TYPE,
        modeloup IN productos.MODELO%TYPE
    )
IS 
    BEGIN
	UPDATE productos
	SET nombre = nombreup,
	descripcion = descripcionup,
	tipoproducto = tipoproductoup,
	disponibilidad = disponibilidadup,
	precio = precioup,
	urldocu = urldocuup,
	urlimg = urlimgup,
	stock = stockup,
	partnumber = partnumberup,
	modelo = modeloup
	WHERE codigo = codigoup;
END UPDATE_PRODUCTO;
/
 --Procedimiento para reiniciar una secuencia 
 CREATE OR REPLACE PROCEDURE RESET_SEC( p_seq_name in varchar2 ) is
           l_val number;
       BEGIN
           execute immediate
            'select ' || p_seq_name || '.nextval from dual' INTO l_val;
            execute immediate
           'alter sequence ' || p_seq_name || ' increment by -' || l_val || ' minvalue 0';
           execute immediate
           'select ' || p_seq_name || '.nextval from dual' INTO l_val;
           execute immediate
          'alter sequence ' || p_seq_name || ' increment by 1 minvalue 0';
     END;

--Función para calcular precio total del pedido
CREATE OR REPLACE FUNCTION PRECIO_TOTAL
    (INDPEDIDO IN PEDIDOS.IDPEDIDO%TYPE)
    RETURN NUMBER
IS
    PRECIOFINAL PEDIDOS.PRECIOTOTAL%TYPE;
BEGIN 
    SELECT SUM(PRODUCTOS.PRECIO) INTO PRECIOFINAL
    FROM PRODUCTOS, LINEAPEDIDOS
    WHERE LINEAPEDIDOS.ID_PEDIDOX = INDPEDIDO
    AND LINEAPEDIDOS.CODIGO_PRODX = PRODUCTOS.CODIGO;
    RETURN PRECIOFINAL;
END PRECIO_TOTAL;  


--Función para aplicar ofertas
CREATE OR REPLACE FUNCTION APLICA_OFERTA
    (CODIG IN OFERTAS.CODIGO%TYPE)
    RETURN NUMBER
IS
    fechaActual OFERTAS.FECHA_INICIO%TYPE;
    fechaini    OFERTAS.FECHA_INICIO%TYPE;
    fechafin    OFERTAS.FECHA_INICIO%TYPE;
    nuevoPrecio OFERTAS.PRECIOOFERTADO%TYPE;
    precio OFERTAS.PRECIOANTES%TYPE;
    producto    OFERTAS.CODIGO_PROD2%TYPE;
    porcentaje  NUMBER;
BEGIN 
    SELECT TO_CHAR(SysDate,'DD/MM/YYYY') todays_date INTO fechaActual FROM dual;
        IF fechaActual>= fechaini AND fechaActual>=fechafin then
        SELECT OFERTAS.PRECIOOFERTADO INTO nuevoPrecio FROM OFERTAS;
        SELECT OFERTAS.CODIGO_PROD2 INTO producto FROM OFERTAS;
            UPDATE PRODUCTOS
            SET PRECIO = nuevoPrecio
            WHERE CODIGO = producto;
        ELSE
         Raise_application_error(-20600,'No se puede aplicar la oferta, fuera de fecha');
    END IF;
    SELECT OFERTAS.PRECIOANTES INTO precio FROM OFERTAS;
    SELECT (precio-nuevoPrecio)*100 INTO porcentaje FROM dual;
    RETURN porcentaje;
END APLICA_OFERTA;

create or replace FUNCTION ASSERT_EQUALS (salida BOOLEAN, salida_esperada BOOLEAN)
RETURN VARCHAR2 
AS
BEGIN 
IF(salida = salida_esperada) THEN
RETURN 'EXITO';
ELSE 
RETURN 'FALLO';
END IF;
END ASSERT_EQUALS;
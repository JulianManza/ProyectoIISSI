--------------------------------------------------------
--  PRUEBAS ALMACENES
--------------------------------------------------------
create or replace PACKAGE ALMACENES_PRUEBA IS 

/*Creamos el procedimiento inicializar la cabecera*/

 Procedure inicializar;
 
 /*Creamos el procedimiento crear la cabecera*/

 PROCEDURE CREAR_ALMACEN (
    nombreal IN ALMACENES.NOMBRE%TYPE,
    id_direccional IN ALMACENES.ID_DIRECCION3%TYPE
    );
 /*Creamos el procedimiento borrar la cabecera*/

 PROCEDURE BORRAR_ALMACEN (
    id_almacendel IN ALMACENES.IDALMACEN%TYPE
    );   
 /*Creamos el procedimiento actualizar la cabecera*/

 PROCEDURE UPDATE_ALMACEN (
    id_almacenup IN ALMACENES.IDALMACEN%TYPE,
    nombreup IN ALMACENES.NOMBRE%TYPE,
    id_direccionup IN ALMACENES.ID_DIRECCION3%TYPE
    );   

END ALMACENES_PRUEBA;
/
create or replace PACKAGE BODY ALMACENES_PRUEBA AS
 procedure inicializar is
 begin
  /*Se borran todas las tablas*/

 DELETE FROM almacenes;
 end inicializar;
 
  /*Copiar y pegar el procedimiento crear*/

 PROCEDURE CREAR_ALMACEN (
    nombreal IN ALMACENES.NOMBRE%TYPE,
    id_direccional IN ALMACENES.ID_DIRECCION3%TYPE
    )
IS idalmacen ALMACENES.IDALMACEN%TYPE;

BEGIN
        SELECT sec_almacen.NEXTVAL INTO idalmacen FROM dual;
        INSERT INTO almacenes (IDALMACEN, NOMBRE, ID_DIRECCION3) 
        VALUES(idalmacen, nombreal, id_direccional);
        DBMS_OUTPUT.PUT_LINE(nombreal);
END CREAR_ALMACEN;
  /*Copiar y pegar el procedimiento borrar*/

    PROCEDURE BORRAR_ALMACEN (
    id_almacendel IN ALMACENES.IDALMACEN%TYPE
    )
IS idalmacen ALMACENES.IDALMACEN%TYPE;

BEGIN
    DELETE FROM almacenes WHERE IDALMACEN = idalmacen;
END BORRAR_ALMACEN;
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE UPDATE_ALMACEN (
    id_almacenup IN ALMACENES.IDALMACEN%TYPE,
    nombreup IN ALMACENES.NOMBRE%TYPE,
    id_direccionup IN ALMACENES.ID_DIRECCION3%TYPE
    )
IS idalmacen ALMACENES.IDALMACEN%TYPE;

BEGIN
	UPDATE almacenes
	SET IDALMACEN = id_almacenup,
	NOMBRE = nombreup,
	ID_DIRECCION3 = id_direccionup
	WHERE IDALMACEN = id_almacenup;
END UPDATE_ALMACEN;  

    end almacenes_prueba;

/
--------------------------------------------------------
--  PRUEBAS ALBARANES
--------------------------------------------------------

create or replace PACKAGE ALBARANES_PRUEBA IS 

/*Creamos el procedimiento inicializar la cabecera*/

 Procedure inicializar;
 
 /*Creamos el procedimiento crear la cabecera*/

 PROCEDURE CREAR_ALBARAN (
        id_pedido IN ALBARANES.IDPEDIDO2%TYPE
    );
 /*Creamos el procedimiento borrar la cabecera*/

 PROCEDURE BORRAR_ALBARAN (
    idborrar IN ALBARANES.IDALBARAN%TYPE
    );   
 /*Creamos el procedimiento actualizar la cabecera*/

 PROCEDURE UPDATE_ALBARAN (
        id_albaranup IN ALBARANES.IDALBARAN%TYPE,
        id_pedidoup IN ALBARANES.IDPEDIDO2%TYPE
    );   

END ALBARANES_PRUEBA;
/
create or replace PACKAGE BODY ALBARANES_PRUEBA AS
 procedure inicializar is
 begin
  /*Se borran todas las tablas*/

 DELETE FROM ALBARANES;
 end inicializar;
 
  /*Copiar y pegar el procedimiento crear*/

 PROCEDURE CREAR_ALBARAN (
        id_pedido IN ALBARANES.IDPEDIDO2%TYPE
    )
IS id_albaran ALBARANES.IDALBARAN%TYPE;
    BEGIN
        SELECT sec_albaran.NEXTVAL INTO id_albaran FROM dual;
        INSERT INTO albaranes (IDALBARAN, IDPEDIDO2) 
        VALUES(id_albaran, id_pedido);
END CREAR_ALBARAN;
  /*Copiar y pegar el procedimiento borrar*/

    PROCEDURE BORRAR_ALBARAN (
    idborrar IN ALBARANES.IDALBARAN%TYPE
    )
IS idalbaran ALBARANES.IDALBARAN%TYPE;

BEGIN
    DELETE FROM albaranes WHERE IDALBARAN = idborrar;
END BORRAR_ALBARAN;
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE UPDATE_ALBARAN (
        id_albaranup IN ALBARANES.IDALBARAN%TYPE,
        id_pedidoup IN ALBARANES.IDPEDIDO2%TYPE
    )
IS 
BEGIN
	UPDATE albaranes
	SET IDPEDIDO2 = id_pedidoup
	WHERE IDALBARAN = id_albaranup;
END UPDATE_ALBARAN;

    end ALBARANES_PRUEBA;

/
--------------------------------------------------------
--  PRUEBAS CLIENTES
--------------------------------------------------------
create or replace PACKAGE CIENTES_PRUEBA IS 

/*Creamos el procedimiento inicializar la cabecera*/

 Procedure inicializar;
 
 /*Creamos el procedimiento crear la cabecera*/

 PROCEDURE CREAR_CLIENTE (
    nombreCLI IN CLIENTES.NOMBRE_CLI%TYPE,
    app_cli IN CLIENTES.APP_CLI%TYPE,
    apm_cli IN CLIENTES.APM_CLI%TYPE,
    email_cli IN CLIENTES.EMAIL%TYPE,
    dni_cli IN CLIENTES.DNI%TYPE,
    tel_cli IN CLIENTES.TELEFONO%TYPE,
    id_direccion_CLI IN CLIENTES.ID_DIRECCION2%TYPE
    );
 /*Creamos el procedimiento borrar la cabecera*/

 PROCEDURE ELIMINAR_CLIENTE (
    id_clienteDEL IN CLIENTES.IDCLIENTE%TYPE
    );   
 /*Creamos el procedimiento actualizar la cabecera*/

 PROCEDURE UPDATE_CLIENTE (
    id_clienteUP IN CLIENTES.IDCLIENTE%TYPE,
    nombreUP IN CLIENTES.NOMBRE_CLI%TYPE,
    appUP IN CLIENTES.APP_CLI%TYPE,
    apmUP IN CLIENTES.APM_CLI%TYPE,
    emaUP IN CLIENTES.EMAIL%TYPE,
    dniUP IN CLIENTES.DNI%TYPE,
    telUP IN CLIENTES.TELEFONO%TYPE,
    id_direccion_CLIUP IN CLIENTES.ID_DIRECCION2%TYPE
    );   

END CIENTES_PRUEBA;
/
create or replace PACKAGE BODY CIENTES_PRUEBA AS
 procedure inicializar is
 begin
  /*Se borran todas las tablas*/

 DELETE FROM CLIENTES;
 end inicializar;
 
  /*Copiar y pegar el procedimiento crear*/

 PROCEDURE CREAR_CLIENTE (
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
  /*Copiar y pegar el procedimiento borrar*/

    PROCEDURE ELIMINAR_CLIENTE (
    id_clienteDEL IN CLIENTES.IDCLIENTE%TYPE
    )
IS id_cliente CLIENTES.IDCLIENTE%TYPE;

BEGIN
        DELETE FROM clientes WHERE IDCLIENTE = id_clienteDEL;
END ELIMINAR_CLIENTE;
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE UPDATE_CLIENTE (
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

    end CIENTES_PRUEBA;

/

--------------------------------------------------------
--  PRUEBAS DIRECCIONES
--------------------------------------------------------

create or replace PACKAGE DIRECCIONES_PRUEBA IS 

/*Creamos el procedimiento inicializar la cabecera*/

 Procedure inicializar;
 
 /*Creamos el procedimiento crear la cabecera*/

 PROCEDURE NUEVA_DIRECCION ( 
 	ciudad IN direcciones.CIUDAD%TYPE,
 	numero IN direcciones.NUMERO%TYPE,
 	cp IN direcciones.CP%TYPE,
 	calle IN direcciones.CALLE%TYPE);
 /*Creamos el procedimiento borrar la cabecera*/

 PROCEDURE ELIMINA_DIRECCION(
        id_direccionborrar IN DIRECCIONES.ID_DIRECCION%TYPE
);   
 /*Creamos el procedimiento actualizar la cabecera*/

 PROCEDURE UPDATE_DIRECCION
(       id_direccionup IN DIRECCIONES.ID_DIRECCION%TYPE,
        ciudadup IN direcciones.CIUDAD%TYPE,
        cpup IN direcciones.CP%TYPE,
        calleup IN direcciones.CALLE%TYPE,
        numeroup IN direcciones.NUMERO%TYPE);   

END DIRECCIONES_PRUEBA;
/
create or replace PACKAGE BODY DIRECCIONES_PRUEBA AS
 procedure inicializar is
 begin
  /*Se borran todas las tablas*/

 DELETE FROM DIRECCIONES;
 end inicializar;
 
  /*Copiar y pegar el procedimiento crear*/

 PROCEDURE NUEVA_DIRECCION
( ciudad IN direcciones.CIUDAD%TYPE, numero IN direcciones.NUMERO%TYPE, cp IN direcciones.CP%TYPE, calle IN direcciones.CALLE%TYPE)
AS id_direccion direcciones.ID_DIRECCION%TYPE;

BEGIN
        SELECT sec_direccion.NEXTVAL INTO id_direccion FROM dual;
        INSERT INTO direcciones (ID_DIRECCION, CIUDAD, CP, CALLE, NUMERO) 
        VALUES(id_direccion, ciudad, cp, calle, numero);
END NUEVA_DIRECCION;
  /*Copiar y pegar el procedimiento borrar*/

    PROCEDURE ELIMINA_DIRECCION(
        id_direccionborrar IN DIRECCIONES.ID_DIRECCION%TYPE
)
IS id_direccion direcciones.ID_DIRECCION%TYPE;

BEGIN
    DELETE FROM direcciones WHERE id_direccion = id_direccionborrar;
END ELIMINA_DIRECCION;
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE UPDATE_DIRECCION
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

    end DIRECCIONES_PRUEBA;

/
--------------------------------------------------------
--  PRUEBAS ESTADO DE PEDIDOS
--------------------------------------------------------

create or replace PACKAGE ESTADOPEDIDOS_PRUEBA IS 
 
/*Creamos el procedimiento inicializar la cabecera*/
PROCEDURE inicializar;

PROCEDURE CREAR_ESTADOPEDIDO (
        estado IN ESTADOPEDIDOS.ESTADOPEDIDO%TYPE,
        pedido IN ESTADOPEDIDOS.IDPEDIDO1%TYPE
    );
 /*Creamos el procedimiento borrar la cabecera*/
    
 PROCEDURE BORRAR_ESTADOPEDIDO (
    idborrar IN ESTADOPEDIDOS.IDPEDIDO1%TYPE
    );   
    
  PROCEDURE UPDATE_ESTADOPEDIDO (
        pedido IN ESTADOPEDIDOS.IDPEDIDO1%TYPE,
       estado IN ESTADOPEDIDOS.ESTADOPEDIDO%TYPE
    );   

END ESTADOPEDIDOS_PRUEBA;
/
create or replace PACKAGE BODY ESTADOPEDIDOS_PRUEBA AS
procedure inicializar is
 begin
 DELETE FROM ESTADOPEDIDOS;
 end inicializar;

  /*Copiar y pegar el procedimiento actualizar*/
    PROCEDURE CREAR_ESTADOPEDIDO (
        estado IN ESTADOPEDIDOS.ESTADOPEDIDO%TYPE,
        pedido IN ESTADOPEDIDOS.IDPEDIDO1%TYPE
    )
IS codigo ESTADOPEDIDOS.ESTADOPEDIDO%TYPE;
   BEGIN
        INSERT INTO ESTADOPEDIDOS (ESTADOPEDIDO, IDPEDIDO1) 
        VALUES(estado, pedido);
END CREAR_ESTADOPEDIDO;

    PROCEDURE BORRAR_ESTADOPEDIDO (
    idborrar IN ESTADOPEDIDOS.IDPEDIDO1%TYPE
    )
IS 
BEGIN
    DELETE FROM ESTADOPEDIDOS WHERE IDPEDIDO1 = idborrar;
END BORRAR_ESTADOPEDIDO;

  PROCEDURE UPDATE_ESTADOPEDIDO (
        pedido IN ESTADOPEDIDOS.IDPEDIDO1%TYPE,
       estado IN ESTADOPEDIDOS.ESTADOPEDIDO%TYPE
    )
IS 
BEGIN
    UPDATE ESTADOPEDIDOS
    SET ESTADOPEDIDO = estado
    WHERE IDPEDIDO1 = pedido;
END UPDATE_ESTADOPEDIDO;

    end ESTADOPEDIDOS_PRUEBA;
/
--------------------------------------------------------
--  PRUEBAS LINEAS DE PEDIDOS
--------------------------------------------------------
create or replace PACKAGE LINEAPEDIDOS_PRUEBA AS
	/*Creamos el procedimiento inicializar la cabecera*/

 PROCEDURE inicializar;
 /*Creamos el procedimiento crear la cabecera*/
 
 PROCEDURE CREAR_LINEAPEDIDO (
        cant IN LINEAPEDIDOS.CANTIDADPEDIDO%TYPE,
        precio IN LINEAPEDIDOS.PRECIO%TYPE,
        producto IN LINEAPEDIDOS.CODIGO_PROD1%TYPE,
        pedido IN LINEAPEDIDOS.IDPEDIDO3%TYPE
    );
 /*Creamos el procedimiento borrar la cabecera*/
    
 PROCEDURE ELIMINA_LINEAPEDIDO (
    num IN LINEAPEDIDOS.NUMLINE%TYPE
    );   
  /*Creamos el procedimiento actualizar la cabecera*/
 PROCEDURE UPDATE_LINEAPEDIDO (
        num IN LINEAPEDIDOS.NUMLINE%TYPE,
        cant IN LINEAPEDIDOS.CANTIDADPEDIDO%TYPE,
        precio IN LINEAPEDIDOS.PRECIO%TYPE,
        idProduc IN LINEAPEDIDOS.CODIGO_PROD1%TYPE
    );   

END LINEAPEDIDOS_PRUEBA;
/
create or replace PACKAGE BODY LINEAPEDIDOS_PRUEBA AS
/*Se borran todas las tablas*/
 procedure inicializar is
 begin
 DELETE FROM LINEAPEDIDOS;
 end inicializar;
 /*Copiar y pegar el procedimiento crear*/
PROCEDURE CREAR_LINEAPEDIDO (
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
/*Copiar y pegar el procedimiento borrar*/
PROCEDURE ELIMINA_LINEAPEDIDO (
        num IN LINEAPEDIDOS.NUMLINE%TYPE
    )
IS NUMLINE LINEAPEDIDOS.NUMLINE%TYPE;
    BEGIN
    DELETE FROM LINEAPEDIDOS WHERE NUMLINE = num;
END ELIMINA_LINEAPEDIDO;
/*Copiar y pegar el procedimiento actualizar*/
PROCEDURE UPDATE_LINEAPEDIDO (
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
    end LINEAPEDIDOS_PRUEBA;

/
--------------------------------------------------------
--  PRUEBAS PEDIDOS
--------------------------------------------------------
create or replace PACKAGE PEDIDOS_PRUEBA IS 

/*Creamos el procedimiento inicializar la cabecera*/

 Procedure inicializar;
 
 /*Creamos el procedimiento crear la cabecera*/

 PROCEDURE CREAR_PEDIDO (
        subtotal IN PEDIDOS.PRECIOTOTAL%TYPE,
        cliente IN PEDIDOS.IDCLIENTE1%TYPE,
        direccion IN PEDIDOS.ID_DIRECCION1%TYPE
    );
 /*Creamos el procedimiento borrar la cabecera*/

 PROCEDURE ELIMINA_PEDIDO (
    codigoborrar IN PEDIDOS.IDPEDIDO%TYPE
    );   
 /*Creamos el procedimiento actualizar la cabecera*/

 PROCEDURE UPDATE_PEDIDO (
        codigopedido IN PEDIDOS.IDPEDIDO%TYPE,
		fech IN PEDIDOS.FECHA%TYPE,
        subtotal IN PEDIDOS.PRECIOTOTAL%TYPE,
        cliente IN PEDIDOS.IDCLIENTE1%TYPE,
        direccion IN PEDIDOS.ID_DIRECCION1%TYPE
    );   

END PEDIDOS_PRUEBA;
/
create or replace PACKAGE BODY PEDIDOS_PRUEBA AS
 procedure inicializar is
 begin
  /*Se borran todas las tablas*/

 DELETE FROM PEDIDOS;
 end inicializar;
 
  /*Copiar y pegar el procedimiento crear*/

 PROCEDURE CREAR_PEDIDO (
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
        INSERT INTO ESTADOPEDIDOS (ESTADOPEDIDO,IDPEDIDO1)
        VALUES ('En Proceso', codigo);
END CREAR_PEDIDO;
  /*Copiar y pegar el procedimiento borrar*/

    PROCEDURE ELIMINA_PEDIDO (
    codigoborrar IN PEDIDOS.IDPEDIDO%TYPE
)
IS codigo PEDIDOS.IDPEDIDO%TYPE;

BEGIN
    DELETE FROM PEDIDOS WHERE IDPEDIDO = codigoborrar;
    DELETE FROM ESTADOPEDIDOS WHERE IDPEDIDO1 = codigoborrar;
    DELETE FROM LINEAPEDIDOS WHERE IDPEDIDO3 = codigoborrar;
END ELIMINA_PEDIDO;
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE UPDATE_PEDIDO (
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

    end pedidos_prueba;

/
--------------------------------------------------------
--  PRUEBAS PRODUCTOS
--------------------------------------------------------
create or replace PACKAGE PRODUCTOS_PRUEBA IS 

/*Creamos el procedimiento inicializar la cabecera*/

 Procedure inicializar;
 
 /*Creamos el procedimiento crear la cabecera*/

 PROCEDURE CREAR_PRODUCTO (
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
    );
 /*Creamos el procedimiento borrar la cabecera*/

 PROCEDURE ELIMINA_PRODUCTO (
    codigoborrar IN productos.CODIGO%TYPE
    );   
 /*Creamos el procedimiento actualizar la cabecera*/

 PROCEDURE UPDATE_PRODUCTO (
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
    );   

END PRODUCTOS_PRUEBA;
/
create or replace PACKAGE BODY PRODUCTOS_PRUEBA AS
 procedure inicializar is
 begin
  /*Se borran todas las tablas*/

 DELETE FROM PRODUCTOS;
 end inicializar;
 
  /*Copiar y pegar el procedimiento crear*/

 PROCEDURE CREAR_PRODUCTO (
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
  /*Copiar y pegar el procedimiento borrar*/

    PROCEDURE ELIMINA_PRODUCTO (
    codigoborrar IN productos.CODIGO%TYPE
)
IS codigo productos.CODIGO%TYPE;

BEGIN
    DELETE FROM productos WHERE codigo = codigoborrar;
END ELIMINA_PRODUCTO;
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE UPDATE_PRODUCTO (
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

    end PRODUCTOS_prueba;

/

--------------------------------------------------------
--  PRUEBAS OFERTAS
--------------------------------------------------------
create or replace PACKAGE OFERTAS_PRUEBA IS 

/*Creamos el procedimiento inicializar la cabecera*/

 Procedure inicializar;
 
 /*Creamos el procedimiento crear la cabecera*/

 PROCEDURE CREAR_OFERTA (
        fechaini IN OFERTAS.FECHA_INICIO%TYPE,
        fechafin IN OFERTAS.FECHA_FIN%TYPE,
        precioDes IN OFERTAS.PRECIOOFERTADO%TYPE,
        codigoPro IN OFERTAS.CODIGO%TYPE
    );
 /*Creamos el procedimiento borrar la cabecera*/

 PROCEDURE ELIMINA_OFERTA (
    id_ofertaborrar IN OFERTAS.CODIGO%TYPE
    );   
 /*Creamos el procedimiento actualizar la cabecera*/

 PROCEDURE UPDATE_OFERTA (
        id_oferta IN OFERTAS.CODIGO%TYPE,
        fechaini IN OFERTAS.FECHA_INICIO%TYPE,
        fechafin IN OFERTAS.FECHA_FIN%TYPE,
        precioferta IN OFERTAS.PRECIOOFERTADO%TYPE,
        codigopro IN OFERTAS.CODIGO_PROD2 %TYPE,
        precioanterior IN OFERTAS.PRECIOANTES%TYPE
    );   

END OFERTAS_PRUEBA;
/
create or replace PACKAGE BODY OFERTAS_PRUEBA AS
 procedure inicializar is
 begin
  /*Se borran todas las tablas*/

 DELETE FROM OFERTAS;
 end inicializar;
 
  /*Copiar y pegar el procedimiento crear*/

 PROCEDURE CREAR_OFERTA (
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
  /*Copiar y pegar el procedimiento borrar*/

    PROCEDURE ELIMINA_OFERTA (
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
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE UPDATE_OFERTA
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

    end OFERTAS_prueba;

/
--------------------------------------------------------
--  PRUEBAS FACTURAS
--------------------------------------------------------
create or replace PACKAGE FACTURAS_PRUEBA IS 

/*Creamos el procedimiento inicializar la cabecera*/

 Procedure inicializar;
 
 /*Creamos el procedimiento crear la cabecera*/

 PROCEDURE CREAR_FACTURA (
        albaran IN FACTURAS.IDALBARAN1%TYPE,
        pago IN FACTURAS.TIPOFORMAPAGO%TYPE
    );
 /*Creamos el procedimiento borrar la cabecera*/

 PROCEDURE BORRAR_FACTURA (
    idborrar IN FACTURAS.IDFACTURA%TYPE
    );   
 /*Creamos el procedimiento actualizar la cabecera*/

 PROCEDURE UPDATE_FACTURA (
        id_factura IN FACTURAS.IDFACTURA%TYPE,
       precio IN FACTURAS.PRECIOTOTAL%TYPE,
       pago IN FACTURAS.TIPOFORMAPAGO%TYPE
    );   

END FACTURAS_PRUEBA;
/
create or replace PACKAGE BODY FACTURAS_PRUEBA AS
 procedure inicializar is
 begin
  /*Se borran todas las tablas*/

 DELETE FROM FACTURAS;
 end inicializar;
 
  /*Copiar y pegar el procedimiento crear*/

 PROCEDURE CREAR_FACTURA (
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
  /*Copiar y pegar el procedimiento borrar*/

    PROCEDURE BORRAR_FACTURA (
    idborrar IN FACTURAS.IDFACTURA%TYPE
    )
IS factura FACTURAS.IDFACTURA%TYPE;

BEGIN
    DELETE FROM FACTURAS WHERE IDFACTURA = idborrar;
END BORRAR_FACTURA;
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE UPDATE_FACTURA (
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

    end FACTURAS_PRUEBA;

/
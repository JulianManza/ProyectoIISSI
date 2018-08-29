--------------------------------------------------------
-- Pruebas de ALMACENES 
--------------------------------------------------------
create or replace PACKAGE ALMACENES_PRUEBA IS 
/*Creamos el procedimiento inicializar la cabecera*/

 Procedure INICIALIZAR;
 /*Creamos el procedimiento crear la cabecera*/
    /* Formato procedimientos: nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
    nombre IN ALMACENES.NOMBRE%TYPE,
    id_direccion IN ALMACENES.ID_DIRECCION3%TYPE,
    salida_esperada_in BOOLEAN
    );
 /*Creamos el procedimiento borrar la cabecera*/
    /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    id_almacen IN ALMACENES.IDALMACEN%TYPE,
    salida_esperada_el BOOLEAN
    );   
 /*Creamos el procedimiento actualizar la cabecera*/
 /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
    id_almacenup IN ALMACENES.IDALMACEN%TYPE,
    nombreup IN ALMACENES.NOMBRE%TYPE,
    id_direccionup IN ALMACENES.ID_DIRECCION3%TYPE,
    salida_esperada_up BOOLEAN
    );   

END ALMACENES_PRUEBA;
/
create or replace PACKAGE BODY ALMACENES_PRUEBA AS
 procedure INICIALIZAR is
 begin
  /*Se borran todas las tablas*/

 DELETE FROM ALMACENES;
 end INICIALIZAR;

  /*Copiar y pegar el procedimiento crear*/

 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
    nombre IN ALMACENES.NOMBRE%TYPE,
    id_direccion IN ALMACENES.ID_DIRECCION3%TYPE,
    salida_esperada_in BOOLEAN
    )
AS salidain BOOLEAN := TRUE;
    almacen ALMACENES.NOMBRE%TYPE;
    id_almacen ALMACENES.IDALMACEN%TYPE;
BEGIN
        /*Llamada al procedimiento a probar*/
        CREAR_ALMACEN(nombre,id_direccion);
        id_almacen := SEC_ALMACEN.CURRVAL;
        /*Comprobar que se ha realizado con exito */
        SELECT ALMACENES.NOMBRE INTO almacen FROM ALMACENES WHERE IDALMACEN = id_almacen;
        IF(almacen<>nombre ) THEN
        salidain := FALSE;
        END IF;
        COMMIT WORK;
    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
        || ASSERT_EQUALS(salidain,salida_Esperada_in));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_in));
         ROLLBACK;
        END INSERTAR;

  /*Copiar y pegar el procedimiento borrar*/
    PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    id_almacen IN ALMACENES.IDALMACEN%TYPE,
    salida_esperada_el BOOLEAN
    )
AS salidael BOOLEAN := TRUE;
    numeroAlmacenes NUMBER;
BEGIN
    BORRAR_ALMACEN(id_almacen);
    SELECT COUNT(*) INTO numeroAlmacenes FROM ALMACENES 
    WHERE IDALMACEN= id_almacen;
    IF(numeroAlmacenes <> 0) THEN
    salidael:= FALSE;
    END IF;
    COMMIT WORK;
    DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
        || ASSERT_EQUALS(salidael,salida_Esperada_el));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_el));
         ROLLBACK;
    END ELIMINAR;
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
    id_almacenup IN ALMACENES.IDALMACEN%TYPE,
    nombreup IN ALMACENES.NOMBRE%TYPE,
    id_direccionup IN ALMACENES.ID_DIRECCION3%TYPE,
    salida_esperada_up BOOLEAN
    )
AS salidaup BOOLEAN := TRUE;
    almacen ALMACENES.NOMBRE%TYPE;
    id_almacen ALMACENES.IDALMACEN%TYPE;
BEGIN
        /*Llamada al procedimiento a probar*/
        UPDATE_ALMACEN(id_almacenup,nombreup,id_direccionup);
        id_almacen := SEC_ALMACEN.CURRVAL;
        /*Comprobar que se ha realizado con exito */
        SELECT ALMACENES.NOMBRE INTO almacen FROM ALMACENES WHERE IDALMACEN = id_almacen;
        IF(almacen <> nombreup ) THEN
        salidaup := FALSE;
        END IF;
        COMMIT WORK;


    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
        || ASSERT_EQUALS(salidaup,salida_Esperada_up));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_up));
         ROLLBACK;
        END ACTUALIZAR;

    end ALMACENES_PRUEBA;
/
--------------------------------------------------------
-- Pruebas de LINEAPEDIDOS 
--------------------------------------------------------
    create or replace PACKAGE LINEAPEDIDOS_PRUEBA IS 
/*Creamos el procedimiento inicializar la cabecera*/

 Procedure INICIALIZAR;
 /*Creamos el procedimiento crear la cabecera*/
    /* Formato procedimientos: nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
    cant IN LINEAPEDIDOS.CANTIDADPEDIDO%TYPE,
    precio IN LINEAPEDIDOS.PRECIO%TYPE,
    producto IN LINEAPEDIDOS.CODIGO_PROD1%TYPE,
    pedido IN LINEAPEDIDOS.IDPEDIDO3%TYPE,
    salida_esperada_in BOOLEAN
    );
 /*Creamos el procedimiento borrar la cabecera*/
    /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    num IN LINEAPEDIDOS.NUMLINE%TYPE,
    salida_esperada_el BOOLEAN
    );   
 /*Creamos el procedimiento actualizar la cabecera*/
 /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
    num IN LINEAPEDIDOS.NUMLINE%TYPE,
    cant IN LINEAPEDIDOS.CANTIDADPEDIDO%TYPE,
    precio IN LINEAPEDIDOS.PRECIO%TYPE,
    idProduc IN LINEAPEDIDOS.CODIGO_PROD1%TYPE,
    salida_esperada_up BOOLEAN
    );   

END LINEAPEDIDOS_PRUEBA;
/
create or replace PACKAGE BODY LINEAPEDIDOS_PRUEBA AS
 procedure INICIALIZAR is
 begin
  /*Se borran todas las tablas*/

 DELETE FROM LINEAPEDIDOS;
 end INICIALIZAR;

  /*Copiar y pegar el procedimiento crear*/

 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
    cant IN LINEAPEDIDOS.CANTIDADPEDIDO%TYPE,
    precio IN LINEAPEDIDOS.PRECIO%TYPE,
    producto IN LINEAPEDIDOS.CODIGO_PROD1%TYPE,
    pedido IN LINEAPEDIDOS.IDPEDIDO3%TYPE,
    salida_esperada_in BOOLEAN
    )
AS salidain BOOLEAN := TRUE;
    linea LINEAPEDIDOS.NUMLINE%TYPE;
    id_LINEAPEDIDO LINEAPEDIDOS.NUMLINE%TYPE;
BEGIN
        /*Llamada al procedimiento a probar*/
        CREAR_LINEAPEDIDO(cant,precio,producto,pedido);
        id_LINEAPEDIDO := SEC_LINEAPEDIDOS.CURRVAL;
        /*Comprobar que se ha realizado con exito */
        SELECT IDPEDIDO3 INTO linea FROM LINEAPEDIDOS WHERE NUMLINE = id_LINEAPEDIDO;
        IF(linea<>pedido ) THEN
        salidain := FALSE;
        END IF;
        COMMIT WORK;
    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
        || ASSERT_EQUALS(salidain,salida_Esperada_in));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_in));
         ROLLBACK;
        END INSERTAR;

  /*Copiar y pegar el procedimiento borrar*/
    PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    num IN LINEAPEDIDOS.NUMLINE%TYPE,
    salida_esperada_el BOOLEAN
    )
AS salidael BOOLEAN := TRUE;
    numerolineas NUMBER;
BEGIN
    ELIMINA_LINEAPEDIDO(num);
    SELECT COUNT(*) INTO numerolineas FROM LINEAPEDIDOS 
    WHERE NUMLINE= num;
    IF(numerolineas <> 0) THEN
    salidael:= FALSE;
    END IF;
    COMMIT WORK;
    DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
        || ASSERT_EQUALS(salidael,salida_Esperada_el));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_el));
         ROLLBACK;
    END ELIMINAR;
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
    num IN LINEAPEDIDOS.NUMLINE%TYPE,
    cant IN LINEAPEDIDOS.CANTIDADPEDIDO%TYPE,
    precio IN LINEAPEDIDOS.PRECIO%TYPE,
    idProduc IN LINEAPEDIDOS.CODIGO_PROD1%TYPE,
    salida_esperada_up BOOLEAN
    )
AS salidaup BOOLEAN := TRUE;
    linea LINEAPEDIDOS.CODIGO_PROD1%TYPE;
    id_linea LINEAPEDIDOS.NUMLINE%TYPE;
BEGIN
        /*Llamada al procedimiento a probar*/
        UPDATE_LINEAPEDIDO(num,cant,precio,idProduc);
        id_linea := SEC_LINEAPEDIDOS.CURRVAL;
        /*Comprobar que se ha realizado con exito */
        SELECT CODIGO_PROD1 INTO linea FROM LINEAPEDIDOS WHERE NUMLINE = num;
        IF(idProduc <> linea ) THEN
        salidaup := FALSE;
        END IF;
        COMMIT WORK;


    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
        || ASSERT_EQUALS(salidaup,salida_Esperada_up));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_up));
         ROLLBACK;
        END ACTUALIZAR;

    end LINEAPEDIDOS_PRUEBA;
    /
 --------------------------------------------------------
-- Pruebas de PEDIDOS
--------------------------------------------------------
create or replace PACKAGE PEDIDOS_PRUEBA IS 
/*Creamos el procedimiento inicializar la cabecera*/

 Procedure INICIALIZAR;
 /*Creamos el procedimiento crear la cabecera*/
    /* Formato procedimientos: nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
    subtotal IN PEDIDOS.PRECIOTOTAL%TYPE,
    cliente IN PEDIDOS.IDCLIENTE1%TYPE,
    direccion IN PEDIDOS.ID_DIRECCION1%TYPE,
    salida_esperada_in BOOLEAN
    );
 /*Creamos el procedimiento borrar la cabecera*/
    /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    codigoborrar IN PEDIDOS.IDPEDIDO%TYPE,
    salida_esperada_el BOOLEAN
    );   
 /*Creamos el procedimiento actualizar la cabecera*/
 /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
    codigopedido IN PEDIDOS.IDPEDIDO%TYPE,
    fech IN PEDIDOS.FECHA%TYPE,
    subtotal IN PEDIDOS.PRECIOTOTAL%TYPE,
    cliente IN PEDIDOS.IDCLIENTE1%TYPE,
    direccion IN PEDIDOS.ID_DIRECCION1%TYPE,
    salida_esperada_up BOOLEAN
    );   

END PEDIDOS_PRUEBA;
/
create or replace PACKAGE BODY PEDIDOS_PRUEBA AS
 procedure INICIALIZAR is
 begin
  /*Se borran todas las tablas*/

 DELETE FROM PEDIDOS;
 end INICIALIZAR;

  /*Copiar y pegar el procedimiento crear*/

 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
    subtotal IN PEDIDOS.PRECIOTOTAL%TYPE,
    cliente IN PEDIDOS.IDCLIENTE1%TYPE,
    direccion IN PEDIDOS.ID_DIRECCION1%TYPE,
    salida_esperada_in BOOLEAN
    )
AS salidain BOOLEAN := TRUE;
    pedido PEDIDOS.IDPEDIDO%TYPE;
    id_PEDIDO PEDIDOS.IDPEDIDO%TYPE;
BEGIN
        /*Llamada al procedimiento a probar*/
        CREAR_PEDIDO(subtotal,cliente,direccion);
        id_PEDIDO := SEC_PEDIDO.CURRVAL;
        /*Comprobar que se ha realizado con exito */
        SELECT IDPEDIDO INTO pedido FROM PEDIDOS WHERE IDPEDIDO = id_PEDIDO;
        IF(id_PEDIDO<>pedido ) THEN
        salidain := FALSE;
        END IF;
        COMMIT WORK;
    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
        || ASSERT_EQUALS(salidain,salida_Esperada_in));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_in));
         ROLLBACK;
        END INSERTAR;

  /*Copiar y pegar el procedimiento borrar*/
    PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    codigoborrar IN PEDIDOS.IDPEDIDO%TYPE,
    salida_esperada_el BOOLEAN
    )
AS salidael BOOLEAN := TRUE;
    numeropedidos NUMBER;
BEGIN
    ELIMINA_PEDIDO(codigoborrar);
    SELECT COUNT(*) INTO numeropedidos FROM PEDIDOS 
    WHERE IDPEDIDO = codigoborrar;
    IF(numeropedidos <> 0) THEN
    salidael:= FALSE;
    END IF;
    COMMIT WORK;
    DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
        || ASSERT_EQUALS(salidael,salida_Esperada_el));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_el));
         ROLLBACK;
    END ELIMINAR;
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
    codigopedido IN PEDIDOS.IDPEDIDO%TYPE,
    fech IN PEDIDOS.FECHA%TYPE,
    subtotal IN PEDIDOS.PRECIOTOTAL%TYPE,
    cliente IN PEDIDOS.IDCLIENTE1%TYPE,
    direccion IN PEDIDOS.ID_DIRECCION1%TYPE,
    salida_esperada_up BOOLEAN
    )
AS salidaup BOOLEAN := TRUE;
    pedido PEDIDOS.IDPEDIDO%TYPE;
    id_pedido PEDIDOS.IDPEDIDO%TYPE;
BEGIN
        /*Llamada al procedimiento a probar*/
        UPDATE_PEDIDO(codigopedido,fech,subtotal,cliente,direccion);
        id_pedido := SEC_PEDIDO.CURRVAL;
        /*Comprobar que se ha realizado con exito */
        SELECT IDPEDIDO INTO pedido FROM PEDIDOS WHERE IDPEDIDO = id_pedido;
        IF(id_pedido <> pedido ) THEN
        salidaup := FALSE;
        END IF;
        COMMIT WORK;


    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
        || ASSERT_EQUALS(salidaup,salida_Esperada_up));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_up));
         ROLLBACK;
        END ACTUALIZAR;

    end PEDIDOS_PRUEBA;
/
--------------------------------------------------------
-- Pruebas de PRODUCTOS
--------------------------------------------------------
    create or replace PACKAGE PRODUCTOS_PRUEBA IS 
/*Creamos el procedimiento inicializar la cabecera*/

 Procedure INICIALIZAR;
 /*Creamos el procedimiento crear la cabecera*/
    /* Formato procedimientos: nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
    nombre IN productos.NOMBRE%TYPE,
    descripcion IN productos.DESCRIPCION%TYPE,
    tipoproducto IN productos.TIPOPRODUCTO%TYPE,
    disponibilidad IN productos.DISPONIBILIDAD%TYPE,
    precio IN productos.PRECIO%TYPE,
    urldocu IN productos.URLDOCU%TYPE,
    urlimg IN productos.URLIMG%TYPE,
    stock IN productos.STOCK%TYPE,
    partnumber IN productos.PARTNUMBER%TYPE,
    modelo IN productos.MODELO%TYPE,
    salida_esperada_in BOOLEAN
    );
 /*Creamos el procedimiento borrar la cabecera*/
    /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    codigoborrar IN productos.CODIGO%TYPE,
    salida_esperada_el BOOLEAN
    );   
 /*Creamos el procedimiento actualizar la cabecera*/
 /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
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
    modeloup IN productos.MODELO%TYPE,
    salida_esperada_up BOOLEAN
    );   

END PRODUCTOS_PRUEBA;
/
create or replace PACKAGE BODY PRODUCTOS_PRUEBA AS
 procedure INICIALIZAR is
 begin
  /*Se borran todas las tablas*/

 DELETE FROM PRODUCTOS;
 end INICIALIZAR;

  /*Copiar y pegar el procedimiento crear*/

 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
    nombre IN productos.NOMBRE%TYPE,
    descripcion IN productos.DESCRIPCION%TYPE,
    tipoproducto IN productos.TIPOPRODUCTO%TYPE,
    disponibilidad IN productos.DISPONIBILIDAD%TYPE,
    precio IN productos.PRECIO%TYPE,
    urldocu IN productos.URLDOCU%TYPE,
    urlimg IN productos.URLIMG%TYPE,
    stock IN productos.STOCK%TYPE,
    partnumber IN productos.PARTNUMBER%TYPE,
    modelo IN productos.MODELO%TYPE,
    salida_esperada_in BOOLEAN
    )
AS salidain BOOLEAN := TRUE;
    producto PRODUCTOS.CODIGO%TYPE;
    id_Producto PRODUCTOS.CODIGO%TYPE;
BEGIN
        /*Llamada al procedimiento a probar*/
        CREAR_PRODUCTO(nombre,descripcion,tipoproducto,disponibilidad,precio,urldocu,urlimg,stock,partnumber,modelo);
        id_Producto := SEC_Producto.CURRVAL;
        /*Comprobar que se ha realizado con exito */
        SELECT CODIGO INTO producto FROM PRODUCTOS WHERE CODIGO = id_Producto;
        IF(id_Producto<>producto ) THEN
        salidain := FALSE;
        END IF;
        COMMIT WORK;
    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
        || ASSERT_EQUALS(salidain,salida_Esperada_in));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_in));
         ROLLBACK;
        END INSERTAR;

  /*Copiar y pegar el procedimiento borrar*/
    PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    codigoborrar IN productos.CODIGO%TYPE,
    salida_esperada_el BOOLEAN
    )
AS salidael BOOLEAN := TRUE;
    numeroproductos NUMBER;
BEGIN
    ELIMINA_PRODUCTO(codigoborrar);
    SELECT COUNT(*) INTO numeroproductos FROM PRODUCTOS 
    WHERE CODIGO = codigoborrar;
    IF(numeroproductos <> 0) THEN
    salidael:= FALSE;
    END IF;
    COMMIT WORK;
    DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
        || ASSERT_EQUALS(salidael,salida_Esperada_el));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_el));
         ROLLBACK;
    END ELIMINAR;
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
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
    modeloup IN productos.MODELO%TYPE,
    salida_esperada_up BOOLEAN
    )
AS salidaup BOOLEAN := TRUE;
    producto PRODUCTOS.CODIGO %TYPE;
    id_producto PRODUCTOS.CODIGO%TYPE;
BEGIN
        /*Llamada al procedimiento a probar*/
        UPDATE_PRODUCTO(codigoup,nombreup,descripcionup,tipoproductoup,
        disponibilidadup,precioup, urldocuup,urlimgup,stockup,partnumberup,modeloup);
        id_producto := SEC_PRODUCTO.CURRVAL;
        /*Comprobar que se ha realizado con exito */
        SELECT CODIGO INTO producto FROM PRODUCTOS WHERE CODIGO = id_producto;
        IF(id_producto <> producto ) THEN
        salidaup := FALSE;
        END IF;
        COMMIT WORK;


    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
        || ASSERT_EQUALS(salidaup,salida_Esperada_up));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_up));
         ROLLBACK;
        END ACTUALIZAR;

    end PRODUCTOS_PRUEBA;
    /
--------------------------------------------------------
-- Pruebas de FACTURAS 
--------------------------------------------------------
create or replace PACKAGE FACTURAS_PRUEBA IS 
/*Creamos el procedimiento inicializar la cabecera*/

 Procedure INICIALIZAR;
 /*Creamos el procedimiento crear la cabecera*/
    /* Formato procedimientos: nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
    albaran IN FACTURAS.IDALBARAN1%TYPE,
    pago IN FACTURAS.TIPOFORMAPAGO%TYPE,
    salida_esperada_in BOOLEAN
    );
 /*Creamos el procedimiento borrar la cabecera*/
    /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    idborrar IN FACTURAS.IDFACTURA%TYPE,
    salida_esperada_el BOOLEAN
    );   
 /*Creamos el procedimiento actualizar la cabecera*/
 /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
    id_facturaup IN FACTURAS.IDFACTURA%TYPE,
    precio IN FACTURAS.PRECIOTOTAL%TYPE,
    pago IN FACTURAS.TIPOFORMAPAGO%TYPE,
    salida_esperada_up BOOLEAN
    );   

END FACTURAS_PRUEBA;
/
create or replace PACKAGE BODY FACTURAS_PRUEBA AS
 procedure INICIALIZAR is
 begin
  /*Se borran todas las tablas*/

 DELETE FROM FACTURAS;
 end INICIALIZAR;

  /*Copiar y pegar el procedimiento crear*/

 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
    albaran IN FACTURAS.IDALBARAN1%TYPE,
    pago IN FACTURAS.TIPOFORMAPAGO%TYPE,
    salida_esperada_in BOOLEAN
    )
AS salidain BOOLEAN := TRUE;
    factura FACTURAS.IDFACTURA%TYPE;
    id_factura FACTURAS.IDFACTURA%TYPE;
BEGIN
        /*Llamada al procedimiento a probar*/
        CREAR_FACTURA(albaran,pago);
        id_factura := SEC_FACTURA.CURRVAL;
        /*Comprobar que se ha realizado con exito */
        SELECT IDFACTURA INTO factura FROM FACTURAS WHERE IDFACTURA = id_factura;
        IF(id_factura<>factura ) THEN
        salidain := FALSE;
        END IF;
        COMMIT WORK;
    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
        || ASSERT_EQUALS(salidain,salida_Esperada_in));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_in));
         ROLLBACK;
        END INSERTAR;

  /*Copiar y pegar el procedimiento borrar*/
    PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    idborrar IN FACTURAS.IDFACTURA%TYPE,
    salida_esperada_el BOOLEAN
    )
AS salidael BOOLEAN := TRUE;
    numerofactura NUMBER;
BEGIN
    BORRAR_FACTURA(idborrar);
    SELECT COUNT(*) INTO numerofactura FROM FACTURAS 
    WHERE IDFACTURA = idborrar;
    IF(numerofactura <> 0) THEN
    salidael:= FALSE;
    END IF;
    COMMIT WORK;
    DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
        || ASSERT_EQUALS(salidael,salida_Esperada_el));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_el));
         ROLLBACK;
    END ELIMINAR;
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
    id_facturaup IN FACTURAS.IDFACTURA%TYPE,
    precio IN FACTURAS.PRECIOTOTAL%TYPE,
    pago IN FACTURAS.TIPOFORMAPAGO%TYPE,
    salida_esperada_up BOOLEAN
    )
AS salidaup BOOLEAN := TRUE;
    factura FACTURAS.IDFACTURA%TYPE;
    id_factura FACTURAS.IDFACTURA%TYPE;
BEGIN
        /*Llamada al procedimiento a probar*/
        UPDATE_FACTURA(id_facturaup,precio,pago);
        id_factura := SEC_FACTURA.CURRVAL;
        /*Comprobar que se ha realizado con exito */
        SELECT IDFACTURA INTO factura FROM FACTURAS WHERE IDFACTURA = id_facturaup;
        IF(id_factura <> factura ) THEN
        salidaup := FALSE;
        END IF;
        COMMIT WORK;


    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
        || ASSERT_EQUALS(salidaup,salida_Esperada_up));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_up));
         ROLLBACK;
        END ACTUALIZAR;

    end FACTURAS_PRUEBA;
/
--------------------------------------------------------
-- Pruebas de OFERTAS 
--------------------------------------------------------
create or replace PACKAGE OFERTAS_PRUEBA IS 
/*Creamos el procedimiento inicializar la cabecera*/

 Procedure INICIALIZAR;
 /*Creamos el procedimiento crear la cabecera*/
    /* Formato procedimientos: nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
    fechaini IN OFERTAS.FECHA_INICIO%TYPE,
    fechafin IN OFERTAS.FECHA_FIN%TYPE,
    precioDes IN OFERTAS.PRECIOOFERTADO%TYPE,
    codigoPro IN OFERTAS.CODIGO%TYPE,
    salida_esperada_in BOOLEAN
    );
 /*Creamos el procedimiento borrar la cabecera*/
    /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    id_ofertaborrar IN OFERTAS.CODIGO%TYPE,
    salida_esperada_el BOOLEAN
    );   
 /*Creamos el procedimiento actualizar la cabecera*/
 /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
    id_oferta IN OFERTAS.CODIGO%TYPE,
    fechaini IN OFERTAS.FECHA_INICIO%TYPE,
    fechafin IN OFERTAS.FECHA_FIN%TYPE,
    precioferta IN OFERTAS.PRECIOOFERTADO%TYPE,
    codigopro IN OFERTAS.CODIGO_PROD2 %TYPE,
    precioanterior IN OFERTAS.PRECIOANTES%TYPE,
    salida_esperada_up BOOLEAN
    );   

END OFERTAS_PRUEBA;
/
create or replace PACKAGE BODY OFERTAS_PRUEBA AS
 procedure INICIALIZAR is
 begin
  /*Se borran todas las tablas*/

 DELETE FROM OFERTAS;
 end INICIALIZAR;

  /*Copiar y pegar el procedimiento crear*/

 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
    fechaini IN OFERTAS.FECHA_INICIO%TYPE,
    fechafin IN OFERTAS.FECHA_FIN%TYPE,
    precioDes IN OFERTAS.PRECIOOFERTADO%TYPE,
    codigoPro IN OFERTAS.CODIGO%TYPE,
    salida_esperada_in BOOLEAN
    )
AS salidain BOOLEAN := TRUE;
    oferta OFERTAS.CODIGO%TYPE;
    id_oferta OFERTAS.CODIGO%TYPE;
BEGIN
        /*Llamada al procedimiento a probar*/
        CREAR_OFERTA(fechaini,fechafin,precioDes,codigoPro);
        id_oferta := SEC_OFERTA.CURRVAL;
        /*Comprobar que se ha realizado con exito */
        SELECT CODIGO INTO oferta FROM OFERTAS WHERE CODIGO = id_oferta;
        IF(id_oferta<>oferta ) THEN
        salidain := FALSE;
        END IF;
        COMMIT WORK;
    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
        || ASSERT_EQUALS(salidain,salida_Esperada_in));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_in));
         ROLLBACK;
        END INSERTAR;

  /*Copiar y pegar el procedimiento borrar*/
    PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    id_ofertaborrar IN OFERTAS.CODIGO%TYPE,
    salida_esperada_el BOOLEAN
    )
AS salidael BOOLEAN := TRUE;
    numeroferta NUMBER;
BEGIN
    ELIMINA_OFERTA(id_ofertaborrar);
    SELECT COUNT(*) INTO numeroferta FROM OFERTAS 
    WHERE CODIGO = id_ofertaborrar;
    IF(numeroferta <> 0) THEN
    salidael:= FALSE;
    END IF;
    COMMIT WORK;
    DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
        || ASSERT_EQUALS(salidael,salida_Esperada_el));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_el));
         ROLLBACK;
    END ELIMINAR;
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
    id_oferta IN OFERTAS.CODIGO%TYPE,
    fechaini IN OFERTAS.FECHA_INICIO%TYPE,
    fechafin IN OFERTAS.FECHA_FIN%TYPE,
    precioferta IN OFERTAS.PRECIOOFERTADO%TYPE,
    codigopro IN OFERTAS.CODIGO_PROD2 %TYPE,
    precioanterior IN OFERTAS.PRECIOANTES%TYPE,
    salida_esperada_up BOOLEAN
    )
AS salidaup BOOLEAN := TRUE;
    oferta OFERTAS.CODIGO%TYPE;
    idoferta OFERTAS.CODIGO%TYPE;
BEGIN
        /*Llamada al procedimiento a probar*/
        UPDATE_OFERTA(id_OFERTA,fechaini,fechafin,precioferta,codigopro,precioanterior);
        idoferta := SEC_OFERTA.CURRVAL;
        /*Comprobar que se ha realizado con exito */
        SELECT CODIGO INTO oferta FROM OFERTAS WHERE CODIGO = id_oferta;
        IF(idoferta <> oferta ) THEN
        salidaup := FALSE;
        END IF;
        COMMIT WORK;


    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
        || ASSERT_EQUALS(salidaup,salida_Esperada_up));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_up));
         ROLLBACK;
        END ACTUALIZAR;

    end OFERTAS_PRUEBA;
/
--------------------------------------------------------
-- Pruebas de ALBARANES 
--------------------------------------------------------

create or replace PACKAGE ALBARANES_PRUEBA IS 
/*Creamos el procedimiento inicializar la cabecera*/

 Procedure INICIALIZAR;
 /*Creamos el procedimiento crear la cabecera*/
    /* Formato procedimientos: nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
    id_pedido IN ALBARANES.IDPEDIDO2%TYPE,
    id_factura IN ALBARANES.IDFACTURA1%TYPE,
    salida_esperada_in BOOLEAN
    );
 /*Creamos el procedimiento borrar la cabecera*/
    /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    idborrar IN ALBARANES.IDALBARAN%TYPE,
    salida_esperada_el BOOLEAN
    );   
 /*Creamos el procedimiento actualizar la cabecera*/
 /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
    id_albaranup IN ALBARANES.IDALBARAN%TYPE,
    id_pedidoup IN ALBARANES.IDPEDIDO2%TYPE,
    id_facturaUP IN ALBARANES.IDFACTURA1%TYPE,
    salida_esperada_up BOOLEAN
    );   

END ALBARANES_PRUEBA;

/

create or replace PACKAGE BODY ALBARANES_PRUEBA AS
 procedure INICIALIZAR is
 begin
 DELETE FROM ALBARANES;
 end INICIALIZAR;


 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
    id_pedido IN ALBARANES.IDPEDIDO2%TYPE,
    id_factura IN ALBARANES.IDFACTURA1%TYPE,
    salida_esperada_in BOOLEAN
    )
AS salidain BOOLEAN := TRUE;
    id_albaran ALBARANES.IDALBARAN%TYPE;
    albaran ALBARANES.IDPEDIDO2%TYPE;
BEGIN
        CREAR_ALBARAN(id_pedido, id_factura);
        id_albaran := SEC_ALBARAN.CURRVAL;
        SELECT ALBARANES.IDPEDIDO2 INTO albaran FROM ALBARANES WHERE IDALBARAN = id_albaran;
        IF(albaran<>id_pedido ) THEN
        salidain := FALSE;
        END IF;
        COMMIT WORK;
    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
        || ASSERT_EQUALS(salidain,salida_Esperada_in));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_in));
         ROLLBACK;
        END INSERTAR;

  /*Copiar y pegar el procedimiento borrar*/
    PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    idborrar IN ALBARANES.IDALBARAN%TYPE,
    salida_esperada_el BOOLEAN
    )
AS salidael BOOLEAN := TRUE;
    numeroAlbaranes NUMBER;
BEGIN
    BORRAR_ALBARAN(idborrar);
    SELECT COUNT(*) INTO numeroAlbaranes FROM ALBARANES 
    WHERE IDALBARAN = idborrar;
    IF(numeroAlbaranes <> 0) THEN
    salidael:= FALSE;
    END IF;
    COMMIT WORK;
    DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
        || ASSERT_EQUALS(salidael,salida_Esperada_el));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_el));
         ROLLBACK;
    END ELIMINAR;
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
    id_albaranup IN ALBARANES.IDALBARAN%TYPE,
    id_pedidoup IN ALBARANES.IDPEDIDO2%TYPE,
    id_facturaUP IN ALBARANES.IDFACTURA1%TYPE,
    salida_Esperada_up BOOLEAN
    )
AS salidaup BOOLEAN := TRUE;
    id_albaran2 ALBARANES.IDALBARAN%TYPE;
    albaran ALBARANES.IDPEDIDO2%TYPE;

BEGIN
        /*Llamada al procedimiento a probar*/
        UPDATE_ALBARAN(id_albaranup, id_pedidoup, id_facturaUP);
        id_albaran2 := SEC_ALBARAN.CURRVAL;
        /*Comprobar que se ha realizado con exito */
        SELECT ALBARANES.IDPEDIDO2 INTO albaran FROM ALBARANES WHERE IDALBARAN = id_albaran2;
        IF(albaran <> id_pedidoup ) THEN
        salidaup := FALSE;
        END IF;
        COMMIT WORK;


    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
        || ASSERT_EQUALS(salidaup,salida_Esperada_up));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_up));
         ROLLBACK;
        END ACTUALIZAR;

    end ALBARANES_PRUEBA;
	
/
--------------------------------------------------------
-- Pruebas de DIRECCIONES 
--------------------------------------------------------

create or replace PACKAGE DIRECCIONES_PRUEBA IS 
/*Creamos el procedimiento inicializar la cabecera*/

 Procedure INICIALIZAR;
 /*Creamos el procedimiento crear la cabecera*/
    /* Formato procedimientos: nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
 	ciudad IN direcciones.CIUDAD%TYPE,
 	numero IN direcciones.NUMERO%TYPE,
 	cp IN direcciones.CP%TYPE,
 	calle IN direcciones.CALLE%TYPE,
    salida_esperada_in BOOLEAN
    );
 /*Creamos el procedimiento borrar la cabecera*/
    /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    id_direccionborrar IN DIRECCIONES.ID_DIRECCION%TYPE,
    salida_esperada_el BOOLEAN
    );   
 /*Creamos el procedimiento actualizar la cabecera*/
 /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
    id_direccionup IN DIRECCIONES.ID_DIRECCION%TYPE,
    ciudadup IN direcciones.CIUDAD%TYPE,
    cpup IN direcciones.CP%TYPE,
    calleup IN direcciones.CALLE%TYPE,
    numeroup IN direcciones.NUMERO%TYPE,
    salida_esperada_up BOOLEAN
    );   

END DIRECCIONES_PRUEBA;

/

create or replace PACKAGE BODY DIRECCIONES_PRUEBA AS
 procedure INICIALIZAR is
 begin
  /*Se borran todas las tablas*/

 DELETE FROM DIRECCIONES;
 end INICIALIZAR;

  /*Copiar y pegar el procedimiento crear*/

 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
 	ciudad IN direcciones.CIUDAD%TYPE,
 	numero IN direcciones.NUMERO%TYPE,
 	cp IN direcciones.CP%TYPE,
 	calle IN direcciones.CALLE%TYPE,
    salida_esperada_in BOOLEAN
    )
    
    
AS salidain BOOLEAN := TRUE;
    id_direccioni DIRECCIONES.ID_DIRECCION%TYPE;
    direccion DIRECCIONES.CALLE%TYPE;
BEGIN
        /*Llamada al procedimiento a probar*/
        NUEVA_DIRECCION(ciudad, numero, cp, calle);
        id_direccioni := SEC_DIRECCION.CURRVAL;
        /*Comprobar que se ha realizado con exito */
        SELECT DIRECCIONES.CALLE INTO direccion FROM DIRECCIONES WHERE ID_DIRECCION = id_direccioni;
        IF(direccion<>calle ) THEN
        salidain := FALSE;
        END IF;
        COMMIT WORK;
    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
        || ASSERT_EQUALS(salidain,salida_Esperada_in));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_in));
         ROLLBACK;
        END INSERTAR;

  /*Copiar y pegar el procedimiento borrar*/
    PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    id_direccionborrar IN DIRECCIONES.ID_DIRECCION%TYPE,
    salida_esperada_el BOOLEAN
    )
AS salidael BOOLEAN := TRUE;
    numeroDirecciones NUMBER;
BEGIN
    ELIMINA_DIRECCION(id_direccionborrar);
    SELECT COUNT(*) INTO numeroDirecciones FROM DIRECCIONES 
    WHERE ID_DIRECCION = id_direccionborrar;
    IF(numeroDirecciones <> 0) THEN
    salidael:= FALSE;
    END IF;
    COMMIT WORK;
    DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
        || ASSERT_EQUALS(salidael,salida_Esperada_el));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_el));
         ROLLBACK;
    END ELIMINAR;
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
    id_direccionup IN DIRECCIONES.ID_DIRECCION%TYPE,
    ciudadup IN direcciones.CIUDAD%TYPE,
    cpup IN direcciones.CP%TYPE,
    calleup IN direcciones.CALLE%TYPE,
    numeroup IN direcciones.NUMERO%TYPE,
    salida_esperada_up BOOLEAN
    )
AS salidaup BOOLEAN := TRUE;
    id_direccion DIRECCIONES.ID_DIRECCION%TYPE;
    direccion DIRECCIONES.CALLE%TYPE;
BEGIN
        /*Llamada al procedimiento a probar*/
        UPDATE_DIRECCION(id_direccionup,ciudadup,cpup,calleup,numeroup);
        id_direccion := SEC_DIRECCION.CURRVAL;
        /*Comprobar que se ha realizado con exito */
        SELECT DIRECCIONES.CALLE INTO direccion FROM DIRECCIONES WHERE ID_DIRECCION = id_direccion;
        IF(direccion <> calleup ) THEN
        salidaup := FALSE;
        END IF;
        COMMIT WORK;


    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
        || ASSERT_EQUALS(salidaup,salida_Esperada_up));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_up));
         ROLLBACK;
        END ACTUALIZAR;

    end DIRECCIONES_PRUEBA;

/
 --------------------------------------------------------
-- Pruebas de CLIENTES
--------------------------------------------------------
create or replace PACKAGE CLIENTES_PRUEBA IS 
/*Creamos el procedimiento inicializar la cabecera*/

 Procedure INICIALIZAR;
 /*Creamos el procedimiento crear la cabecera*/
    /* Formato procedimientos: nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
 	nombreCLI IN clientes.NOMBRE_CLI%TYPE,
 	appCLI IN clientes.APP_CLI%TYPE,
 	apmCLI IN clientes.apm_CLI%TYPE,
 	emailCLI IN clientes.EMAIL%TYPE,
 	dniCLI IN clientes.DNI%TYPE,
 	telefonoCLI IN clientes.telefono%TYPE,
 	IDDIRECCION IN clientes.ID_DIRECCION2%TYPE,
    salida_esperada_in BOOLEAN
    );
 /*Creamos el procedimiento borrar la cabecera*/
    /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    IDCLIENTEborrar IN CLIENTES.IDCLIENTE%TYPE,
    salida_esperada_el BOOLEAN
    );   
 /*Creamos el procedimiento actualizar la cabecera*/
 /* Formato procedimientos:
    nombre_procedimiento(numbre_prueba,valores_entrada,salida_esperada)*/
 PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
    idclienteUP IN CLIENTES.IDCLIENTE%TYPE,
 	nombreUP IN CLIENTES.NOMBRE_CLI%TYPE,
 	appUP IN CLIENTES.APP_CLI%TYPE,
 	apmUP IN CLIENTES.APM_CLI%TYPE,
 	emailUP IN CLIENTES.EMAIL%TYPE,
 	dniUP IN CLIENTES.DNI%TYPE,
 	telefonoUP IN CLIENTES.telefono%TYPE,
 	IDDIRECCIONUP IN CLIENTES.ID_DIRECCION2%TYPE,
    salida_esperada_up BOOLEAN
    );   

END CLIENTES_PRUEBA;

/

create or replace PACKAGE BODY CLIENTES_PRUEBA AS
 procedure INICIALIZAR is
 begin
  /*Se borran todas las tablas*/

 DELETE FROM CLIENTES;
 end INICIALIZAR;

  /*Copiar y pegar el procedimiento crear*/

 PROCEDURE INSERTAR (
    nombre_prueba_in VARCHAR2,
 	nombreCLI IN clientes.NOMBRE_CLI%TYPE,
 	appCLI IN clientes.APP_CLI%TYPE,
 	apmCLI IN clientes.apm_CLI%TYPE,
 	emailCLI IN clientes.EMAIL%TYPE,
 	dniCLI IN clientes.DNI%TYPE,
 	telefonoCLI IN clientes.telefono%TYPE,
 	IDDIRECCION IN clientes.ID_DIRECCION2%TYPE,
    salida_esperada_in BOOLEAN
    )
AS salidain BOOLEAN := TRUE;
    id_CLIENTE CLIENTES.IDCLIENTE%TYPE;
    CLIENTE CLIENTES.DNI%TYPE;
BEGIN
        /*Llamada al procedimiento a probar*/
        CREAR_CLIENTE(nombreCLI,appcli,apmCLI,emailCLI,dniCLI,telefonoCLI,IDDIRECCION);
        id_CLIENTE := SEC_CLIENTE.CURRVAL;
        /*Comprobar que se ha realizado con exito */
        SELECT CLIENTES.DNI INTO CLIENTE FROM CLIENTES WHERE IDCLIENTE = id_CLIENTE;
        IF(cliente<>dniCLI ) THEN
        salidain := FALSE;
        END IF;
        COMMIT WORK;
    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
        || ASSERT_EQUALS(salidain,salida_Esperada_in));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_in || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_in));
         ROLLBACK;
        END INSERTAR;

  /*Copiar y pegar el procedimiento borrar*/
    PROCEDURE ELIMINAR (
    nombre_prueba_el VARCHAR2,
    IDCLIENTEborrar IN CLIENTES.IDCLIENTE%TYPE,
    salida_esperada_el BOOLEAN
    )
AS salidael BOOLEAN := TRUE;
    numeroCLIENTES NUMBER;
BEGIN
    ELIMINAR_CLIENTE(IDCLIENTEborrar);
    SELECT COUNT(*) INTO numeroCLIENTES FROM CLIENTES 
    WHERE IDCLIENTE = IDCLIENTEborrar;
    IF(numeroCLIENTES <> 0) THEN
    salidael:= FALSE;
    END IF;
    COMMIT WORK;
    DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
        || ASSERT_EQUALS(salidael,salida_Esperada_el));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_el || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_el));
         ROLLBACK;
    END ELIMINAR;
  /*Copiar y pegar el procedimiento actualizar*/

  PROCEDURE ACTUALIZAR (
    nombre_prueba_up VARCHAR2,
    idclienteUP IN CLIENTES.IDCLIENTE%TYPE,
 	nombreUP IN clientes.NOMBRE_CLI%TYPE,
 	appUP IN clientes.APP_CLI%TYPE,
 	apmUP IN clientes.APM_CLI%TYPE,
 	emailUP IN clientes.EMAIL%TYPE,
 	dniUP IN clientes.DNI%TYPE,
 	telefonoUP IN clientes.telefono%TYPE,
 	IDDIRECCIONUP IN clientes.ID_DIRECCION2%TYPE,
    salida_esperada_up BOOLEAN
    )
AS salidaup BOOLEAN := TRUE;
    id_CLIENTE CLIENTES.IDCLIENTE%TYPE;
    CLIENTE CLIENTES.DNI%TYPE;
BEGIN
        /*Llamada al procedimiento a probar*/
        UPDATE_CLIENTE(idclienteUP, nombreUP,appUP,apmUP,emailUP,dniUP,telefonoUP,IDDIRECCIONUP);
        id_CLIENTE := SEC_CLIENTE.CURRVAL;
        /*Comprobar que se ha realizado con exito */
 SELECT CLIENTES.DNI INTO CLIENTE FROM CLIENTES WHERE IDCLIENTE = id_CLIENTE;
        IF(cliente<>dniUP ) THEN
        salidaup := FALSE;
        END IF;
        COMMIT WORK;


    /*Mostrar resultados de la prueba*/
        DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
        || ASSERT_EQUALS(salidaup,salida_Esperada_up));

        EXCEPTION
        WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE(nombre_prueba_up || ': ' 
         || ASSERT_EQUALS(false,salida_Esperada_up));
         ROLLBACK;
        END ACTUALIZAR;

    end CLIENTES_PRUEBA;
	
/

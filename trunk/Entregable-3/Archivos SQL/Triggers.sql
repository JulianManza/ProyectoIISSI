--Triggers Reglas de negocio

--Trigger RN01
 CREATE OR REPLACE TRIGGER datosCliente
    BEFORE DELETE ON CLIENTES
    FOR EACH ROW
    DECLARE
        estado VARCHAR(20);
        BEGIN
            SELECT  ESTADOPEDIDO INTO estado FROM ESTADOPEDIDOS WHERE ESTADOPEDIDO != 'Enviado';
            IF(estado != 'Enviado')
                THEN Raise_application_error(-20600,'No se puede eliminar un cliente, tiene pedidos pendientes.');
    END IF;
    END;
/
--Trigger RN02
 create or replace TRIGGER horaPedido
    BEFORE INSERT ON PEDIDOS
    FOR EACH ROW
    DECLARE 
		prueba VARCHAR2(10);
		horaMax VARCHAR2(50):= '17:00';
	BEGIN
		select to_char(sysdate, 'HH24:MI') into prueba  from dual;
		if prueba<=horaMax then
			UPDATE ESTADOPEDIDOS
            SET ESTADOPEDIDO = 'En proceso';
		ELSE
			UPDATE ESTADOPEDIDOS
            SET ESTADOPEDIDO = 'En espera';
	END IF;
END;
/
 --Trigger RN03
create or replace TRIGGER COMPRUEBAPAGO
     BEFORE UPDATE ON ESTADOPEDIDOS
     FOR EACH ROW
    BEGIN
    IF (:NEW.ESTADOPEDIDO = 'En proceso')
    THEN IF (:OLD.ESTADOPEDIDO = 'Pendiente de pago')
    THEN Raise_application_error(-20600,'No se puede procesar un pedido pendiente de pago');
    END IF;
    END IF;
 END;
/
 --Trigger RN04
create or replace TRIGGER envioPedido
    BEFORE UPDATE ON ESTADOPEDIDOS
        FOR EACH ROW
    BEGIN
    IF (:NEW.ESTADOPEDIDO = 'Enviado')
    THEN IF (:OLD.ESTADOPEDIDO = 'Pendiente de Pago')
    THEN Raise_application_error(-20600,'No se puede enviar un pedido pendiente de pago');
    END IF;
    END IF;
 END;
/
 --Triggers asociados a las secuencias
 CREATE OR REPLACE TRIGGER crea_ID_almacen
  BEFORE INSERT ON ALMACENES
  FOR EACH ROW
  BEGIN
  SELECT sec_albaran.NEXTVAL INTO :NEW.IDALMACEN FROM DUAL;
  END;
  /

 CREATE OR REPLACE TRIGGER crea_ID_cliente
  BEFORE INSERT ON CLIENTES
  FOR EACH ROW
  BEGIN
  SELECT sec_cliente.NEXTVAL INTO :NEW.IDCLIENTE FROM DUAL;
  END;
/
CREATE OR REPLACE TRIGGER crea_ID_producto
  BEFORE INSERT ON PRODUCTOS
  FOR EACH ROW
  BEGIN
  SELECT sec_producto.NEXTVAL INTO :NEW.CODIGO FROM DUAL;
  END;
/
CREATE OR REPLACE TRIGGER crea_ID_pedido
  BEFORE INSERT ON PEDIDOS
  FOR EACH ROW
  BEGIN
  SELECT sec_pedido.NEXTVAL INTO :NEW.IDPEDIDO FROM DUAL;
  END;
/
CREATE OR REPLACE TRIGGER crea_ID_albaran
  BEFORE INSERT ON ALBARANES
  FOR EACH ROW
  BEGIN
  SELECT sec_albaran.NEXTVAL INTO :NEW.IDALBARAN FROM DUAL;
  END;
/
  CREATE OR REPLACE TRIGGER crea_LINEAPEDIDOS
  BEFORE INSERT ON LINEAPEDIDOS
  FOR EACH ROW
  BEGIN
  SELECT sec_LINEAPEDIDOS.NEXTVAL INTO :NEW.numline FROM DUAL;
  END;
/
CREATE OR REPLACE TRIGGER crea_ID_factura
  BEFORE INSERT ON FACTURAS
  FOR EACH ROW
  BEGIN
  SELECT sec_factura.NEXTVAL INTO :NEW.IDFACTURA FROM DUAL;
  END;
/
CREATE OR REPLACE TRIGGER crea_ID_oferta
  BEFORE INSERT ON OFERTAS
  FOR EACH ROW
  BEGIN
  SELECT sec_oferta.NEXTVAL INTO :NEW.CODIGO FROM DUAL;
  END;
/
CREATE OR REPLACE TRIGGER crea_ID_direccion
  BEFORE INSERT ON DIRECCIONES
  FOR EACH ROW
  BEGIN
  SELECT sec_direccion.NEXTVAL INTO :NEW.ID_DIRECCION FROM DUAL;
  END;
/
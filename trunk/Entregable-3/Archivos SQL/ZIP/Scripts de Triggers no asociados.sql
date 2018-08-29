--Triggers no Asociados

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
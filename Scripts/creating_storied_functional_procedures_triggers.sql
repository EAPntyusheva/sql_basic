--Первая триггерная функция проверяет правильность введенных данных
--в поле sex в таблице user_pool.
CREATE FUNCTION user_pool_stamp() RETURNS trigger AS
$user_pool_stamp$
    BEGIN
        -- Проверить, что указаны имя сотрудника и зарплата
        IF NEW.sex <> 'Муж' AND NEW.sex <> 'Жен' THEN
        RAISE EXCEPTION '% cannot have another gender than (Муж/Жен)', NEW.sex;
        end if;
        RETURN NEW;
    END;
$user_pool_stamp$ LANGUAGE plpgsql;

CREATE TRIGGER user_pool_stamp BEFORE INSERT OR UPDATE ON user_pool
    FOR EACH ROW EXECUTE PROCEDURE user_pool_stamp();

-- Вторая тригерная функция отслеживает все действия, произведенные над таблицей
-- user_pool и записывает характер действий (удаление,обновление, создание),
-- id пользователя, над которым производились действия и время изменения.
CREATE OR REPLACE FUNCTION process_user_pool_audit() RETURNS
TRIGGER AS $user_pool_audit$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO user_pool_audit SELECT 'D', OLD.id_user,
now();
            RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO user_pool_audit SELECT 'U', OLD.id_user,
now();
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO user_pool_audit SELECT 'I', NEW.id_user,
now();
            RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$user_pool_audit$ LANGUAGE plpgsql;

CREATE TRIGGER user_pool_audit
AFTER INSERT OR UPDATE OR DELETE ON user_pool
    FOR EACH ROW EXECUTE PROCEDURE process_user_pool_audit();
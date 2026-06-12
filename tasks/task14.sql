/*
При помощи таблицы и набора функций реализуйте структуру представления данных 
неограниченное по длине множество. Структура должна позволять сохранять во множество 
строки, длиной не более 64 символов. Должны быть доступны следующие действия: a. 
add(строка) – добавление элемента (строка) в список элементов множества – результат функции –
сам элемент, или null, если такой элемент уже был; b. 
delete(строка) – удаление элемента из множества – результат функции – сам элемент или null, 
если такого элемента нет; 
c. 
empty() – очистка множества – результат функции – число удаленных элементов; d. 
init() – инициализация множества – создает все необходимые таблицы, удаляет старые (если 
множество уже создавалось ранее), обнуляет последовательности – результат – null; 
Функции никогда не приводят к ошибкам! Напишите пример работы с множеством.
*/
CREATE OR REPLACE FUNCTION init()
RETURNS integer AS $$
BEGIN
    DROP TABLE IF EXISTS string_set CASCADE;

    CREATE TABLE string_set (
        value varchar(64) PRIMARY KEY
    );
    RETURN NULL;
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION add(str text)
RETURNS varchar(64) AS $$
BEGIN
	IF str IS NULL OR length(str) > 64 THEN
	    RETURN NULL;
	END IF;
    IF EXISTS (SELECT value FROM string_set WHERE value = str) THEN
        RETURN NULL;
    END IF;    
    INSERT INTO string_set(value) VALUES (str);
    RETURN str;
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION delete(str text)
RETURNS varchar(64) AS $$
BEGIN
	IF str IS NULL OR length(str) > 64 THEN
    	RETURN NULL;
	END IF;
    IF NOT EXISTS (SELECT value FROM string_set WHERE value = str) THEN
        RETURN NULL;
    END IF;    
    DELETE FROM string_set WHERE value = str;
    RETURN str;
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION empty()
RETURNS integer AS $$
DECLARE
    cnt integer;
BEGIN
    SELECT COUNT(*) INTO cnt FROM string_set;
    DELETE FROM string_set;
    RETURN cnt;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END;
$$ LANGUAGE plpgsql;

SELECT init();

SELECT add(NULL);    
SELECT add('banana');   
SELECT add('banana');
SELECT add('cherry');  
SELECT add('apple');    

SELECT * FROM string_set;

SELECT delete('banana');  
SELECT delete('banana');  
SELECT delete('orange');  

SELECT empty();  
SELECT empty(); 
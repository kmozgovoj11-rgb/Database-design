/*
По указанной части названия блюда, возвращает количество блюд, содержащих в названии 
данную подстроку. Результат – целое число.
*/
CREATE OR REPLACE FUNCTION count_dishes_by_substring(substr text)
RETURNS integer AS $$
DECLARE
    dish_count integer;
BEGIN
    SELECT COUNT(*) INTO dish_count
    FROM dishes
    WHERE name ILIKE '%' || substr || '%';  
    RETURN dish_count;
END;
$$ LANGUAGE plpgsql;

SELECT count_dishes_by_substring('QQ');
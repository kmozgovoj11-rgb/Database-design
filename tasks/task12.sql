/*
Для множества идентификаторов блюд, сформировать массив названий ингредиентов, 
используемых для их приготовления (в виде одной строки через запятую без повторений). 
Обратите внимание! Требуется агрегатная функция. Никаких массивов в аргументах функции (в 
теле функции массивы могут быть).
*/
--DROP AGGREGATE IF EXISTS aggregate_ingredients(integer) CASCADE;
--DROP FUNCTION IF EXISTS accumulate_ingredients(text[], integer);
--DROP FUNCTION IF EXISTS finalize_ingredients(text[]);
CREATE OR REPLACE FUNCTION accumulate_ingredients(state text[], current_dish_id integer)
RETURNS text[] AS $$
DECLARE
    new_ingredients text[];
BEGIN
    SELECT ARRAY_AGG(i.name ORDER BY i.name)
    INTO new_ingredients
    FROM dishes_and_ingredients di
    JOIN ingredients i ON di.ingredient_id = i.ingredient_id
    WHERE di.dish_id = current_dish_id;
    
    RETURN state || new_ingredients;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION finalize_ingredients(state text[])
RETURNS text AS $$
BEGIN
    RETURN (
        SELECT STRING_AGG(DISTINCT ingredient_name, ', ' ORDER BY ingredient_name)
        FROM UNNEST(state) AS ingredient_name
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE AGGREGATE aggregate_ingredients(integer) (
    INITCOND = '{}',
    SFUNC = accumulate_ingredients,
    STYPE = text[],
    FINALFUNC = finalize_ingredients
);

SELECT aggregate_ingredients(dish_id)
FROM dishes ;

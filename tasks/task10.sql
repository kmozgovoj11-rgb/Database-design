/*
Добавить Триггер(ы) не позволяет добавлять в один раздел более 50 блюд и в одно блюдо более 50 
ингредиентов.
*/
BEGIN
CREATE OR REPLACE FUNCTION check_dish_number()
RETURNS TRIGGER AS $$
DECLARE
dish_count integer;
BEGIN
	SELECT COUNT(*) INTO dish_count
	FROM dish_categories_and_dishes d
	WHERE d.category_id = NEW.category_id;
	IF dish_count >= 50 THEN
		RAISE EXCEPTION 'В категорию нельзя добавить более 50 блюд.';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_dish_number_trigger
BEFORE INSERT OR UPDATE ON dish_categories_and_dishes
FOR EACH ROW
EXECUTE FUNCTION check_dish_number();

SELECT * FROM dish_categories_and_dishes ORDER BY category_id;

INSERT INTO dish_categories_and_dishes (category_id, dish_id)
VALUES (4, 3);--+

UPDATE dish_categories_and_dishes
SET category_id = 2
WHERE category_id = 4
  AND dish_id = 3;--+


INSERT INTO dish_categories_and_dishes (category_id, dish_id)
VALUES (6, 3);
UPDATE dish_categories_and_dishes
SET category_id = 6
WHERE category_id = 4
  AND dish_id = 2;
ROLLBACK;

BEGIN
CREATE OR REPLACE FUNCTION check_ingredient_number()
RETURNS TRIGGER AS $$
DECLARE
    ingredient_count integer;
BEGIN
    SELECT COUNT(*) INTO ingredient_count
    FROM dishes_and_ingredients
    WHERE dish_id = NEW.dish_id;
    
    IF ingredient_count >= 50 THEN
        RAISE EXCEPTION 'В блюдо нельзя добавить более 50 ингредиентов.';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_ingredient_number_trigger
BEFORE INSERT OR UPDATE ON dishes_and_ingredients
FOR EACH ROW
EXECUTE FUNCTION check_ingredient_number();

INSERT INTO dishes_and_ingredients (dish_id, ingredient_id, quantity, standart_unit_id)
VALUES (3, 1, 10.00, 1);
UPDATE dishes_and_ingredients
SET dish_id = 4
WHERE dish_id = 3
  AND ingredient_id = 1;


INSERT INTO dishes_and_ingredients (dish_id, ingredient_id, quantity, standart_unit_id)
VALUES (55, 1, 10.00, 1);
UPDATE dishes_and_ingredients
SET dish_id = 55
WHERE dish_id = 7
  AND ingredient_id = 6;
ROLLBACK
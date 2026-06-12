/*
Создайте представление, отображающее названия блюд, ключевые поля таблицы блюда, 
подробную инструкцию их приготовления и названия ингридиентов. Реализуйте возможность 
изменения инструкции через это представление в реальной таблице.
*/
BEGIN
CREATE OR REPLACE VIEW dishes_with_ingredients AS
SELECT 
    d.dish_id,
    d.name AS dish_name,
    d.instructions,
    STRING_AGG(i.name, ', ') AS ingredients
FROM dishes d
JOIN dishes_and_ingredients di ON d.dish_id = di.dish_id
JOIN ingredients i ON di.ingredient_id = i.ingredient_id
GROUP BY d.dish_id, d.name, d.instructions;

CREATE OR REPLACE FUNCTION update_instructions()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE dishes
    SET instructions = NEW.instructions
    WHERE dish_id = OLD.dish_id;   
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER update_instructions_trigger
INSTEAD OF UPDATE ON dishes_with_ingredients
FOR EACH ROW
EXECUTE FUNCTION update_instructions();

UPDATE dishes_with_ingredients
SET instructions = 'Новая инструкция: Взбить яйца с сахаром, добавить муку. Выпекать 35 минут при 180°C.'
WHERE dish_id = 1;
SELECT * FROM dishes WHERE dish_id = 1;
ROLLBACK

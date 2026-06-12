/*
Удалите из всех блюд, включающих ингредиент с названием «оливковое
масло», ингредиент с названием «подсолнечное масло».
*/
BEGIN;

INSERT INTO ingredients (description, name) VALUES
('Рафинированное масло для жарки', 'Подсолнечное масло');
INSERT INTO dishes_and_ingredients (dish_id, ingredient_id, quantity, standart_unit_id)
VALUES (2, 13, 20.00, 1);

DELETE FROM dishes_and_ingredients
WHERE ingredient_id = (SELECT ingredient_id FROM ingredients WHERE name = 'Подсолнечное масло')
  AND dish_id IN (
      SELECT di.dish_id
      FROM dishes_and_ingredients di
      JOIN ingredients i USING(ingredient_id)
      WHERE i.name = 'Оливковое масло'
  );

SELECT * FROM dishes_and_ingredients ORDER BY dish_id;

ROLLBACK;
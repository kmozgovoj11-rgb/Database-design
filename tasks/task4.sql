/*
Выберите самое тяжёлое по суммарной массе блюдо (только название).
*/
WITH dish_weight AS (
    SELECT 
        d.dish_id,
        d.name,
        SUM(
            CASE 
                WHEN di.standart_unit_id = 1 THEN di.quantity
                WHEN di.standart_unit_id = 2 THEN di.quantity
                WHEN di.standart_unit_id = 3 AND i.name = 'Яйцо' THEN di.quantity * 50
            END
        ) AS total_grams
    FROM dishes d
    JOIN dishes_and_ingredients di ON d.dish_id = di.dish_id
    JOIN ingredients i ON di.ingredient_id = i.ingredient_id 
    GROUP BY d.dish_id, d.name
)
SELECT name
FROM dish_weight
WHERE total_grams = (SELECT MAX(total_grams) FROM dish_weight);
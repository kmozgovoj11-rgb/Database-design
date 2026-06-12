/* 
Выберите самый широко используемый ингредиент (или ингредиенты, если 
их несколько). Ингредиент будем считать самым широко используемым, 
если его включает большее число блюд. Выбрать нужно только название 
ингредиента.
*/
SELECT 
    i.name,
    COUNT(di.dish_id) AS dish_count
FROM ingredients i
JOIN dishes_and_ingredients di ON i.ingredient_id = di.ingredient_id
GROUP BY i.ingredient_id, i.name
HAVING COUNT(di.dish_id) = (
    SELECT MAX(dish_count)
    FROM (
        SELECT COUNT(dish_id) AS dish_count
        FROM dishes_and_ingredients
        GROUP BY ingredient_id
    ) AS counts
);
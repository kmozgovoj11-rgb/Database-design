/*
Выберите все блюда (только названия), состоящие только из муки, яиц и сахара
*/
SELECT d.name
FROM dishes d
JOIN dishes_and_ingredients di ON d.dish_id = di.dish_id
JOIN ingredients i ON di.ingredient_id = i.ingredient_id
GROUP BY d.name
HAVING SUM(CASE WHEN i.name NOT IN ('Мука', 'Яйцо', 'Сахар') THEN 1 ELSE 0 END) = 0
   AND COUNT(DISTINCT i.name) = 3;

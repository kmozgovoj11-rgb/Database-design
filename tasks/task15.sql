/*
Создать оконную функцию. Запрос, выбирающий без повторений название блюда, название ингридиента, количество 
вхождений данного ингридиента во всех рецептах, количество ингридиентов в данном блюде. 
*/
SELECT 
 d.name AS dish_name, 
 i.name AS ingredient_name, 
 COUNT(*) OVER (PARTITION BY i.ingredient_id) AS ingredient_count_in_recipes, 
 COUNT(*) OVER (PARTITION BY d.dish_id) AS ingredient_count_in_dish 
FROM dishes d 
JOIN dishes_and_ingredients di USING(dish_id) 
JOIN ingredients i USING(ingredient_id) ORDER BY d.name;
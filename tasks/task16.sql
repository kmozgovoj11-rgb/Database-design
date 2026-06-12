/*
Запрос, выбирающий название категории блюд и в виде одного столбца через запятую все 
названия блюд в обратном алфавитном порядке, которые бывают в данной категории.
*/ 
SELECT dc.name 
AS category_name, 
 STRING_AGG(d.name, ', ' ORDER BY d.name DESC) AS dishes 
FROM dish_categories dc 
JOIN dish_categories_and_dishes dcd USING(category_id) 
JOIN dishes d USING(dish_id) 
GROUP BY dc.name 
ORDER BY dc.name;
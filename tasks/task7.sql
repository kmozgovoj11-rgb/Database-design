/*
У всех привязанных к блюдам ингредиентов с указанной единицей
измерения «чайная ложка» замените единицу измерения на «грамм», а
количество чайных ложек пересчитайте и замените на количество грамм, 
исходя из расчёта 1 ложка = 8 грамм
*/
BEGIN;

UPDATE dishes_and_ingredients
SET 
    standart_unit_id = (SELECT standart_unit_id FROM standart_units WHERE standart_unit_name = 'грамм'),
    quantity = quantity * 8
WHERE standart_unit_id = (SELECT standart_unit_id FROM standart_units WHERE standart_unit_name = 'чайная ложка')
RETURNING *;

ROLLBACK;
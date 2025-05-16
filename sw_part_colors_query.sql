duckdb lego_sw_part_colors.db;

-- This query retrieves the total quantity of each color used in sets, grouped by theme and color.
-- It also assigns a unique ID to each row based on the order of theme name and total quantity.
-- The results are ordered by theme name and total quantity in descending order.

SELECT 
    ROW_NUMBER() OVER (ORDER BY t.name, SUM(ip.quantity) DESC) AS unique_id,
    t.name AS theme_name,
    c.name AS color_name,
    c.rgb AS color_hex,
    SUM(ip.quantity) AS total_quantity
FROM themes t
JOIN sets s 
    ON t.id = s.theme_id
JOIN inventories i 
    ON s.set_num = i.set_num
JOIN inventory_parts ip 
    ON i.id = ip.inventory_id
JOIN colors c 
    ON ip.color_id = c.id
    WHERE c.is_trans = 'f'
GROUP BY t.name, c.name, c.rgb
ORDER BY theme_name, total_quantity DESC;


.exit
create or replace function t8_get_data
return t8_rec_tbl pipelined
as
temp_res t8_rec := t8_rec('title',0,0,0,0,0,0,0);
begin
for row in (
select * from (
SELECT 'Зима' AS "SEASON", 1+trunc(DATE_)-trunc(DATE_,'IW') DAY_OF_WEEK, SUM(VALUE_) TOTAL_DAY_USAGE
FROM t8_power_consumption WHERE EXTRACT(MONTH FROM DATE_) IN (12, 1, 2)
GROUP BY DATE_
UNION
SELECT 'Весна' AS "SEASON", 1+trunc(DATE_)-trunc(DATE_,'IW') DAY_OF_WEEK, SUM(VALUE_) TOTAL_DAY_USAGE
FROM t8_power_consumption WHERE EXTRACT(MONTH FROM DATE_) IN (3, 4, 5)
GROUP BY DATE_
UNION
SELECT 'Лето' AS "SEASON", 1+trunc(DATE_)-trunc(DATE_,'IW') DAY_OF_WEEK, SUM(VALUE_) TOTAL_DAY_USAGE
FROM t8_power_consumption WHERE EXTRACT(MONTH FROM DATE_) IN (6, 7, 8)
GROUP BY DATE_
UNION
SELECT 'Осень' AS "SEASON", 1+trunc(DATE_)-trunc(DATE_,'IW') DAY_OF_WEEK, SUM(VALUE_) TOTAL_DAY_USAGE
FROM t8_power_consumption WHERE EXTRACT(MONTH FROM DATE_) IN (9, 10, 11)
GROUP BY DATE_
    )
    PIVOT (
        AVG(TOTAL_DAY_USAGE)
        FOR DAY_OF_WEEK IN (1, 2, 3, 4, 5, 6, 7)
    )) loop
        temp_res.title := row.SEASON;
        temp_res.d1 := round(row."1", 2);
        temp_res.d2 := round(row."2", 2);
        temp_res.d3 := round(row."3", 2);
        temp_res.d4 := round(row."4", 2);
        temp_res.d5 := round(row."5", 2);
        temp_res.d6 := round(row."6", 2);
        temp_res.d7 := round(row."7", 2);
        pipe row(temp_res);
    end loop;

end;

-- Декларативный запрос (если спросит, в функции удобнее обработать все было просто)

select * from (
SELECT 'Зима' AS "SEASON", 1+trunc(DATE_)-trunc(DATE_,'IW') DAY_OF_WEEK, SUM(VALUE_) TOTAL_DAY_USAGE
FROM t8_power_consumption WHERE EXTRACT(MONTH FROM DATE_) IN (12, 1, 2)
GROUP BY DATE_
UNION
SELECT 'Весна' AS "SEASON", 1+trunc(DATE_)-trunc(DATE_,'IW') DAY_OF_WEEK, SUM(VALUE_) TOTAL_DAY_USAGE
FROM t8_power_consumption WHERE EXTRACT(MONTH FROM DATE_) IN (3, 4, 5)
GROUP BY DATE_
UNION
SELECT 'Лето' AS "SEASON", 1+trunc(DATE_)-trunc(DATE_,'IW') DAY_OF_WEEK, SUM(VALUE_) TOTAL_DAY_USAGE
FROM t8_power_consumption WHERE EXTRACT(MONTH FROM DATE_) IN (6, 7, 8)
GROUP BY DATE_
UNION
SELECT 'Осень' AS "SEASON", 1+trunc(DATE_)-trunc(DATE_,'IW') DAY_OF_WEEK, SUM(VALUE_) TOTAL_DAY_USAGE
FROM t8_power_consumption WHERE EXTRACT(MONTH FROM DATE_) IN (9, 10, 11)
GROUP BY DATE_
    )
    PIVOT (
        AVG(TOTAL_DAY_USAGE)
        FOR DAY_OF_WEEK IN (1, 2, 3, 4, 5, 6, 7)
    )
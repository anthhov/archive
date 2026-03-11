create or replace function t9_sum_two_t9_recs (a t9_rec, b t9_rec) return t9_rec
is
dummy t9_rec := t9_rec('title',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
begin
                dummy.title := a.title;
                dummy.h1 := a.h1 + b.h1;
                dummy.h2 := a.h2 +  b.h2;
                dummy.h3 := a.h3 +  b.h3;
                dummy.h4 := a.h4 +  b.h4;
                dummy.h5 := a.h5 +  b.h5;
                dummy.h6 := a.h6 +  b.h6;
                dummy.h7 := a.h7 +  b.h7;
                dummy.h8 := a.h8 +  b.h8;
                dummy.h9 := a.h9 +  b.h9;
                dummy.h10 := a.h10 +  b.h10;
                dummy.h11 := a.h11 +  b.h11;
                dummy.h12 := a.h12 +  b.h12;
                dummy.h13 := a.h13 +  b.h13;
                dummy.h14 := a.h14 +  b.h14;
                dummy.h15 := a.h15 +  b.h15;
                dummy.h16 := a.h16 +  b.h16;
                dummy.h17 := a.h17 +  b.h17;
                dummy.h18 := a.h18 +  b.h18;
                dummy.h19 := a.h19 +  b.h19;
                dummy.h20 := a.h20 +  b.h20;
                dummy.h21 := a.h21 +  b.h21;
                dummy.h22 := a.h22 +  b.h22;
                dummy.h23 := a.h23 +  b.h23;
                dummy.h24 := a.h24 +  b.h24;
                dummy.htotal := a.htotal +  b.htotal;
                return dummy;
end;

--

create or replace function t9_get_data return t9_temp_t pipelined
as
quarter_cnt number default 0;
quarter_total t9_rec := t9_rec('title', 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
year_total t9_rec := t9_rec('title',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
total t9_rec := t9_rec('Итого за 2 года',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
begin

    for curr_year IN (SELECT column_value FROM table(sys.dbms_debug_vc2coll(2009, 2010))) LOOP

        quarter_cnt := 0;
        year_total := t9_rec('Итого за ' || curr_year.column_value, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);

        for offset IN (SELECT column_value FROM table(sys.dbms_debug_vc2coll(1, 4, 7, 10))) LOOP

            for row in (select * from (
                select * from (
                    select hour, sum(value_) val from t8_power_consumption
                    where extract(year from date_) = curr_year.column_value and extract(month from date_) in (offset.column_value, offset.column_value+1, offset.column_value+2)
                    group by hour order by hour asc
                )
                pivot(
                    sum(val)
                    for hour in (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24)
                ))) loop
                quarter_total.title := 'Квартал ' || (quarter_cnt + 1);
                quarter_total.h1 := row."1";
                quarter_total.h2 := row."2";
                quarter_total.h3 := row."3";
                quarter_total.h4 := row."4";
                quarter_total.h5 := row."5";
                quarter_total.h6 := row."6";
                quarter_total.h7 := row."7";
                quarter_total.h8 := row."8";
                quarter_total.h9 := row."9";
                quarter_total.h10 := row."10";
                quarter_total.h11 := row."11";
                quarter_total.h12 := row."12";
                quarter_total.h13 := row."13";
                quarter_total.h14 := row."14";
                quarter_total.h15 := row."15";
                quarter_total.h16 := row."16";
                quarter_total.h17 := row."17";
                quarter_total.h18 := row."18";
                quarter_total.h19 := row."19";
                quarter_total.h20 := row."20";
                quarter_total.h21 := row."21";
                quarter_total.h22 := row."22";
                quarter_total.h23 := row."23";
                quarter_total.h24 := row."24";
                quarter_total.htotal := row."1" + row."2" + row."3" + row."4" + row."5" + row."6" + row."7" + row."8" + row."9" + row."10" + row."11" + row."12" + row."13" + row."14" + row."15"
                 + row."16" + row."17" + row."18" + row."19" + row."20" + row."21" + row."22" + row."23" + row."24";
            end loop;

            quarter_cnt := quarter_cnt + 1;
            pipe row(quarter_total);

            year_total := t9_sum_two_t9_recs(year_total, quarter_total);
        end loop;

        pipe row(year_total);

        total := t9_sum_two_t9_recs(total, year_total);
    end loop;
    pipe row(total);
end;

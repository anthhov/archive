CREATE OR REPLACE EDITIONABLE TYPE  "T8_REC" as object (
    title varchar(255),
    d1 number, d2 number, d3 number, d4 number,
    d5 number, d6 number, d7 number)

CREATE OR REPLACE EDITIONABLE TYPE  "T8_REC_TBL" is table of T8_REC

--

CREATE OR REPLACE EDITIONABLE TYPE  "T9_REC" as object (
    title varchar(255),
    h1 decimal, h2 decimal, h3 decimal, h4 decimal,
    h5 decimal, h6 decimal, h7 decimal, h8 decimal,
    h9 decimal, h10 decimal, h11 decimal, h12 decimal,
    h13 decimal, h14 decimal, h15 decimal, h16 decimal,
    h17 decimal, h18 decimal, h19 decimal, h20 decimal,
    h21 decimal, h22 decimal, h23 decimal, h24 decimal,
    htotal decimal)

CREATE OR REPLACE EDITIONABLE TYPE  "T9_TEMP_T" is table of t9_rec

--------------------------------------------------------------------------------------
--ASM01
4.
SELECT ten FROM `nguoimuas`
SELECT tenmathang FROM `mathangs` 
SELECT * FROM `donhangs`

5.
SELECT ten FROM `nguoimuas` ORDER BY ten asc; 
SELECT tenmathang,gia FROM `mathangs` WHERE ORDER by gia DESC;
SELECT * FROM `donhangs` WHERE dienthoai='0123456789';

6.
SELECT COUNT(*) as tongkhachhang FROM `nguoimuas`;
SELECT COUNT(*) as tongmathang FROM `mathangs`;
SELECT id,tongtien FROM `donhangs`;

SELECT tenmathang from mathangs WHERE 
id in (SELECT mathang_id from chitiets 
              where donhang_id in ( select donhang_id from donhangs 
                                  where dienthoai in (select dienthoai from nguoimuas 
                                                     where ten = 'Nguyen Van An')))

7.
CREATE VIEW View_khachhang AS SELECT * FROM `nguoimuas`;
CREATE VIEW View_sanpham as SELECT tenmathang, gia from `mathangs`;
create view view_khachhang_sanpham as 
SELECT ten, dienthoai, tenmathang, soluong, ngaydat 
from nguoimuas A INNER join mathangs B INNER join donhangs C INNER join chitiets D
ON A.sodienthoai = C.dienthoai and C.id = D.donhang_id and D.mathang_id = B.id


--------------------------------------------------------------------------------------
--ASM02
4.
select * from brands;
select * from products;

5.
SELECT * FROM `brands` order by brand_name desc;
SELECT * from `products` order by price desc;
SELECT * from `brands` WHERE brand_name = 'ASUS';
SELECT * from `products` where quantity < 11;
SELECT * from `products` where brand_id = (SELECT id from `brands` WHERE brand_name = 'ASUS');

6.
SELECT COUNT(*) FROM `brands`;
SELECT SUM(quantity) as tongsohang from products;
SELECT brand_id, COUNT(*) FROM `products` GROUP BY brand_id;
SELECT COUNT(*) from `products`;

7.
CREATE VIEW View_Sanpham as SELECT id as masanpham, product_name as tensanpham, price as gia 
    FROM `products`;
CREATE VIEW View_sanpham_han as SELECT A.id, A.product_name, B.brand_name 
    FROM products A INNER JOIN brands B WHERE A.brand_id = B.id; 


--------------------------------------------------------------------------------------
--ASM03
4.
SELECT * from customers;
SELECT * FROM phonenumbers;

5.
SELECT * FROM `customers` INNER JOIN phonenumbers ON customers.NRIC = phonenumbers.customer_NRIC
WHERE phonenumbers.phonenumber = '0123456789';
SELECT * FROM `customers` WHERE NRIC = 123456789;
SELECT phonenumber from phonenumbers where customer_NRIC = 123456789;
SELECT * from phonenumbers where registrationdate = '2009-12-12';
SELECT * from phonenumbers WHERE customer_NRIC in (SELECT NRIC from customers where address='Ha Noi');

6.
SELECT COUNT(*) from customers; 
SELECT COUNT(*) from phonenumbers; 
SELECT COUNT(*) from phonenumbers WHERE registrationdate = '2009-12-12';
SELECT * from customers inner join phonenumbers ON customers.NRIC = phonenumbers.customer_NRIC;

8.
create VIEW View_khachhang as SELECT * from customers;
create VIEW View_khachhang_thuebao as SELECT NRIC as Makhachhang, name as Tenkhachhang, phonenumber as thuebao 
from customers INNER JOIN phonenumbers ON customers.NRIC = phonenumbers.customer_NRIC;


--------------------------------------------------------------------------------------
--ASM04
4.
SELECT * from producttypes;
SELECT * from products;
SELECT * from pics;

5.
SELECT * FROM `producttypes` ORDER BY typename ASC;
SELECT * FROM `pics` ORDER BY name ASC;
SELECT * FROM `producttypes` WHERE id = 'Z37E';
SELECT * from products WHERE pic_id = (SELECT id from pics WHERE name = 'Nguyen Van An')
ORDER by id desc;

6.
SELECT type_id,count(*) FROM `products` GROUP BY type_id;
SELECT type_id,avg(*) FROM `products` GROUP BY type_id;
SELECT * FROM `products` INNER JOIN producttypes WHERE products.type_id = producttypes.id;
SELECT * FROM `products` INNER JOIN producttypes inner JOIN pics
WHERE products.type_id = producttypes.id AND products.pic_id = pics.id;

8.
create view View_sanpham as select * from `products`;
create view View_sanpham_NTCN as select A.id, A.productiondate, B.name 
from products A inner join pics B;
create view View_top_sanpham as SELECT id, type_id, productiondate FROM `products` ORDER by productiondate DESC;


--------------------------------------------------------------------------------------
--ASM05
4.
SELECT * FROM `customers`;
SELECT * FROM `phonenumbers`;

5.
SELECT * FROM `customers` order by name asc;
SELECT phonenumber FROM `phonenumbers` where customer_id in 
(select id from customers where name = 'Nguyen Van An');
SELECT * FROM `customers` where birthday = '2009-12-12';

6.
SELECT B.name, COUNT(*) FROM `phonenumbers` A inner join customers B ON A.customer_id = B.id 
GROUP BY customer_id;
SELECT count(*) FROM `customers` WHERE month(birthday) = '12';
SELECT A.phonenumber, B.name, B.address, B.birthday FROM `phonenumbers` A inner join customers B;
SELECT * FROM `customers` WHERE 
id in (SELECT customer_id from phonenumbers where phonenumber = '123456789');

8.
create VIEW View_sodienthoai as SELECT customers.name, phonenumbers.phonenumber 
FROM `phonenumbers` INNER JOIN customers WHERE phonenumbers.customer_id = customers.id;
CREATE VIEW View_sinhnhat as SELECT A.name, A.birthday, B.phonenumber 
FROM `phonenumbers` B INNER JOIN customers A ON B.customer_id = A.id
WHERE month(A.birthday) = (SELECT MONTH(CURRENT_DATE()));


--------------------------------------------------------------------------------------
--ASM06
3. SELECT * FROM `thongtinsachs` WHERE namxuatban > 2008;
4. SELECT * FROM `thongtinsachs` order by giaban DESC LIMIT 10;
5. SELECT * FROM `thongtinsachs` WHERE ten LIKE '%tin hoc%';
6. SELECT * FROM `thongtinsachs` WHERE ten LIKE 'T%' ORDER by giaban desc;
7. SELECT * FROM `thongtinsachs` WHERE nhaxuatban_id in 
    ( SELECT id from nhaxuatbans WHERE tennxb='Tri Thuc' );
8. SELECT * FROM nhaxuatbans WHERE id in 
    (SELECT nhaxuatban_id from thongtinsachs WHERE ten='Tri Tue Do Thai');
9. SELECT A.masach, A.ten, A.namxuatban, B.tennxb, C.tentheloai 
    FROM `thongtinsachs` A INNER JOIN nhaxuatbans B INNER JOIN theloais C
    ON A.nhaxuatban_id = B.id and A.theloai_id = C.id;
10. SELECT * FROM `thongtinsachs` ORDER by giaban DESC LIMIT 1;
11. SELECT * FROM `thongtinsachs` ORDER by soluong DESC LIMIT 1;
12. SELECT * FROM `thongtinsachs` WHERE tacgia_id = 
    (select id from tacgias where tentacgia = 'Eran Kratz');
13. UPDATE thongtinsachs SET giaban = (giaban/100)*90 WHERE namxuatban < 2008;
14. SELECT nhaxuatban_id,COUNT(*) FROM `thongtinsachs` group by nhaxuatban_id;
15. SELECT theloai_id,COUNT(*) FROM `thongtinsachs` group by theloai_id;
17. CREATE VIEW View_chitietsach AS 
    SELECT A.masach, A.ten, A.giaban, B.tennxb, C.tentacgia 
    FROM `thongtinsachs` A INNER join nhaxuatbans B INNER JOIN tacgias C
    ON A.nhaxuatban_id = B.id and A.tacgia_id = C.id; 


--------------------------------------------------------------------------------------
--ASM09
3.
SELECT * FROM `dongxes` WHERE sochongoi > 5;

4.
SELECT * FROM `nhacungcaps` 
WHERE 
    id IN (SELECT nhacungcap_id from dangkycungcaps WHERE 
                dongxe in (SELECT dongxe FROM dongxes WHERE hangxe = 'Toyota') and
                mucphi_id in (SELECT id from mucphis WHERE dongia = 15000))
OR

    id IN (SELECT nhacungcap_id from dangkycungcaps WHERE 
                dongxe in (SELECT dongxe FROM dongxes WHERE hangxe = 'KIA') and 
                mucphi_id in (SELECT id from mucphis WHERE dongia = 20000));

5.
SELECT * FROM `nhacungcaps` ORDER BY tennhacungcap asc, masothue DESC;

6.
SELECT nhacungcap_id, COUNT(*) FROM dangkycungcaps 
WHERE ngaybatdaucungcap >= '2015-11-20'  GROUP BY nhacungcap_id

7.
SELECT DISTINCT hangxe FROM `dongxes`

8.
SELECT
    A.id AS MaDKCC,
    E.id AS MaNhaCC,
    E.tennhacungcap,
    E.diachi,
    E.masothue,
    C.ten AS TenLoaiDV,
    D.dongia,
    B.hangxe,
    A.ngaybatdaucungcap,
    A.ngayketthuccungcap
FROM
    nhacungcaps E
LEFT JOIN
    (
        dangkycungcaps A
        INNER JOIN dongxes B INNER JOIN loaidichvus C INNER JOIN mucphis D 
        ON A.dongxe = B.dongxe AND A.loaidichvu_id = C.id AND A.mucphi_id = D.id
    )
ON
    e.id = A.nhacungcap_id;

9.SELECT * FROM `nhacungcaps` WHERE id in  
    (SELECT nhacungcap_id from dangkycungcaps WHERE dongxe = 'Hiace' OR dongxe = 'Cerato')

10.
SELECT * from nhacungcaps WHERE id NOT in (SELECT nhacungcap_id from dangkycungcaps)
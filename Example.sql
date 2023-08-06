CREATE TABLE #BookSales
( 
	BookName VARCHAR(50),
	BookCategoryName VARCHAR(50),
	Quantity INT,
	PublishYear INT
)

INSERT INTO #BookSales VALUES('Dune', 'Science Fiction', 3, 2022);
INSERT INTO #BookSales VALUES('Before We Were Yours', 'Drama', 7, 2022);
INSERT INTO #BookSales VALUES('Don Quixote by Miguel de Cervantes', 'Adventure', 1, 2023);
INSERT INTO #BookSales VALUES('Frankenstein', 'Science Fiction', 5, 2023);
INSERT INTO #BookSales VALUES('Salt', 'History', 2, 2023);
INSERT INTO #BookSales VALUES('Spare', 'History', 2, 2023);

SELECT * FROM #BookSales;

-- ROW_NUMBER
SELECT 
 ROW_NUMBER() OVER(ORDER BY Quantity DESC) AS RowNumber,
 BookName,
 BookCategoryName,
 Quantity
FROM
 #BookSales;

-- RANK() ve DENSE_RANK()
SELECT 
     RANK() OVER(PARTITION BY PublishYear ORDER BY Quantity DESC) AS Rank,
     DENSE_RANK() OVER(PARTITION BY PublishYear ORDER BY Quantity DESC) AS 'Dense_Rank',
     BookName,
     BookCategoryName,
     PublishYear,
     Quantity
FROM 
	#BookSales;
	
-- FIRST_VALUE
SELECT
 BookName,
 BookCategoryName,
 PublishYear,
 FIRST_VALUE(BookCategoryName) OVER(PARTITION BY PublishYear ORDER BY Quantity) AS Lowest_Sales_Category
FROM
 #BookSales;
	
-- LAST_VALUE
SELECT
 BookName,
 BookCategoryName,
 PublishYear,
 LAST_VALUE(BookCategoryName) OVER(Order By Quantity) AS Highest_Sales_Category
FROM
 #BookSales;

SELECT
 BookName,
 BookCategoryName,
 PublishYear, 
 LAST_VALUE(BookCategoryName) 
 OVER(Partition By PublishYear Order By Quantity 
 ROWS Between 1 Preceding AND 2 Following) AS Highest_Sales_Category
FROM
 #BookSales;

-- LEAD
SELECT 
 BookName,
 BookCategoryName,
 PublishYear,
 LEAD(BookCategoryName)   OVER (PARTITION BY PublishYear ORDER BY Quantity DESC) Next_Sales,
 LEAD(BookCategoryName,1) OVER (PARTITION BY PublishYear ORDER BY Quantity DESC) Next_Sales_1,
 LEAD(BookCategoryName,2) OVER (PARTITION BY PublishYear ORDER BY Quantity DESC) Next_Sales_2
FROM 
 #BookSales

-- LAG
SELECT 
 BookName,
 BookCategoryName,
 PublishYear,
 LAG(BookCategoryName)   OVER (PARTITION BY PublishYear ORDER BY Quantity DESC) Last_Sales,
 LAG(BookCategoryName,1) OVER (PARTITION BY PublishYear ORDER BY Quantity DESC) Last_Sales_1,
 LAG(BookCategoryName,2) OVER (PARTITION BY PublishYear ORDER BY Quantity DESC) Last_Sales_2
FROM 
 #BookSales

--Moving Average
SELECT 
    *,
    AVG(Quantity) 
    OVER(PARTITION BY PublishYear ORDER BY Quantity
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
    AS 'Moving Average'
FROM 
 #BookSales;

DROP TABLE #BookSales;
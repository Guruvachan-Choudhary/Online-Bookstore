
----create tables

create table Books (

Book_ID serial primary key,
Title varchar(100),
Author varchar(100),
Genre varchar(100),
Published_Year	int,
Price numeric(10,2),
Stock int

);

create table customers(

Customer_ID	 serial primary key,
Name varchar(100),
Email varchar(100),
Phone varchar(15),
City varchar(50),
Country	varchar(150)

);

create table Orders(

Order_ID serial primary key,
Customer_ID	int references Customers(Customer_ID),
Book_ID	int references Books(Book_ID),
Order_Date date,
Quantity int,
Total_Amount numeric(10,2)

);


---import data into

select * from Books;
select * from orders;
select * from Customers;

---------------------------basic queris-----------------------------

--retrive all books in the "Fiction" genre

select * from Books
where genre = 'Fiction';

--findbooks published after the year 1950

select * from Books
where published_year > 1950;

--list all customers from the canada

select *  from Customers
where country = 'Canada';

--show orders placed in november 2023

select * from orders
where order_date between '2023-11-01' and '2023-11-30' ;

--retrive the total stock of books available

select sum(stock) as Total_stock from Books;

--find the details of the most expensive book

select * from Books 
order by price desc 
limit 1;

--show all customers who ordered more than 1 quantity of a book

select * from orders
where quantity >1;

--retrive all the orders where the total amount exceeds $20

select * from orders
where total_amount > 20;

--list all the genre available in the book tables

select distinct genre from Books;

--find the book with the lowest stock

select * from Books
order by stock 
limit 1;

--calculate the total revenue generated from all orders

select sum(total_amount) as Revenue from orders;

-------------------------------Advance Queries-----------------------------------------

--retrive total number opf books sold for each genre

select * from orders;

select b.genre, sum(o.quantity) as total_books_sold
from orders o join Books b on o.book_id = b.book_id
group by b.genre;

--find the average price of books in the "fantasy" genre

select avg(price) as avg_price 
from Books 
where genre = 'Fantasy';

--list customers who have placed at least 2 orders

select o.customer_id, c.name, count(o.order_id) as order_count from orders o join Customers c
on o.customer_id = c.customer_id
group by o.customer_id, c.name
having count(o.order_id) >= 2;

--find the most frequently ordered book

select o.book_id,b.Title, count(o.order_id) as order_count from orders o
join Books b on o.book_id = b.Book_id 
group by o.book_id,b.Title
order by order_count desc limit 10;

--show the top 3 most expensive books of 'fantasy' genre

select * from Books
where genre = 'Fantasy'
order by price desc limit 3;

--retrive the total quantity of books sold by each author

select b.author, sum(o.quantity) as total_book_sold 
from orders o 
join Books b on o.book_id = b.book_id 
group by b.author;

--list the cities where customers who spent over $30  are located

select distinct c.city,total_amount from Customers c 
join orders o on c.customer_id = o.customer_id
where o.total_amount > 30;

--find the customers who spent the most on orders

select c.customer_id,c.name, sum(o.total_amount) as total_spent_amount from Customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.name, o.total_amount 
order by total_spent_amount desc;

--calculate the stock remaining after fulfilling all orders

select b.book_id,b.title,b.stock,coalesce(sum(o.quantity),0) as order_quantity, 
b.stock - coalesce(sum(o.quantity),0) as remaning_quantity from Books b 
left join orders o on b.book_id = o.book_id 
group by b.book_id
order by b.book_id desc;














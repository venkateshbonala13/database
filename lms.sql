use lms;


select * from library_member
	where first_name="Andrew" and last_name="Jackson" and phone_no=8974114892;
    

select * from library_member;


select co.member_id, b.title, b.author_name, b.year_published, co.checkout_date, co.due_date
	from book_isbn bi
    join book b on bi.book_id = b.book_id
    join checkout co on bi.isbn = co.isbn
    where co.member_id = (select member_id from library_member 
							where last_name="Hales");
                            


select * from book;
select * from book_isbn;
insert into checkout (isbn, member_id, checkout_date, due_date, is_returned)
	values ((select isbn from book_isbn where 
			book_id = (select book_id from book where title="python")),
			(select member_id from library_member where last_name = "Arthur"),
            "2024-01-20", "2024-02-28", 0);
select * from checkout;


select b.title, b.author_name, sum(b.quantity) as total_quantity
			from book b 
            left join checkout co on b.book_id = (select book_id from book_isbn where isbn = co.isbn)
            where co.is_returned = 1
            group by b.title, b.author_name;


select * from checkout;
select * from checkout where due_date = curdate() + interval 2 day;


select * from checkout 
	where due_date < curdate() and is_returned = 0;
    

select b.book_id, b.title, b.author_name, b.year_published from book b
	join book_isbn bi on b.book_id = bi.book_id
    join checkout co on co.isbn = bi.isbn
    where co.checkout_date = curdate();


select b.book_id, b.title, b.author_name, b.year_published, bi.isbn, co.is_returned from book b
	join book_isbn bi on b.book_id = bi.book_id
    left join checkout co on bi.isbn = co.isbn
with agg as(
select 
	likes,
	post_date - lag(post_date) over (order by post_date) as post_time_diff -- ищем разницу во времени между постами
from posts)

select 
	case
		when post_time_diff is null then 'First_post'
		when post_time_diff < interval '12 hours' then '<12 hours'
		when post_time_diff < interval '24 hours' then '<1 day'
		when post_time_diff < interval '72 hours' then '<1-3 days'
		else '>3 days'
	end as time_category, -- делаем категорию под время чтобы легче было воспринимать 
	round(avg(likes), 2) as avg_likes,
    count(*) as posts_count
from agg
group by time_category
order by avg_likes desc

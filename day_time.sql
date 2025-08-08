SELECT
       CASE
           WHEN EXTRACT(hour FROM posts.post_date) >= 0::numeric AND EXTRACT(hour FROM posts.post_date) <= 5::numeric THEN 'night'::text
           WHEN EXTRACT(hour FROM posts.post_date) >= 6::numeric AND EXTRACT(hour FROM posts.post_date) <= 11::numeric THEN 'morning'::text
           WHEN EXTRACT(hour FROM posts.post_date) >= 12::numeric AND EXTRACT(hour FROM posts.post_date) <= 17::numeric THEN 'day'::text
		   else 'evening'
       END AS "day_time", -- делаем категории под время суток публикации поста
       round(avg(posts.likes), 0) AS "avg_likes", -- считаем среднее количество лайков на категорию
       count(*) AS "post_count" -- считаем кол-во постов на категорию
FROM posts
group by day_time
order by avg_likes desc
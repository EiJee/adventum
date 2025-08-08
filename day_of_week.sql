SELECT round(avg(posts.likes), 0) AS avg_likes, -- ищем среднее значение лайков в каждый день недели
            to_char(posts.post_date, 'Day'::text) AS day, -- вынимаем день недели из даты
            count(*) AS count_posts --общее значение постов в каждый день недели
           FROM posts
          GROUP BY (to_char(posts.post_date, 'Day'::text))
order by avg_likes desc
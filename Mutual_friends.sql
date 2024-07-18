-- Mutual friend details

with s1 as (
  select u.user_id
    , u.user_name
    , u1.user_name as friend_name 
    , u1.user_id as friend_id 
  from users u 
    left join friends f on u.user_id = f.user_id 
    left join users u1 on f.friend_id = u1.user_id 
  where u.user_name in ('Karl', 'Hans')
) 
select distinct a.friend_id as users 
  , a.friend_name as friends 
from s1 as a 
  join s1 as b on a.user_id <> b.user_id 
  and a.friend_id = b.friend_id;
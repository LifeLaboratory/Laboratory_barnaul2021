import app.base.provider as bp


class Provider(bp.Provider):
    def __init__(self):
        super().__init__()
        self.table_name = 'review'
        self.field = ['id_review', 'id_user', 'description', 'stars']

    def get_statistics_admin(self, id_user):
        self.query = f'''
with is_admin as (
  select
    True
  from users
  where id_user = {id_user}
    and type in (1, 2)
  limit 1
)
  select
    tag as name
    , count(1) as value
  from "tasks" t
  where (table is_admin)
  group by tag
        '''
        return self.execute()

    def get_statistics_users(self, id_user):
        self.query = f'''
with is_admin as (
  select
    True
  from users
  where id_user = {id_user}
    and type in (1, 2)
  limit 1
)
  select
    us.name as name
    , case status 
        when 0 then 'На выполнение'
        when 1 then 'Выполнено'
        when 2 then 'Принято'
      end as status
    , count(1) as value
  from "tasks" t
  left join "users" us on us.id_user = t.id_admin
  where (table is_admin)
  group by us.name, status
  order by 1, 2
        '''
        return self.execute()

    def get_statistics_all_task_today(self, id_user):
        self.query = f'''
with is_admin as (
  select
    True
  from users
  where id_user = {id_user}
    and type in (1, 2)
  limit 1
)
  select
    count(1) as value
    , count(1) filter(where status = 0) as "На выполнение"
    , count(1) filter(where status = 1) as "Выполнено"
    , count(1) filter(where status = 2) as "Принято"
  from "tasks" t
  where (table is_admin)
    and now()::date = date_start::date
        '''
        return self.execute()
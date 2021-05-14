import app.base.provider as bp


class Provider(bp.Provider):
    def __init__(self):
        super().__init__()
        self.table_name = 'tasks'
        self.field = ['id_tasks', 'description', 'status', 'stars', 'picture',
                      'id_user', 'id_admin']

    def create(self, data):
        self.query = f'''
with get_admin as (
  select 
    id_user
  from 
    users
  where "type" = 1
  order by random ()
  limit 1
)
  insert into "{self.table_name}"
  (description, picture, id_admin, id_user, tag)
  select 
    '{data.get('description')}'
    , '{data.get('picture') or ''}'
    , (table get_admin)
    , '{data.get('id_user')}'
    , '{data.get('tag')}'
  returning id_tasks
'''
        return self.execute()

    def tasks_update(self, data):
        status = data.get('status')
        description = data.get('description')
        stars = data.get('stars')
        id_tasks = data.get('id_tasks')
        id_user = data.get('id_user')
        date_end = None
        if status == 2:
            date_end = 'now()'
        self.query = f'''
  update
    "{self.table_name}"
  set
    {'"status" = ' + f"{status}," if status else ''}
    {'"description" = ' + f"{description}," if description else ''}
    {'"stars" = ' + f"{stars}," if stars else ''}
    {'"date_end" = ' + f"{date_end}," if date_end else ''}
    {'"id_tasks" = ' + f"'{id_tasks}'" if id_tasks else ''}
  where 
    "id_tasks" = {str(id_tasks)}
    and ("id_user" = {id_user} or "id_admin" = {id_user})
    '''
        return self.execute()

    def get_tasks_user(self, id_user):
        self.query = f'''
  select 
    id_tasks
    , description 
    , status 
    , stars 
    , t.picture 
    , 'Администратор ' || us.name as "admin_name"
  from "{self.table_name}" t
  left join "users" us on us.id_user = t.id_admin
  where t."id_user" = {id_user}
  order by status
        '''
        return self.execute()

    def get_all_tasks_users(self, id_user):
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
    id_tasks
    , description 
    , status 
    , stars 
    , t.picture 
    , 'Администратор ' || us.name as "admin_name"
  from "{self.table_name}" t
  left join "users" us on us.id_user = t.id_admin
  where (table is_admin)
  order by status desc
        '''
        return self.execute()

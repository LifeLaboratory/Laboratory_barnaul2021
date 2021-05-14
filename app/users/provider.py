import app.base.provider as bp


class Provider(bp.Provider):
    def __init__(self):
        super().__init__()
        self.table_name = 'users'
        self.field = ['login', 'password', 'telephone', 'picture', 'type']

    def create(self, data):
        self.query = f'''
  insert into "{self.table_name}"
  (login, password)
  values (
    '{data.get('login')}'
    , md5('{data.get('password')}'::text)
  )
  returning id_user
'''
        return self.execute()

    def check_user(self, data):
        where = f'''
  where true
    and '{data.get('login')}' = "login"
  limit 1
'''
        user = self.users(where)
        return user[0] if user else None

    def login(self, data):
        where = f'''
  where true
    and ('{data.get('login')}' 
      = "login")
    and (md5('{data.get('password')}'::text)
      = "password")
  limit 1
        '''
        user = self.users(where)
        return user[0] if user else None

    def profile(self, id_user):
        self.query = f'''
select
  id_user
  , coalesce(name, ''::text) as name
  , coalesce(picture, ''::text) as picture
  , coalesce(number, 0) as number 
  , coalesce(telephone, ''::text) as telephone 
  , coalesce(date_birthday::text, ''::text) as date_birthday 
from users u
where id_user = {id_user}
limit 1
'''
        return self.execute()

    def profile_update(self, data):
        picture = data.get('pictrure')
        name = data.get('name')
        telephone = data.get('telephone')
        date_birthday = data.get('date_birthday')
        id_user = data.get('id_user')
        self.query = f'''
  update 
    users
  set
    {'"picture" = ' + f"'{picture}'," if picture else ''}
    {'"name" = ' + f"'{name}'," if name else ''}
    {'"telephone" = ' + f"'{telephone}'," if telephone else ''}
    {'"date_birthday" = ' + f"'{date_birthday}'," if date_birthday else ''}
    {'"id_user" = ' + f"'{id_user}'" if id_user else ''}
  where 
    "id_user" = {str(id_user)}
    '''
        return self.execute()

    def users(self, where='where True'):
        self.query = f'''
  select 
    id_user
    , name
  from "{self.table_name}"
  {where}
        '''
        return self.execute()

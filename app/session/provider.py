
import app.base.provider as bp


class Provider(bp.Provider):
    def __init__(self):
        super().__init__()
        self.table_name = 'session'
        self.field = ['is_user', 'id_session']

    def create(self, id_user):
        self.query = f'''
  insert into "{self.table_name}"
  (id_user, id_session)
  values( 
    {id_user}
    , uuid_in(md5(random()::text || now()::text)::cstring)::text
  )
  returning id_session as "session"
'''
        return self.execute()

    def get_session(self, id_user):
        self.query = f'''
          select
             id_session as "session"
          from "{self.table_name}"
          where id_user = {id_user}
          limit 1
        '''
        return self.execute()

    def check_session(self, session):
        self.query = f'''
  select 
    id_user
    , type
  from "{self.table_name}"
  join "users" us using("id_user")
  where '{session}' = id_session
  limit 1
'''
        return self.execute()[0]

    def is_admin(self, id_user):
        self.query = f'''
  select
    True as is_admin
  from users
  where id_user = {id_user}
    and type in (1, 2)
  limit 1
        '''
        return self.execute()

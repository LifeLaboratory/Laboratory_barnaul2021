import app.base.provider as bp


class Provider(bp.Provider):
    def __init__(self):
        super().__init__()
        self.table_name = 'review'
        self.field = ['id_tasks', 'description', 'status', 'stars', 'picture',
                      'id_user', 'id_admin']

    def get_review(self, id_user):
        self.query = f'''
    select 
      us.name 
      , description
    from "{self.table_name}" r
    left join "users" us using("id_user")
    where '{id_user}' = r.id_user
    order by date_review
          '''
        return self.execute()

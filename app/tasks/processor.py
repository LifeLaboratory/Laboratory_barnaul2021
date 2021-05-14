from app.tasks.provider import Provider
from app.base.helper import create_session


class Processor:
    def __init__(self):
        self.provider = Provider()

    def create(self, data):
        tasks = self.provider.create(data)
        if tasks:
            return self.get_tasks_user(data.get('id_user'))
        else:
            return {
                'error': 'Задача не создана!'
            }

    def tasks_update(self, data):
        self.provider.tasks_update(data)
        return self.get_tasks_user(data.get('id_user'))

    def get_tasks_user(self, id_user):
        return self.provider.get_tasks_user(id_user)

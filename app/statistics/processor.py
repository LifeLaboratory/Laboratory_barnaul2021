from app.statistics.provider import Provider
from app.base.helper import create_session


class Processor:
    def __init__(self):
        self.provider = Provider()

    def get_statistics_admin(self, id_user):
        return self.provider.get_statistics_admin(id_user)

    def get_statistics_users(self, id_user):
        return self.provider.get_statistics_users(id_user)

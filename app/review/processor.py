from app.review.provider import Provider
from app.base.helper import create_session


class Processor:
    def __init__(self):
        self.provider = Provider()

    def get_review(self, id_user):
        return self.provider.get_review(id_user)

    def get_statistics_users(self, id_user):
        return self.provider.get_statistics_users(id_user)

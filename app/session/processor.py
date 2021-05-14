from app.session.provider import Provider


class Processor:
    def __init__(self):
        self.provider = Provider()

    def create(self, id_user):
        session = self.provider.get_session(id_user)
        if not session:
            session = self.provider.create(id_user)
        return session

    def check_session(self, session):
        return self.provider.check_session(session)

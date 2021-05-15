from app import app
from app.users import view
from app.tasks import view
from app.statistics import view


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)

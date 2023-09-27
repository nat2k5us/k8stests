from locust import HttpUser, task, between, constant
from datetime import datetime


class MyUser(HttpUser):
    # wait_time = between(1, 3)
    # wait_time = constant(3)
    wait_time = constant(3)
    # host = "http://google.com/"

    @task
    def login_URL(self):
        print(datetime.now())

from locust import User, task, constant_pacing
import time
import random
# , constant, between_pacing



class MyUser(User):
    wait_time = constant_pacing(10)

    @task
    def my_task(self):
        time.sleep(random.random())

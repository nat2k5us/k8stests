from locust import User, task, between


class MyUser(User):
    wait_time = between(1, 2)
    weight=3
    @task
    def login_URL(self):
        print("I am logged into web URL")

class MyMobileUser(User):    
    wait_time = between(1, 2)
    weight=1
    @task
    def login_URL(self):
        print("I am logged into web URL")
    

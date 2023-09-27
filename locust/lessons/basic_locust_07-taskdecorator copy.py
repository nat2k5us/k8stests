from locust import User, task, between


class MyUser(User):
    wait_time = between(1, 2)

    @task(2)
    def login_URL(self):
        print("I am logged in")
    
    @task(4)
    def logout(self):
        print("I am logged out")
    
# $>  locust -f /Users/nbontha/dev/k8tests/k8stests/locust/lessons/basic_locust_07-taskdecorator.py -u 1 -r 1 --headless --only-summary
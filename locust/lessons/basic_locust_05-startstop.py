from locust import User, task, between


class MyUser(User):
    wait_time = between(1, 2)

    # @task
    def on_start(self):
        print("I am logged in")
   
    @task
    def doing_work(self):
        print("I am doing work")
    # @task
    def on_stop(self):
        print("I am logging out")
    
# $> locust -f /Users/nbontha/dev/k8tests/k8stests/locust/lessons/basic_locust_05-startstop.py -u 1 -r 1 --headless --only-summary
from locust import User, task, between, events


@events.test_start.add_listener
def script_start(**kwargs):
    print("I am connecting to DB")


@events.test_stop.add_listener
def script_stop(**kwargs):
    print("I am disconnecting from DB")


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

# $>  locust -f /Users/nbontha/dev/k8tests/k8stests/locust/lessons/basic_locust_06-test-startstop.py -u 1 -r 1 --headless --only-summary

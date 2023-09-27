from locust import User, task, between, SequentialTaskSet


class UserBehavior(SequentialTaskSet):

    @task()
    def find_flight(self):
        print("I will find flights for criteria")


    @task()
    def book_flight(self):
        print("I will select flights")


    @task()
    def book_flight(self):
        print("I will book flights")


class MyUser(User):
    wait_time = between(1, 2)
    tasks = [UserBehavior]

# $>  locust -f 09-sequentialTask.py -u 1 -r 1 --headless --only-summary

from locust import User, task, between, TaskSet


class MyUser(User):
    wait_time = between(1, 2)

    @task()
    class UserBehavior(TaskSet):
        @task()
        def add_cart(self):
                print("Add to cart")

        @task()
        def view_product(self):
            print("view product")



# $>  locust -f ./locust/lessons/08-task-class.py -u 1 -r 1 --headless --only-summary

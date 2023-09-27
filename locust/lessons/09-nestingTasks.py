from locust import User, task, between, TaskSet


class UserBehavior(TaskSet):
    class Cart_Module(TaskSet):
        @task()
        def add_cart(userclass):
            print("I added to cart")

    @task()
    def delete_cart(userclass):
        print("I deleted from cart")

    class Product_Module(TaskSet):
        @task()
        def view_product(self):
            print("I am viewing product")

    @task()
    def add_product(userclass):
        print("I will add product")


class MyUser(User):
    wait_time = between(1, 2)
    tasks = [UserBehavior]

# $>  locust -f 09-nestingTasks.py -u 1 -r 1 --headless --only-summary

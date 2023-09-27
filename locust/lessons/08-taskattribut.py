from locust import User, task, between


def add_cart(userclass):
    print("Add to cart")


def view_product(userclass):
    print("view product")


class MyUser(User):
    wait_time = between(1, 2)

    # tasks = [add_cart, view_product]
    tasks = {add_cart:6, view_product:3}
# $>  locust -f 08-taskattribut.py -u 1 -r 1 --headless --only-summary

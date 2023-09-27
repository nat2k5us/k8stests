# Locust Load Testing

## Requirements

* install locust using `brew install locust`
* install python 3.x using `pip install python`

## Basic Usage

```python
from locust import User

class MyUser(User):
    pass
```

* run the  test with `locust -f ./filename.py`
* users : -u 1
* hatch rate : -r 1
* host : -H "https://api.tradestation.com"
* time: -t 100

## Example 1 - using task

```python
from locust import User, task

class MyUser(User):
    print(f"Hello World")
```

## Example 2 - define wait times

```python
from locust import User, task, between, constant, between_pacing
from datetime import datetime

class MyUser(User):
    wait_time = between(1,2)
    #wait_time = constant(2)
    #wait_time = between_pacing(5)

    @task
    def demo(self)
        print(f"Hello World {datetime.now()}")
```

## Example 3 - HttpUser

```python
from locust import HttpUser, task, between
from datetime import datetime

class WebUser(HttpUser):
    wait_time = between(1,2)
    host = "http://www.google.com"
    @task
    def demo(self)
        print(f"Hello World {datetime.now()}")
```

## Example 4 - HttpUser, weights

```python
from locust import HttpUser, task, between
from datetime import datetime

class WebUser(HttpUser):
    wait_time = between(1,2)
    weight = 2
    host = "http://www.google.com"
    @task(1)
    def demo(self)
        print(f"Hello World WebUser {datetime.now()}")
class User2(HttpUser):
    wait_time = between(1,2)
    weight = 1
    host = "http://www.google.com"
    @task(2)
    def demo(self)
        print(f"Hello World User 2 {datetime.now()}")
```

## Headless mode or NO GUI mode

`locust -f ./filename.py -u 1 -r 1 --headless`

## Headless mode or NO GUI mode show summary only

`locust -f ./filename.py -u 1 -r 1 --headless --only-summary`

## OnStart hook

```python
from locust import HttpUser, task, between

class WebUser(HttpUser):
    wait_time = between(1,2)
    def on_start(self):
        print("before starting WebUser")
    @task(1)
    def demo(self)
        print(f"Hello World WebUser")

    def on_stop(self):
        print("after stopping WebUser")
```

## Event Listener

```python
from locust import HttpUser, task, between

@events.test_start.add_listener
def start_process(**kwargs):
    print("start process")

@events.test_stop.add_listener
def start_process(**kwargs):
    print("stop process")


class WebUser(HttpUser):
    wait_time = between(1,2)

    @task(1)
    def demo(self)
        print(f"Hello World WebUser")

```

## Reuseable Tasks and Give Weightages

```python
form locust import User, task, between, events

def web(self):
    print("web request")

def mobile(self):
    print("mobile request")

def something_else(self):
    print("something else request")

class MyAppTest(User):
    wait_time = between(1,2)

    tasks = [web , mobile, something_else]
    # tasks = [web : 3, mobile : 1, something_else: 2] # with weightage
```

## Tasksets

```python
form locust import User, task, between, TaskSet

class TaskSetsEx(TaskSet):
    @task
    def web(self):
        print("web request")

    @task
    def mobile(self):
        print("mobile request")

    @task
    def something_else(self):
        print("something else request")

class MyAppTest(User):
    wait_time = between(1,2)

   tasks = [TaskSetsEx]
```


## Nested Taskset - using self.interrupt() to to break out of nests

```python
form locust import User, task, between, SequentialTaskSet

class SeqTaskSetsEx(TaskSet):
    @task
    class NestA(SequentialTaskSet):
        @task
        def web(self):
            print("1 A web request")
            self.interrupt()

        @task
        def mobile(self):
            print("2 A mobile request")
            self.interrupt()

        @task
        def something_else(self):
            print("3 A something else request")
            self.interrupt()
    @task
    class NestB(SequentialTaskSet):
        @task
        def web(self):
            print("1 B web request")

        @task
        def mobile(self):
            print("2 B mobile request")

        @task
        def something_else(self):
            print("3 B something else request")

class MyAppTest(User):
    wait_time = between(1,2)

   tasks = [SeqTaskSetsEx]
```

# HttpUser Usage

```python
from locust import HttpUser, task, between

class WebUser(HttpUser):
    wait_time = between(1,2)
    host = 'http://localhost'
    def test(self):
        self.client.get('/ping')

```

# HttpUser Usage 2

```python
from locust import HttpUser, task, between
from json

class WebUser(HttpUser):
    wait_time = between(1,2)
    host = 'http://localhost'
    def test(self):
        self.client.post('/login/index.php', data=json.dumps({'username': 'test', 'password': 'test', 'email': 'test@test.com'}), headers=headers, name = 'test')

```

## In K8s ClusterIP

* master and worker configurations
* running with only a master will complain there are no workers `locust -f file.py --master`
* launch a worker and the master will start collecting data `locust -f file.py --worker`
* launch master and 2 workers with expecting 2 workers `locust -f file.py --only-summary --master --except-worker 2`

## Locust Sample Scripts

`$ locust -f ./basic_locust_01.py -u 5 r 1 -t 60s --headless`

## Choose between DEBUG/INFO/WARNING/ERROR/CRITICAL. Default is INFO

`$ locust -f ./basic_locust_01.py -u 5 r 1 -t 60s --headless --logfile lofile.log  loglevel DEBUG`

from locust import HttpUser, TaskSet, task,between

    
class WebsiteUser(HttpUser):
    host = "http://127.0.0.1:8089"
    min_wait = 2000
    max_wait = 5000
    wait_time=between(1,2)
    
    
    @task
    def page404(self):
        self.client.get("/does_not_exist")    
    
    @task
    def index(self):
        self.client.get("/")
    
    @task
    def stats(self):
        self.client.get("/stats/requests")  


# $> locust -f 11-httplocust.py  -u 10 -r 1

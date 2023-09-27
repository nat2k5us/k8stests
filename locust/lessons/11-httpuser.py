import random
from random import randint, choice
from locust import HttpUser, task, between, SequentialTaskSet
import time
import os
import json

from socket import socket, AF_INET, SOCK_DGRAM


def get_random_time_interval():
    """get a random time"""
    min_seconds = 60 * 2 * 1000
    max_seconds = 60 * 5 * 1000
    return randint(min_seconds, max_seconds)


def get_current_time():
    """get current time"""
    return int(round(time.time() * 1000))


def waitForRandomTime(start_time, response):
    line_count = 0
    wait_time = get_random_time_interval()
    current_time = get_current_time()

    for line in response.iter_lines():
        current_time = get_current_time()

        if (current_time - start_time) < wait_time:
            if line:
                line_count = line_count + 1
            elif line:
                break
            if (line_count == 1):
                statsd_current = int(round(time.time() * 1000))

        elif (current_time - start_time) > wait_time:
            break
    return





class LightSpeedTasks(SequentialTaskSet):
    host = "https://watchlists.tp-eng-usva-2.nite.tradestation.io"

    @task(5)
    def open_stream(self):
        headers = {'x-ts-auth-fdcn-id': 't1023',
                   'x-harmony-authorization': 'Basic LW4gaGFybW9ueQo6LW4gaGFybW9ueWlzZm9yd2F0Y2hsaXN0cwo=',
                   'accept': 'application/json'}

        start_time = get_current_time()

        response = self.client.get(
            '/watchlist/lists', headers=headers, stream=False)
        if response.status_code == 0:
            return
        # print(response.json())
        python_obj = json.loads(json.dumps(response.json()))
        self.watchlistID = python_obj["WatchLists"][0]["WatchListID"]
        print(self.watchlistID)

        waitForRandomTime(start_time, response)

        response.close()
    @task(5)
    def open_by_id(self):
        headers = {'x-ts-auth-fdcn-id': 't1023',
                   'x-harmony-authorization': 'Basic LW4gaGFybW9ueQo6LW4gaGFybW9ueWlzZm9yd2F0Y2hsaXN0cwo=',
                   'accept': 'application/json'}

        start_time = get_current_time()

        response = self.client.get(
            '/watchlist/lists/' + self.watchlistID, headers=headers, stream=False)
        if response.status_code == 0:
            return
       

        waitForRandomTime(start_time, response)

        response.close()

# @task(1)
# def watchlists_post(self):
#     headers = {'x-ts-auth-fdcn-id': 't1023',
#                'x-harmony-authorization': 'Basic LW4gaGFybW9ueQo6LW4gaGFybW9ueWlzZm9yd2F0Y2hsaXN0cwo=',
#                'accept': 'application/json'}
#     recordId = "TestItem - " + str(random.randint(1, 999))
#     payload = {"Name": recordId, "Symbols": [{"Symbol": "AMZN"}, {"Symbol": "AAPL"}, {
#         "Symbol": "ADBE"}, {"Symbol": "BA"}, {"Symbol": "SOL"}, {"Symbol": "DDD"}]}
#     start_time = get_current_time()
#     # print(str(payload))
#     response = self.client.post(
#         '/watchlist/lists', headers=headers, data=json.dumps(payload))
#     if response.status_code == 0:
#         return

#     waitForRandomTime(start_time, response)

#     response.close()


class LightSpeedUser(HttpUser):
    tasks = [LightSpeedTasks]
    min_wait = 1000
    max_wait = 5000


# $> locust -f 11-httpuser.py  -u 10 -r 1

import random
from random import randint
import http.client
import requests
from locust import HttpUser, task, between, TaskSet, SequentialTaskSet
import json
import os
import time

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


class LSLoginTasks(SequentialTaskSet):

    @task(1)
    def open_get(self):
        host = "http://localhost:8001"
        # self.access_token = getTokenForUser("m354821799", "")
        # to run this test get the access token for the user and paste it here (oauth)
        self.access_token = os.environ['TOKEN']
        headers = {"Authorization": f"Bearer {self.access_token}",
                   "X-TS-Auth-User-ID": "m354821799",
                   'Content-Type': 'application/json',
                   'client-version': 'Android USEQ 4.17',
                   'accept-language': 'en-US',
                   }
        start_time = get_current_time()
        response = self.client.get(
            "/us/live/login",
            headers=headers, stream=False)

        # if '"WatchListStorageMode":"Server"' not in response.text:
        #     print("Invalid Result, WatchListStorageMode need to be Server ")
        #     return
        if response.status_code == 0:
            return
        # print(response.text)
        waitForRandomTime(start_time, response)

        response.close()

    # @task(1)
    # def open_get_2(self):
    #     host = "http://localhost:8001"
    #     # self.access_token = getTokenForUser("m354821799", "")
    #     # to run this test get the access token for the user and paste it here (oauth)
    #     self.access_token = os.environ['TOKEN']
    #     headers = {"Authorization": f"Bearer {self.access_token}",
    #                "X-TS-Auth-User-ID": "M355659959",
    #                'Content-Type': 'application/json',
    #                'accept-language': 'en-US',
    #                }
    #     start_time = get_current_time()
    #     response = self.client.get(
    #         "/us/live/login",
    #         headers=headers, stream=False)

    #     # if '"WatchListStorageMode":"Local"' not in response.text:
    #     #     print("Invalid Result, WatchListStorageMode need to be Local ")
    #     #     return
    #     if response.status_code == 0:
    #         return
    #     # print(response.text)
    #     waitForRandomTime(start_time, response)

    #     response.close()


class LSUser(HttpUser):
    tasks = [LSLoginTasks]
    min_wait = 1000
    max_wait = 5000


# $>  locust -f ./basic_http_ls_login.py -u 1 -r 1 --only-summary
# $>  locust -f ./basic_http_ls_login.py -u 100 -r 1 -H "http://localhost:8001"

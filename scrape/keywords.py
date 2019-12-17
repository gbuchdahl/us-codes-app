"""
Code adapted from:
https://github.com/anuragrana/Python-Scripts/blob/master/tweets_scrapper.py
https://www.earthdatascience.org/courses/earth-analytics-python/using-apis-natural-language-processing-twitter/calculate-tweet-word-frequencies-in-python/
"""


from bs4 import BeautifulSoup
import requests
import sys
import json
import re
import string

import os
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import itertools
import collections

import nltk
from nltk.corpus import stopwords

PAGE_SIZE = 15
API_KEY = "w4v9wu0Hrd7FhJ2jIZgwAMfNr81ZUvLOuEDtQhYH"
FRONT_URL = "https://api.govinfo.gov/packages/USCODE-2012-title"


def pull_title(title_no):
    offset = 0
    url = FRONT_URL + str(title_no) + f"/granules"
    res = hit_granules(url, offset)
    res = json.loads(res)
    granules = res["granules"]
    text = []

    # while res["nextPage"]:
    #     offset += PAGE_SIZE
    #     res = hit_granules(url, offset)
    #     res = json.loads(res)
    #     granules.extend(res["granules"])

    for granule in granules:

        # We are dealing with a section
        if granule["granuleClass"] == "LEAF":
            # Get the body of the section
            link = granule["granuleLink"]
            text.append(get_txt_from_granule_url(link))

    return text


def hit_granules(url, offset):
    payload = {"offset": offset, "pageSize": PAGE_SIZE, "api_key": API_KEY}
    result = requests.get(url, params=payload)
    if result.status_code != 200:
        print("ERROR")
        exit(1)
    return result.text


def get_txt_from_granule_url(url):
    payload = {"api_key": API_KEY}
    res = requests.get(url, params=payload)
    res = json.loads(res.text)
    txt_link = res["download"]["txtLink"]
    res = requests.get(txt_link, params=payload).text
    clean_text = BeautifulSoup(res, "lxml").text
    return clean_text


def clean_text(tweets):

    ## get a lowercase version of each word in every tweet
    words = [tweet.lower().split() for tweet in tweets]

    ## flatten our list
    words = list(itertools.chain(*words))

    ## remove all the useless words from tweets
    # nltk.download('stopwords')
    stop_words = set(stopwords.words("english"))
    stop_words.update(
        [
            "new",
            "add",
            "dont",
            "would",
            "one",
            "get",
            "think",
            "like",
            "many",
            "title",
            "united",
            "states",
            "stat",
            "shall",
            "usc",
            "authority",
            "secretary",
            "effective",
            "office",
            "pub",
            "law",
            "amended",
            "code",
            "section",
            "provision",
            "printed",
            "act",
            "laws",
            "provision",
            "bill",
            "government",
            "resolution",
            "pub.",
            "stat",
            "I",
            "|",
            "pub" "provisions",
            "general",
            "provided",
            "edition",
            "committee",
            "congress",
            "that",
            "hr",
            "",
            "code,",
            "-",
            "house",
            "sections",
            "chapter",
            "sec.",
            "form",
            "printing",
            "stat.",
            "president",
            "pursuant",
            "office,",
        ]
    )
    words = [s.translate(str.maketrans("", "", string.punctuation)) for s in words]
    words = [word for word in words if not word in stop_words]
    words = [word for word in words if len(word) > 3]
    words = [word for word in words if not word.isnumeric()]
    return words


def plot_words(counts, num, title):
    clean_tweets_nsw = pd.DataFrame(counts.most_common(num), columns=["words", "count"])
    print(clean_tweets_nsw)
    fig, ax = plt.subplots(figsize=(8, 8))

    # Plot horizontal bar graph
    clean_tweets_nsw.sort_values(by="count").plot.barh(
        x="words", y="count", ax=ax, color="blue"
    )

    ax.set_title(f"Title {title} Keywords")

    plt.show()


def start(username=None):

    with open("keywords.txt", "w") as fp:
        for i in range(1, 55):
            print(f"Title {i}...")
            words = None
            try:
                words = pull_title(i)
            except KeyboardInterrupt:
                exit()
            except:
                words = []
            words = clean_text(words)
            counts = collections.Counter(words)
            # plot_words(counts, 30, i)
            # clean_tweets_nsw = pd.DataFrame(
            #     counts.most_common(20), columns=["words", "count"]
            # )
            tuples = counts.most_common(20)
            arr = [_tuple[0] for _tuple in tuples]
            counts = [_tuple[1] for _tuple in tuples]
            # fp.write(f"TITLE {i} WORDS\n------------------\n")
            # fp.write(repr(clean_tweets_nsw))
            fp.write(f"title{i}Words = {arr}\n\n")
            fp.write(f"title{i}Counts = {counts}")
            fp.write("\n\n\n\n")


# Driver code
if __name__ == "__main__":
    start("drabsnore")


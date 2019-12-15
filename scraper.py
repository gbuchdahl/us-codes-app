import requests
import json
import string
from bs4 import BeautifulSoup
import re

API_KEY = "w4v9wu0Hrd7FhJ2jIZgwAMfNr81ZUvLOuEDtQhYH"
FRONT_URL = "https://api.govinfo.gov/packages/USCODE-2012-title"
PAGE_SIZE = 1000


def main():
    open("test.json", "w").close()
    for i in range(1, 2):
        get_granules_list(i)


def get_granules_list(title_no):

    print(f"Doing title {title_no}")
    url = FRONT_URL + str(title_no) + f"/granules"
    offset = 0
    res = hit_granules(url, offset)
    res = json.loads(res)
    granules = res["granules"]

    while res["nextPage"]:
        offset += PAGE_SIZE
        res = hit_granules(url, offset)
        res = json.loads(res)
        granules.extend(res["granules"])

    with open("test.json", "a") as f:
        f.write(f"TITLE {str(title_no)} Chapter List:\n\n")
        for granule in granules:
            if granule["granuleClass"] == "TOPPARENT":
                f.write(f'\t{string.capwords(granule["title"].lower())}\n')
            if granule["granuleClass"] == "LEAF":
                f.write(f'\t\t{granule["title"].capitalize()}\n')
                print(f'fetching title {granule["title"].capitalize()}')
                link = granule["granuleLink"]
                text = get_txt_from_granule_url(link)
                f.write("\t\t\t" + f"{text}\n")


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
    body_text = re.sub("(([^§])|\n)*§.*\n*", "", clean_text, count=1)
    body_text = re.sub("\n\n*", r"\\n\\n\\t\\t\\t\\t", body_text)
    return body_text


if __name__ == "__main__":
    main()

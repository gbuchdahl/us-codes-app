import requests
import json
import string
from bs4 import BeautifulSoup
import re
import config

FRONT_URL = "https://api.govinfo.gov/packages/USCODE-2012-title"
PAGE_SIZE = 1000
API_KEY = config.API_KEY


def main():
    chapterList, chapterDescriptionList, sectionList, paragraphList = [], [], [], []

    for i in range(6, 53):
        try:
            chapterArr, chapterDescriptionArr, sectionArr, paragraphArr = pull_title(i)
        except:
            print(f"error in #{i}")
            chapterArr, chapterDescriptionArr, sectionArr, paragraphArr = (
                [],
                [],
                [],
                [],
            )
        chapterList.append(chapterArr)
        sectionList.append(sectionArr)
        paragraphList.append(paragraphArr)
        chapterDescriptionList.append(chapterDescriptionArr)
        with open("template.txt", "r") as template:
            lines = template.readlines()
            with open(f"../lib/data/data{i}.dart", "w") as f:
                if i == 1:
                    f.writelines(lines)
                f.write("\n\nfinal chapterList = ")
                f.write(str(chapterList))
                f.write(";\n\n\n")
                f.write("final chapterSectionList = ")
                f.write(str(chapterDescriptionList))
                f.write(";\n\n\n")
                f.write("final sectionList = ")
                f.write(str(sectionList))
                f.write(";\n\n\n")
                f.write("final paragraphList = ")
                f.write(str(paragraphList))
                f.write(";\n\n\n")


def pull_title(title_no):

    print(f"\n\nDoing title {title_no}")
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

    chapterArr, chapterDescriptionArr, sectionArr, paragraphArr = [], [], [], []
    # chapter_i = -1
    current_section = []
    current_paragraphs = []
    first = True

    for granule in granules:

        # This means that we are dealing with a chapter heading
        # We restart all of our counters
        if granule["granuleClass"] == "TOPPARENT":
            if first:
                first = False
            else:
                # reset the section/paragraph stuff
                sectionArr.append(current_section)
                current_section = []
                paragraphArr.append(current_paragraphs)
                current_paragraphs = []

            print("*", end="", flush=True)
            # get the info on sections
            number_string = "n/a"
            try:
                number_string = get_section_numbers(granule["granuleLink"])
            except:
                print("ERROR")

            chapterDescriptionArr.append(number_string)

            # store the name of the next chapter
            chapterArr.append(string.capwords(granule["title"].lower()))

        # We are dealing with a section
        if granule["granuleClass"] == "LEAF":
            print(".", end="", flush=True)

            # store the body of the section
            current_section.append(granule["title"].capitalize())

            # Get the body of the section
            link = granule["granuleLink"]
            text = get_txt_from_granule_url(link)
            current_paragraphs.append(text)

    sectionArr.append(current_section)
    paragraphArr.append(current_paragraphs)

    return chapterArr, chapterDescriptionArr, sectionArr, paragraphArr


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
    body_text = body_text.replace("$", "€")
    body_text = re.sub("\n\n*", r"\n\n\t\t\t\t", body_text)
    return body_text


def get_section_numbers(url):
    payload = {"api_key": API_KEY}
    res = requests.get(url, params=payload)
    res = json.loads(res.text)
    info = res["leafRange"]
    small, big = info["from"], info["to"]
    if small != big:
        return f"Sections {small} - {big}"
    else:
        return f"Section {small}"


if __name__ == "__main__":
    main()

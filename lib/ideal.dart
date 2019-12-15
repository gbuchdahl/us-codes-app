// chapterList = [["T1 Chapter 1", "T1 Chapter 2", etc.], ["T2 Chapter 1", "T2 Chapter 2", etc.], etc.]
// chapterDescriptionList = [["Sections {Section #min} - {Section #max}", etc.], etc.]
// ^^^ chapDescription is last priority

// sectionList = [[["T1 C1 S1", "T1 C1 S2", etc.], ["T1 C2 S1", "T1, C2, S2", etc.]], ["T2 C1 S1", etc.]];

// paragraphList = [[[["Text"]]]];




// ROAD-MAP:

// for each title TITLE_INDEX:
    // generate list of chapter headings
        // put these as array of strings in index TITLE_INDEX of chapterList[TITLE_INDEX]

    // for each chapter CHAPTER_INDEX:
        // generate list of section headings
            // put these as array of strings in sectionList[TITLE_INDEX][CHAPTER_INDEX]

        // for each section SECTION_INDEX:
            // generate list of paragraphs (ie. the real wording)
                // put these as A SINGLE STRING in paragraphList[TITLE_INDEX][CHAPTER_INDEX][SECTION_INDEX][0]


                // for string, format it as follows:
                    // if a new line is reached, print a \n\n\t\t\t\t in string


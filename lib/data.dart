class Section {
  String title;
  int number;
  String paragraph;
  String annotation;

  Section(this.title, this.number, this.paragraph, this.annotation);
}

final List indexes = List<int>.generate(54, (i) => i+1);

final List lowerTitleList = List<String>.generate(titleList.length, (i) => titleList[i].toLowerCase());

final List titleList = [
  "General Provisions",
  "The Congress",
  "The President",
  "Flag and Seal, Seat of Government, and the States",
  "Government Organization and Employees",
  "Domestic Security",
  "Agriculture",
  "Aliens and Nationality",
  "Arbitration",
  "Armed Forces",
  "Bankruptcy",
  "Banks and Banking",
  "Census",
  "Coast Guard",
  "Commerce and Trade",
  "Conservation",
  "Copyrights",
  "Crimes and Criminal Procedure",
  "Customs Duties",
  "Education",
  "Food and Drugs",
  "Foreign Relations and Intercourse",
  "Highways",
  "Hospitals and Asylums",
  "Indians",
  "Internal Revenue Code",
  "Intoxicating Liquors",
  "Judiciary and Judicial Procedure",
  "Labor",
  "Mineral Lands and Mining",
  "Money and Finance",
  "National Guard",
  "Navigation and Navigable Waters",
  "Crime Control and Law Enforcement",
  "Patents",
  "Patriotic Societies and Observances",
  "Pay and Allowances of the Uniformed Services",
  "Veterans' Benefits",
  "Postal Service",
  "Public Buildings, Properties, and Works",
  "Public Contracts",
  "The Public Health and Welfare",
  "Public Lands",
  "Public Printing and Documents",
  "Railroads",
  "Shipping",
  "Telecommunications",
  "Territories and Insular Possessions",
  "Transportation",
  "War and National Defense",
  "National and Commercial Space Programs",
  "Voting and Elections",
  "Reserved",
  "National Park Service and Related Programs"
];

final titleDescriptionList = [
  "Title 1 of the United States Code outlines the general provisions of the United States Code.",
  "Title 2 of the United States Code outlines the role of Congress in the United States Code.",
  "Title 3 of the United States Code outlines the role of the President of the United States in the United States Code.",
  "Title 4 of the United States Code outlines the role of flag of the United States, Great Seal of the United States, Washington, DC, and the states in the United States Code.",
  "Title 5 of the United States Code outlines the role of government organization and employees in the United States Code.",
  "Title 6 of the United States Code is a non-positive law title of the United States Code that governs Domestic Security.",
  "Title 7 of the United States Code outlines the role of agriculture in the United States Code.",
  "Title 8 of the United States Code codifies statutes relating to aliens and nationality in the United States Code.",
  "Title 9 of the United States Code outlines the role of arbitration in the United States Code.",
  "Title 10 of the United States Code outlines the role of armed forces in the United States Code.",
  "Title 11 of the United States Code is the source of bankruptcy law in the United States Code.",
  "Title 12 of the United States Code outlines the role of Banks and Banking in the United States Code.",
  "Title 13 of the United States Code outlines the role of the United States Census in the United States Code.",
  "Title 14 of the United States Code outlines the role of the United States Coast Guard in the United States Code.",
  "Title 15 of the United States Code outlines the role of commerce and trade in the United States Code.",
  "Title 16 of the United States Code outlines the role of conservation in the United States Code.",
  "Title 17 of the United States Code is the United States Code that outlines United States copyright law.",
  "Title 18 of the United States Code is the main criminal code of the federal government of the United States.",
  "Title 19 of the United States Code outlines the role of customs and duties in the United States Code.",
  "Title 20 of the United States Code outlines the role of education in the United States Code.",
  "Title 21 of the United States Code governs Food and Drugs in the United States Code.",
  "Title 22 of the United States Code outlines the role of foreign relations and intercourse in the United States Code.",
  "Title 23 of the United States Code outlines the role of highways in the United States Code.",
  "Title 24 of the United States Code outlines the role of hospitals and psychiatric hospitals in the United States Code.",
  "Title 25 of the United States Code outlines the role of Indians in the United States Code.",
  "Title 26 of the United States Codee outlines the domestic portion of federal statutory tax law in the United States.",
  "Title 27 of the United States Code outlines the role of intoxicating liquors in the United States Code.",
  "Title 28 of the United States Code governs the federal judicial system.",
  "Title 29 of the United States Code is a code that outlines labor regulations in the United States.",
  "Title 30 of the United States Code outlines the role of mineral lands and mining in the United States Code.",
  "Title 31 of the United States Code outlines the role of the money and finance in the United States Code.",
  "Title 32 of the United States Code outlines the role of the United States National Guard in the United States Code.",
  "Title 33 of the United States Code outlines the role of navigable waters in the United States Code.",
  "Title 34 of the United States Code outlines the enforcement and control of criminal law in the United States Code.",
  "Title 35 of the United States Code outlines patent law in the United States.",
  "Title 36 of the United States Code outlines all patriotic and national observances for the United States.",
  "Title 37 of the United States Code outlines the role of Pay and Allowances of the Uniformed Services in the United States Code.",
  "Title 38 of the United States Code outlines the role of Veterans' Benefits in the United States Code.",
  "Title 39 of the United States Code outlines the role of United States Postal Service in the United States Code.",
  "Title 40 of the United States Code outlines the role of Public Buildings, Properties, and Public Works in the United States Code.",
  "Title 41 of the United States Code consists of federal statutes regarding public contracts in the United States Code.",
  "Title 42 of the United States Code is the United States Code dealing with public health, social welfare, and civil rights.",
  "Title 43 of the United States Code outlines the role of Public Lands in the United States Code.",
  "Title 44 of the United States Code outlines the role of public printing and documents in the United States Code.",
  "Title 45 of the United States Code outlines the role of rail transport in the United States Code.",
  "Title 46 of the United States Code outlines the role of shipping in the United States Code.",
  "Title 47 of the United States Code defines the role and structure of the United States Department of Commerce.",
  "Title 48 of the United States Code outlines the role of United States territories and insular areas in the United States Code.",
  "Title 49 of the United States Code is a code that regards the role of transportation in the United States of America.",
  "Title 50 of the United States Code outlines the role of War and National Defense in the United States Code.",
  "Title 51 of the United States Code is the compilation of the general laws regarding space programs.",
  "Title 52 of the United States Code is a codification of the \"general and permanent\" voting and election laws of the United States federal government.",
  "Title 53 is reserved.",
  "Title 54 of the United States Code is the compilation of the general laws regarding the National Park Service.",
];

final chapterList = [
  ["Rules of Construction",
    "Acts and Resolutions; Formalities of Enactment; Repeals; Sealing of Instruments",
  "Code of Laws of United States and Supplements"],
  ["Election of Senators and Representatives", "Organization of Congress", "Compensation and Allowances of Members", "Officers and Employees of Senate and House of Representatives", "Library of Congress", "Congressional and Committeee Procedure", "Contested Elections", "Federal Corrupt Practices", "Regulation of Lobbying", "Office of Legislative Counsel", "Office of Law Revision Counsel", "Legislativee Classification Office", "Office of Parliamentarian of House of Representatives", "Office of Senate Legal Counsel", "Classification of Employees of House of Representatives", "Payroll Administration in House of Representatives", "Citizens' Commission on Public Service and Compensation", "Contested Elections", "Joint Committeee on Congressional Operations", "Federal Election Campaigns", "Office of Technology Assessment", "Congressional Mailing Standards", "Congressional Budget Office", "Congressional Budget and Fiscal Operations", "Impoundment Control", "Legislative Personnel Financial Disclosure Requirements", "Congressional Award Program", "John Heinz Competitive Excellence Award", "Emergency Powers to Eliminate Budget Deficits"]
];

final chapterSectionList = [
  ["Sections 1 - 8", "Sections 101 - 114", "Sections 201 - 213"],
  ["Sections 1 - 9", "Sections 9 - 33b", "Sections 31 - 59h", "Sections 60 - 130l", "Sections 131 - 185", "Sections 190 - 199", "Section 201", "Sections 241 - 252", "Section 261", "Sections 271 - 282e", "Sections 285 - 285g", "Section 286", "Sections 287 - 287d", "Sections 288 - 288n", "Sections 291 - 303", "Sections 331 - 336", "Sections 351 - 364", "Sections 381 - 396", "Section 411", "Sections 431 - 457", "Sections 471 - 481", "Sections 501 - 506", "Sections 601 - 613", "Sections 621 - 665", "Subchapters I - III", "Section 701", "Sections 801 - 811", "Section 831", "Sections 900 - 922"], // up to 20
];

final sectionList = [
  [
    ["Words denoting number, gender, and so forth",
    "\"County\" as including \"parish\", and so forth",
    "\"Vessel\" as including all means of water transportation",
    "\"Vehicle\" as including all means of land transportation",
    "\"Company\" or \"association\" as including successors and assigns",
    "Limitation of term \"products of American fisheries\"",
    "Definition of \"marriage\" and \"spouse\"",
    "\"Person\", \"human being\", \"child\", and \"individual\" as including born-alive infant",
    ],
  ]
];

final paragraphList = [
  [
    [
      ["Paragraph 1"]
    ]
  ]
];
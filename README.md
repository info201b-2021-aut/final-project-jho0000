John Ho, Lucy Lin, Brianna Pak, Devina Tavathia, Kelly Wang   
**The Kaggle csv files was too large, so please use the link instead to access the data, the link includes the whole data on their website**

# Domain of Interest

*Why are you interested in this field/domain?*

We all bonded over a similar interest in watching and reading about murder. We are interested in data in fields of criminal justice, homicide, and murder mysteries. We want to learn about the motives, correlations, and data trends of homicide in the US.

*What other examples of data driven projects have you found related to this domain (share at least 3)?*

[Seattle WA Murder/Homicide Rate 1999-2018 | MacroTrends](https://www.macrotrends.net/cities/us/wa/seattle/murder-homicide-rate-statistics)

[Washington State Criminal Activity 1990 - 2020 | Washington State Statistical Analysis Center](https://sac.ofm.wa.gov/data)

[Intentional homicide victims by sex, counts and rates per 100,000 population](https://data.un.org/DocumentData.aspx?q=murder&id=431)

*What data-driven questions do you hope to answer about this domain (**share at least 3**)?*

- How do factors of the perpetrator and victim (ex. age, race, etc.) correlate?
- Are there trends between perpetrator age and homicide type?
- What are the comparisons of homicide rates between other states?
- Which cities of each state have the most homicide? Any concentrations?
- How do current homicide rates within this decade compare to rates from previous decades (ex. 1980-1990, 1990-2000)?


# Finding Data

*Where did you download the data (e.g., a web URL)?*

We searched through recommended websites domains and used “homicide” and “murder” as our keywords. Kaggle, National Archive of Criminal Justice Data (NACJD), and MacroTrends were the ones we ended up on.

*How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?*

- The Kaggle data was collected by the FBI’s Supplementary Homicide Report and Freedom of Information Act and compiled by the Murder Accountability Project. It is stated that the database contains homicides dating back to 1976 plus the 22,000 not reported to the Justice Department, with classifications on race, sex, and age of both perpetrators and victims.

- Washington State Statistical Analysis Center collects state data from multiple agency sources. The Criminal Justice Databook collects information on reported crimes, arrests, prison admissions, and more. The dataset we are using contains information from 1990 - 2020 and has a column for murder rates, but also variables beyond this scope, such as assault, arson, and burglary.

- MacroTrends’ data is sourced from the FBI, reporting murder or homicide rates in every city in Washington from 1999 to 2018. Other types of crime not related to our project are recorded such as violent crimes, assault, robbery, and rape.

*How many observations (rows) are in your data?*

Kaggle: 638454 observations   
WSSAC: 1274 observations   
MacroTrends: 157 observations   

*How many features (columns) are in the data?*

Kaggle: 24 features   
WSSAC: 203 features   
MacroTrends: 3 features   

*What questions (from above) can be answered using the data in this dataset?*

- How do factors of the perpetrator and victim (ex. age, race, etc.) correlate?

The Kaggle dataset specifically has filters for victim age, race, and ethnicity. It also includes filters for perpetrator sex, age, race, and ethinicity. We will be using Kaggle to answer this question.

- Are there trends between perpetrator age and homicide type?

The trends between perpetrator age and homicide type can also be seen in the Kaggle dataset.

- What are the comparisons of homicide rates between other states?

There is a comparison chart for homicide rates in Washington State versus the US as a whole within the Macrotrends dataset. There is also potential for comparison across city (Seattle), state (Washington), and country (US). The Kaggle dataset also has an option to filter by state.

- Which cities of each state have the most homicide? Any concentrations?

Because the Kaggle dataset allows filtering by city and state, we will be able to answer this question through Kaggle.

- How do current homicide rates within this decade compare to rates from previous decades (ex. 2000-2018, 1990-2000)?

While the Macrotrends dataset contains data from 2000 to 2018 (it is the most recent), the WSSAC dataset contains data from 1990-2020. We will be able to compare across datasets and within datasets as well (the WSSAC data contains two decades).
